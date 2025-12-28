
class uart_monitor extends uvm_monitor;
	
	uart_xtn xtnh;
	
	uart_agent_config u_cfg;
	
	virtual uart_if.MON_MP vif;
		
	uvm_analysis_port #(uart_xtn) mon2sb;
		
	`uvm_component_utils(uart_monitor)
	
	function new (string name = "uart_monitor", uvm_component parent);	
		super.new(name, parent);	
		mon2sb = new("mon2sb", this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(!uvm_config_db #(uart_agent_config)::get(this, "","uart_agent_config",u_cfg))
			`uvm_fatal("uart monitor", "config failed")
		 	vif = u_cfg.vif;
			xtnh = uart_xtn::type_id::create("uart_monitor");
	endfunction
	
	task run_phase (uvm_phase phase);
		forever 
			collect_data;
	endtask
	
	
	task collect_data;		
		while(vif.mon_cb.Psel !== 1)
		@(vif.mon_cb);
	
		begin
			while(vif.mon_cb.Pready !== 1)
			@(vif.mon_cb);
			
			xtnh.Presetn 	= 	vif.mon_cb.Presetn;
			xtnh.Paddr 		= 	vif.mon_cb.Paddr;
			xtnh.Pwrite 	= 	vif.mon_cb.Pwrite;
			xtnh.Pwdata 	= 	vif.mon_cb.Pwdata;
			xtnh.Prdata 	= 	vif.mon_cb.Prdata;
			xtnh.Pslverr 	=	vif.mon_cb.Pslverr;
			xtnh.Penable 	= 	vif.mon_cb.Penable;
			xtnh.IRQ 	= 	vif.mon_cb.IRQ;
			xtnh.baud_o	= 	vif.mon_cb.baud_o;
			xtnh.Pready	= 	vif.mon_cb.Pready;
			xtnh.Psel       = vif.mon_cb.Psel;
			if(xtnh.Paddr == 32'h08 && xtnh.Pwrite == 0)
				begin
					while(vif.mon_cb.IRQ !==1)
						@(vif.mon_cb);
						
					xtnh.IRQ = vif.mon_cb.IRQ;
					xtnh.Prdata = vif.mon_cb.Prdata;
					xtnh.IIR = xtnh.Prdata;
				end

			@(vif.mon_cb);
	
			//LCR
			if(xtnh.Paddr == 32'h0c && xtnh.Pwrite == 1)
				xtnh.LCR = xtnh.Pwdata;
	
			//IER
			if(xtnh.Paddr == 32'h04 && xtnh.Pwrite == 1)
				xtnh.IER = xtnh.Pwdata;
			
			//FCR
			if(xtnh.Paddr == 32'h08 && xtnh.Pwrite == 1)
				xtnh.FCR = xtnh.Pwdata;
		
			//IIR
					
			//MCR
			if(xtnh.Paddr == 32'h010 && xtnh.Pwrite == 1)
				xtnh.MCR = xtnh.Pwdata;
			
			//LSR
			if(xtnh.Paddr == 32'h014 && xtnh.Pwrite == 0)
				xtnh.LSR = xtnh.Prdata;
		
			//DIV1 LSB
			if(xtnh.Paddr == 32'h01c && xtnh.Pwrite == 1)
				xtnh.DIV2 = xtnh.Pwdata;
			
			//DIV2 MSB
			if(xtnh.Paddr == 32'h020 && xtnh.Pwrite == 1)
				xtnh.DIV1 = xtnh.Pwdata;
			
			//THR
			if(xtnh.Paddr == 32'h00 && xtnh.Pwrite == 1)
				begin
					//xtnh.data_in_thr = 1'b1;
					xtnh.THR.push_back(xtnh.Pwdata);
				end
			
			//RBR
			if(xtnh.Paddr == 32'h00 && xtnh.Pwrite == 0)
				begin
					//xtnh.data_in_rbr = 1'b1;
					//$display("Prdata : %0h", xtnh.Prdata);
					xtnh.RBR.push_back(xtnh.Prdata);
				end

		
		end	
		`uvm_info("MONITOR", $sformatf("\n %p", xtnh.sprint), UVM_LOW)
		mon2sb.write(xtnh);
	endtask
		
endclass

			
		
					
		
		
