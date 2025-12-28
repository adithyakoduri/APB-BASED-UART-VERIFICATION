
class uart_driver extends uvm_driver #(uart_xtn);
	
	`uvm_component_utils(uart_driver)
	
	virtual uart_if.DRV_MP vif;
	
	uart_agent_config u_cfg;

	function new (string name = "uart_driver", uvm_component parent);	
		super.new(name, parent);	
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
			
		if(!uvm_config_db #(uart_agent_config)::get(this, "", "uart_agent_config", u_cfg))
			`uvm_fatal("uart_driver", "config falied")	
		
		vif = u_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
	@(vif.drv_cb);
	vif.drv_cb.Presetn <= 1'b0;
	@(vif.drv_cb);
	vif.drv_cb.Presetn <= 1'b1;
	
		forever
			begin
				seq_item_port.get_next_item(req);	
				send_to_dut(req);
				//req.print;
				seq_item_port.item_done;
			end
	endtask

	task send_to_dut(uart_xtn xtnh);
		//@(vif.drv_cb);
		vif.drv_cb.Paddr <= xtnh.Paddr;
		vif.drv_cb.Pwrite <= xtnh.Pwrite;
		vif.drv_cb.Pwdata <= xtnh.Pwdata;
		
		vif.drv_cb.Psel <= 1'b1;
		@(vif.drv_cb);

		vif.drv_cb.Penable <= 1'b1;	
		//@(vif.drv_cb)	

		while(vif.drv_cb.Pready !== 1)
		@(vif.drv_cb);
	
		if(xtnh.Paddr == 8 && xtnh.Pwrite == 0)
			begin
				while(vif.drv_cb.IRQ !== 1)
				@(vif.drv_cb);
				xtnh.IIR = vif.drv_cb.Prdata;
				seq_item_port.put_response(xtnh);
			end	
vif.drv_cb.Psel <= 1'b0;	
		vif.drv_cb.Penable <= 1'b0;
	
		`uvm_info("DRIVER", $sformatf("DATA FROM DRIVER \n %s", req.sprint), UVM_LOW)
		
	endtask
endclass
