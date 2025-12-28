class lcr_reg extends uvm_reg;
	`uvm_object_utils(lcr_reg)

	rand uvm_reg_field reserved;
	rand uvm_reg_field break_control;
	rand uvm_reg_field stick_parity;
	rand uvm_reg_field even_odd;
	rand uvm_reg_field parity;
	rand uvm_reg_field stop_bit;
	rand uvm_reg_field word_len;

function new(string name = "lcr_reg");
		super.new(name,8,UVM_NO_COVERAGE);
endfunction 

	virtual function void build();
		word_len      = uvm_reg_field::type_id::create("word_len");
		stop_bit      = uvm_reg_field::type_id::create("stop_bit");
		parity        = uvm_reg_field::type_id::create("parity");
		even_odd      = uvm_reg_field::type_id::create("even_odd");
		stick_parity  = uvm_reg_field::type_id::create("stick_parity");
		break_control = uvm_reg_field::type_id::create("break_control");
		reserved      = uvm_reg_field::type_id::create("reserved");

	
		word_len      .configure(this,2,0,"RW",0,0   ,1,0,1);
		stop_bit      .configure(this,1,2,"RW",0,0   ,1,0,1);
		parity        .configure(this,1,3,"RW",0,0   ,1,0,1);
		even_odd      .configure(this,1,4,"RW",0,0   ,1,0,1);
		stick_parity  .configure(this,1,5,"RW",0,0   ,1,0,1);
		break_control .configure(this,1,6,"RW",0,0   ,1,0,1);
		reserved      .configure(this,1,7,"RW",0,0   ,1,0,0);
	endfunction
endclass


class fcr_reg extends uvm_reg;
	`uvm_object_utils(fcr_reg)

	rand uvm_reg_field threshold;
	rand uvm_reg_field reserved5_3;
	rand uvm_reg_field TX_flush;
	rand uvm_reg_field RX_flush;
	rand uvm_reg_field reserved_0;


function new(string name = "fcr_reg");
		super.new(name,8,UVM_NO_COVERAGE);
endfunction 

	virtual function void build();
		reserved_0      = uvm_reg_field::type_id::create("reserved_0");
		RX_flush        = uvm_reg_field::type_id::create("RX_flush");
		TX_flush        = uvm_reg_field::type_id::create("TX_flush");
		reserved5_3     = uvm_reg_field::type_id::create("reserved5_3");
		threshold       = uvm_reg_field::type_id::create("threshold");

		reserved_0      .configure(this,1,0,"RW",0,0,1,0,0);
		RX_flush        .configure(this,1,1,"RW",0,0,1,0,1);
		TX_flush        .configure(this,1,2,"RW",0,0,1,0,1);
		reserved5_3     .configure(this,3,3,"RW",0,0,1,0,0);
		threshold       .configure(this,2,6,"RW",0,0,1,0,1);
	endfunction
endclass

class ier_reg extends uvm_reg;
	`uvm_object_utils(ier_reg)

	rand uvm_reg_field interupt_0;
	rand uvm_reg_field interupt_1;
	rand uvm_reg_field interupt_2;
	rand uvm_reg_field interupt_3;
	rand uvm_reg_field reserved_7_4;


function new(string name = "ier_reg");
		super.new(name,8,UVM_NO_COVERAGE);
endfunction 

	virtual function void build();
		interupt_0         = uvm_reg_field::type_id::create("interupt_0");
		interupt_1         = uvm_reg_field::type_id::create("interupt_1");
		interupt_2         = uvm_reg_field::type_id::create("interupt_2");
		interupt_3         = uvm_reg_field::type_id::create("interupt_3");
		reserved_7_4       = uvm_reg_field::type_id::create("reserved_7_4");

		interupt_0    .configure(this,1,0,"RW",0,0,1,0,1);
		interupt_1    .configure(this,1,1,"RW",0,0,1,0,1);
		interupt_2    .configure(this,1,2,"RW",0,0,1,0,1);
		interupt_3    .configure(this,1,3,"RW",0,0,1,0,1);
		reserved_7_4  .configure(this,4,4,"RW",0,0,1,0,0);
	endfunction
endclass

class thr_reg extends uvm_reg;
	`uvm_object_utils(thr_reg)

	rand uvm_reg_field thr_data;

function new(string name = "thr_reg");
		super.new(name,8,UVM_NO_COVERAGE);
endfunction 
	
	virtual function void build();
		thr_data     = uvm_reg_field::type_id::create("thr_data");	
		thr_data    .configure(this,8,0,"RW",0,0,1,0,1);
	endfunction
endclass

class mcr_reg extends uvm_reg;
	`uvm_object_utils(mcr_reg)

	rand uvm_reg_field DTR;
	rand uvm_reg_field RTS;
	rand uvm_reg_field out1;
	rand uvm_reg_field out2;
	rand uvm_reg_field lb_mode;;
	rand uvm_reg_field reserved;



function new(string name = "iir_reg");
		super.new(name,8,UVM_NO_COVERAGE);
endfunction 

	virtual function void build();
		DTR       = uvm_reg_field::type_id::create("DTR");
		RTS       = uvm_reg_field::type_id::create("RTS");
		out1      = uvm_reg_field::type_id::create("out1");
		out2      = uvm_reg_field::type_id::create("out2");
		lb_mode   = uvm_reg_field::type_id::create("lb_mode");
		reserved  = uvm_reg_field::type_id::create("reserved");


		DTR        .configure(this,1,0,"RW",0,0,1,0,1);
		RTS        .configure(this,1,1,"RW",0,0,1,0,1);
		out1       .configure(this,1,2,"RW",0,0,1,0,1);
		out2       .configure(this,1,3,"RW",0,0,1,0,1);
		lb_mode    .configure(this,1,4,"RW",0,0,1,0,1);
		reserved   .configure(this,3,5,"RW",0,0,1,0,0);

	endfunction
endclass

class msr_reg extends uvm_reg;
	`uvm_object_utils(msr_reg)

	rand uvm_reg_field DCTS;
	rand uvm_reg_field DDSR;
	rand uvm_reg_field TERI;
	rand uvm_reg_field DDCD;
	rand uvm_reg_field CTS;
	rand uvm_reg_field DSR;
	rand uvm_reg_field RI;
	rand uvm_reg_field DCD;

function new(string name = "msr_reg");
		super.new(name,8,UVM_NO_COVERAGE);
endfunction 

	virtual function void build();
		DCTS       = uvm_reg_field::type_id::create("DCTS");
		DDSR       = uvm_reg_field::type_id::create("DDSR");
		TERI       = uvm_reg_field::type_id::create("TERI");
		DDCD       = uvm_reg_field::type_id::create("DDCD");
		CTS        = uvm_reg_field::type_id::create("CTS");
		DSR        = uvm_reg_field::type_id::create("DSR");
		RI         = uvm_reg_field::type_id::create("RI");
		DCD        = uvm_reg_field::type_id::create("DCD");




		DCTS        .configure(this,1,0,"RW",0,0,1,0,1);
		DDSR        .configure(this,1,1,"RW",0,0,1,0,1);
		TERI        .configure(this,1,2,"RW",0,0,1,0,1);
		DDCD        .configure(this,1,3,"RW",0,0,1,0,1);
		CTS         .configure(this,1,4,"RW",0,0,1,0,1);
		DSR         .configure(this,1,5,"RW",0,0,1,0,1);
		RI          .configure(this,1,6,"RW",0,0,1,0,1);
		DCD         .configure(this,1,7,"RW",0,0,1,0,1);


	endfunction
endclass

class lsr_reg extends uvm_reg;
	`uvm_object_utils(lsr_reg)

	rand uvm_reg_field DR;
	rand uvm_reg_field OE;
	rand uvm_reg_field PE;
	rand uvm_reg_field FE;
	rand uvm_reg_field BI;
	rand uvm_reg_field T_FIFO_E;
	rand uvm_reg_field TE;
	rand uvm_reg_field FIFO_E;

function new(string name = "lsr_reg");
		super.new(name,8,UVM_NO_COVERAGE);
endfunction 

	virtual function void build();
		DR       = uvm_reg_field::type_id::create("DR");
		OE       = uvm_reg_field::type_id::create("OE");
		PE       = uvm_reg_field::type_id::create("PE");
		FE       = uvm_reg_field::type_id::create("FE");
		BI       = uvm_reg_field::type_id::create("BI");
		T_FIFO_E = uvm_reg_field::type_id::create("T_FIFO_E");
		TE       = uvm_reg_field::type_id::create("TE");
		FIFO_E   = uvm_reg_field::type_id::create("FIFO_E");




		DR        .configure(this,1,0,"RW",0,0,1,0,1);
		OE        .configure(this,1,1,"RW",0,0,1,0,1);
		PE        .configure(this,1,2,"RW",0,0,1,0,1);
		FE        .configure(this,1,3,"RW",0,0,1,0,1);
		BI        .configure(this,1,4,"RW",0,0,1,0,1);
		T_FIFO_E  .configure(this,1,5,"RW",0,0,1,0,1);
		TE        .configure(this,1,6,"RW",0,0,1,0,1);
		FIFO_E    .configure(this,1,7,"RW",0,0,1,0,1);


	endfunction
endclass

