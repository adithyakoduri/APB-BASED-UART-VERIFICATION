class uart_reg_block extends uvm_reg_block;
	
	`uvm_object_utils(uart_reg_block)
	
	rand lcr_reg lcr;
	rand fcr_reg fcr;
	rand ier_reg ier;
	rand mcr_reg mcr;
        rand msr_reg msr;
	rand lsr_reg lsr;
		
function new(string name = "uart_reg_block");
	super.new(name,UVM_NO_COVERAGE);
endfunction 

virtual function void build();

	lcr = lcr_reg::type_id::create("lcr");
	fcr = fcr_reg::type_id::create("fcr");
	ier = ier_reg::type_id::create("ier");
	mcr = mcr_reg::type_id::create("mcr");
	msr = msr_reg::type_id::create("msr");
	lsr = lsr_reg::type_id::create("lsr");
	

	

	lcr.configure(this,null,"");
	fcr.configure(this,null,"");
	ier.configure(this,null,"");
	mcr.configure(this,null,"");
	msr.configure(this,null,"");
	lsr.configure(this,null,"");
	
		
	lcr.build();
	fcr.build();
	ier.build();
	mcr.build();
	msr.build();
	lsr.build();
	
	default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN);

	default_map.add_reg(lcr,'hc, "RW");
	default_map.add_reg(fcr,'h8, "RW");
	default_map.add_reg(ier,'h4, "RW");
	default_map.add_reg(mcr,'h10,"RW");
	default_map.add_reg(msr,'h18,"RW");
	default_map.add_reg(lsr,'h14,"RW");

	lcr.add_hdl_path_slice("LCR",0,7);
	fcr.add_hdl_path_slice("FCR",0,7);
	ier.add_hdl_path_slice("IER",0,7);
	mcr.add_hdl_path_slice("MCR",0,7);
	msr.add_hdl_path_slice("MSR",0,7);
	lsr.add_hdl_path_slice("LSR",0,7);
	
	
	add_hdl_path("uart_tb_top.DUV1.control","RTL");
	
	


endfunction 
endclass	
