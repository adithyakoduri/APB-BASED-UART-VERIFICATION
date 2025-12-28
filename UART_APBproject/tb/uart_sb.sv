class uart_sb extends uvm_scoreboard;

  `uvm_component_utils(uart_sb)

  // -------------------------------------------------
  // CONFIG
  // -------------------------------------------------
  uart_env_config e_cfg;
uart_reg_block regmodel;
uvm_status_e status;
  // -------------------------------------------------
  // FIFOs FROM MONITORS
  // -------------------------------------------------
  uvm_tlm_analysis_fifo #(uart_xtn) fifo_h[];

  // -------------------------------------------------
  // TRANSACTION HANDLES
  // -------------------------------------------------
  uart_xtn uart1, uart2;
  uart_xtn last_uart1, last_uart2;
  uart_xtn cov_data;

  int success, failed;
  bit[7:0] lcr_reg;
  bit[7:0] fcr_reg;
  bit[7:0] ier_reg;
  bit[7:0] mcr_reg;
  bit[7:0] msr_reg;
  bit[7:0] lsr_reg;
  bit[7:0] iir_reg;

  // =================================================
  // COVERGROUPS
  // =================================================
  covergroup apb_signals_cov;
    option.per_instance = 1;
    ADDRESS : coverpoint cov_data.Paddr { bins add = {[0:255]}; }
    WR_ENB  : coverpoint cov_data.Pwrite { bins rd = {0}; bins wr = {1}; }
    //ERROR   : coverpoint cov_data.Pslverr { bins ok = {0}; bins err = {1}; }
  endgroup

  covergroup uart_lcr_cov;
    option.per_instance = 1;
    CHAR_SIZE : coverpoint cov_data.LCR[1:0] { bins five = {2'b00}; bins eight = {2'b11}; }
    STOP_BIT  : coverpoint cov_data.LCR[2]{bins one ={1'b0};bins more={1'b1}; }
    PARITY    : coverpoint cov_data.LCR[3]{bins no_parity={1'b0}; bins parity_en={1'b1}; }
  endgroup

  covergroup uart_ier_cov;
    option.per_instance = 1;
    RCVD_INT : coverpoint cov_data.IER[0]{bins dis={1'b0}; bins en={1'b1}; }
    THRE_INT : coverpoint cov_data.IER[1]{bins dis={1'b0}; bins en={1'b1}; }

    LSR_INT  : coverpoint cov_data.IER[2]{bins dis={1'b0}; bins en={1'b1}; }
IER_RST: coverpoint cov_data.IER[7:0]{ bins ier_rst = {8'd0};}
  endgroup

  covergroup uart_fcr_cov;
    option.per_instance = 1;
    RFIFO   : coverpoint cov_data.FCR[1]{ bins dis = {1'b0};
bins clr = {1'b1}; }
    IFIFO   : coverpoint cov_data.FCR[2]{ bins dis = {1'b0};
bins clr = {1'b1}; }
    TRG_LVL : coverpoint cov_data.FCR[7:6]{ bins one = {2'b00};
// bins four = {2'b01};
bins eight = {2'b10};
bins fourteen = {2'b11}; }
  endgroup

  covergroup uart_mcr_cov;
    option.per_instance = 1;
LB: coverpoint cov_data.MCR[4] {bins dis = {1'b0};
bins en = {1'b1}; }
MCR_RST: coverpoint cov_data.MCR[7:0] { bins lcr_rst = {8'd0};}
     endgroup

  covergroup uart_iir_cov;
    option.per_instance = 1;
    IIR: coverpoint cov_data.IIR[3:1] {bins lsr = {3'b011};
bins rdf = {3'b010};
bins ti_o = {3'b110};}
  endgroup

  covergroup uart_lsr_cov;
 option.per_instance = 1;
 DATA_READY: coverpoint cov_data.LSR[0] {bins fifoempty = {1'b0};
bins datarcvd = {1'b1}; }
OVER_RUN: coverpoint cov_data.LSR[1] {bins nooverrun = {1'b0};
bins overrun = {1'b1}; }
PARITY_ERR: coverpoint cov_data.LSR[2] {bins noparityerr = {1'b0};
bins parityerr = {1'b1} ;}
FRAME_ERR: coverpoint cov_data.LSR[3] {
bins frameerr = {1'b0}; }
BREAK_INT: coverpoint cov_data.LSR[4] {bins nobreakint= {1'b0};
bins breakint = {1'b1}; }
BL: coverpoint cov_data.LSR[5] {bins al = {1'b0};
bins a2 = {1'b1}; }
  endgroup

  // =================================================
  // CONSTRUCTOR
  // =================================================
  function new(string name="uart_sb", uvm_component parent);
    super.new(name,parent);
    apb_signals_cov = new();
    uart_lcr_cov    = new();
    uart_ier_cov    = new();
    uart_fcr_cov    = new();
    uart_mcr_cov    = new();
    uart_iir_cov    = new();
    uart_lsr_cov    = new();
  endfunction

  // =================================================
  // BUILD PHASE
  // =================================================
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(uart_env_config)::get(this,"","uart_env_config",e_cfg))
      `uvm_fatal("SB","UART ENV CONFIG NOT FOUND")
    regmodel=e_cfg.regmodel;
    fifo_h = new[e_cfg.no_of_uart_agents];
    foreach(fifo_h[i])
      fifo_h[i] = new($sformatf("fifo_h[%0d]",i),this);
  endfunction

  // =================================================
  // RUN PHASE – RECEIVE + COVERAGE
  // =================================================
  task run_phase(uvm_phase phase);
    fork
      forever begin
        fifo_h[0].get(uart1);
        last_uart1 = uart1;
        cov_data   = uart1;
        sample_cov();
      end

      forever begin
        fifo_h[1].get(uart2);
        last_uart2 = uart2;
        cov_data   = uart2;
        sample_cov();
        
      end
    join

  endtask

  // =================================================
  // COVERAGE SAMPLING
  // =================================================
  task sample_cov();
    apb_signals_cov.sample();
    uart_lcr_cov.sample();
    uart_ier_cov.sample();
    uart_fcr_cov.sample();
    uart_mcr_cov.sample();
    uart_iir_cov.sample();
    uart_lsr_cov.sample();
    ral;
  endtask

  // =================================================
  // CHECK PHASE – YOUR REQUIRED STYLE + ALL ERRORS
  // =================================================
  function void check_phase (uvm_phase phase);
    super.check_phase(phase);

    uart1 = last_uart1;
    uart2 = last_uart2;

    // ---------------- PRINT DATA ----------------
    foreach(uart1.THR[i])
      $display("UART1 SENT [%0d] = %0h", i, uart1.THR[i]);
    foreach(uart2.RBR[i])
      $display("UART2 RCVD [%0d] = %0h", i, uart2.RBR[i]);

    foreach(uart2.THR[i])
      $display("UART2 SENT [%0d] = %0h", i, uart2.THR[i]);
    foreach(uart1.RBR[i])
      $display("UART1 RCVD [%0d] = %0h", i, uart1.RBR[i]);

    // ---------------- DUPLEX CHECK ----------------
    begin
				if((uart1.THR.size != 0 && uart1.THR == uart2.RBR) && (uart2.THR.size != 0 && uart2.THR == uart1.RBR)) begin
					compare(uart1, uart2);
					`uvm_info("Score_Board", "FULL DUPLEX SUCCESSFULLY COMPARED", UVM_LOW)
				end			
				else if((uart1.THR.size != 0 && uart1.THR == uart2.RBR) || (uart2.THR.size != 0 && uart2.THR == uart1.RBR)) begin
					compare(uart1, uart2);
					`uvm_info("Score_Board", "HALF DUPLEX SUCCESSFULLY COMPARED", UVM_LOW)	
				end				
				else
					begin
						if((uart1.THR.size != 0 && uart1.THR == uart1.RBR) || (uart2.THR.size != 0 && uart2.THR == uart2.RBR)) begin
							success++;
							`uvm_info("Score_Board", "LOOPBACK COMPARED", UVM_LOW)
						end
					end
			end

		if((uart1.IIR[3:1] == 3) || (uart2.IIR[3:1] == 3))
			begin
				if((uart1.LSR[1] == 1) || (uart2.LSR[1] == 1))
					begin
							success++;
					`uvm_info("Score_Board", "OVERRUN ERROR COMPARED", UVM_LOW)
						end
				
				if((uart1.LSR[2] == 1) || (uart2.LSR[2] == 1))
					begin
							success++;
					`uvm_info("Score_Board", "PARITY ERROR COMPARED", UVM_LOW)
						end
			
				if((uart1.LSR[3] == 1) || (uart2.LSR[3] == 1))
					begin
							success++;
					`uvm_info("Score_Board", "FRAMING ERROR COMPARED", UVM_LOW)
						end
				
				if((uart1.LSR[4] == 1) || (uart2.LSR[4] == 1))
					begin
							success++;
					`uvm_info("Score_Board", "BREAK ERROR COMPARED", UVM_LOW)
						end
			end
	
		
		if((uart1.LCR == 8'd11 && uart1.IIR[3:1] == 3'b110) || (uart2.LCR == 8'd11 && uart2.IIR[3:1] == 3'b110))
					begin
							success++;
			`uvm_info("Score_Board", "TIME OUT ERROR COMPARED", UVM_LOW)
						end

		if((uart1.IIR[3:1] == 3'b001) || (uart2.IIR[3:1] == 3'b001))
					begin
							success++;
			`uvm_info("Score_Board", "EMPTY ERROR COMPARED", UVM_LOW)
						end
	
		
	endfunction

   function void compare(uart_xtn u1, uart_xtn u2);
    if(u1.THR != u2.RBR || u2.THR != u1.RBR) begin
      failed++;
      `uvm_error("Score_Board","DATA MISMATCH")
    end
    else
      success++;
  endfunction

  task ral();
    begin
      regmodel.lcr.read(
        status,
        lcr_reg,
        UVM_BACKDOOR,
        .map(regmodel.default_map)
      );

      `uvm_info("REG",
                $sformatf("@@@@@@@@@@@ LCR %0d", lcr_reg),
                UVM_NONE)

      if (cov_data.LCR == lcr_reg)
        `uvm_info("REG_comp",
                  "############# LCR MATCHED",
                  UVM_LOW)

 regmodel.fcr.read(
        status,
        fcr_reg,
        UVM_BACKDOOR,
        .map(regmodel.default_map)
      );

      `uvm_info("REG",
                $sformatf("@@@@@@@@@@@ FCR %0d", fcr_reg),
                UVM_NONE)

      if (cov_data.FCR == fcr_reg)
        `uvm_info("REG_comp",
                  "############# FCR MATCHED",
                  UVM_LOW)




regmodel.ier.read(
        status,
        ier_reg,
        UVM_BACKDOOR,
        .map(regmodel.default_map)
      );

      `uvm_info("REG",
                $sformatf("@@@@@@@@@@@ IER %0d", ier_reg),
                UVM_NONE)

      if (cov_data.IER == ier_reg)
        `uvm_info("REG_comp",
                  "############# IER MATCHED",
                  UVM_LOW)



/*regmodel.mcr.read(
        status,
        mcr_reg,
        UVM_BACKDOOR,
        .map(regmodel.default_map)
      );

      `uvm_info("REG",
                $sformatf("@@@@@@@@@@@ MCR %0d", mcr_reg),
                UVM_NONE)

      if (cov_data.MCR == mcr_reg)
        `uvm_info("REG_comp",
                  "############# MCR MATCHED",
                  UVM_LOW)

regmodel.msr.read(
        status,
        msr_reg,
        UVM_BACKDOOR,
        .map(regmodel.default_map)
      );

      `uvm_info("REG",
                $sformatf("@@@@@@@@@@@ MSR %0d", msr_reg),
                UVM_NONE)

      if (cov_data.MSR == msr_reg)
        `uvm_info("REG_comp",
                  "############# MSR MATCHED",
                  UVM_LOW)


regmodel.lsr.read(
        status,
        lsr_reg,
        UVM_BACKDOOR,
        .map(regmodel.default_map)
      );

      `uvm_info("REG",
                $sformatf("@@@@@@@@@@@ LSR %0d", lsr_reg),
                UVM_NONE)

      if (cov_data.LSR == lsr_reg)
        `uvm_info("REG_comp",
                  "############# LSR MATCHED",
                  UVM_LOW)*/

    end
  endtask


    
endclass
