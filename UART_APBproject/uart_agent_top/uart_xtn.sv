class uart_xtn extends uvm_sequence_item;
	
	`uvm_object_utils(uart_xtn)
	
	bit Presetn;
	rand bit [31:0] Paddr, Pwdata, Prdata;
	rand bit Pwrite; 
	bit Penable, Psel, Pslverr, Pready, IRQ, baud_o;
	
	/*logic [31:0] Prdata;
	logic Pready;
	logic Pslverr;
	bit IRQ;
	logic TXD;
	logic baud_o;*/
		
	bit [7:0] RBR[$], THR[$], IER, IIR, FCR, LCR, MCR, LSR, MSR, DIV1, DIV2;
	bit data_in_thr, data_in_rbr;	

	function new (string name = "uart_xtn");
		super.new(name);
	endfunction

	function void do_print(uvm_printer printer);
		super.do_print(printer);
	
		printer.print_field("Presetn", 	this.Presetn, 	$bits(Presetn), 	UVM_BIN);
		printer.print_field("Paddr", 		this.Paddr, 	$bits(Paddr), 		UVM_DEC);
		printer.print_field("Pwdata", 	this.Pwdata, 	$bits(Pwdata), 	UVM_DEC);
		printer.print_field("Pwrite", 	this.Pwrite, 	$bits(Pwrite), 	UVM_DEC);
		printer.print_field("Psel", 		this.Psel, 		$bits(Psel), 		UVM_DEC);
		printer.print_field("Penable", 	this.Penable, 	$bits(Penable), 	UVM_DEC);
		//printer.print_field("RXD", 		this.RXD, 		$bits(RXD), 		UVM_DEC);
		printer.print_field("Prdata", 	this.Prdata, 	$bits(Prdata), 	UVM_DEC);
		printer.print_field("Pready", 	this.Pready, 	$bits(Pready), 	UVM_DEC);
		printer.print_field("Pslverr", this.Pslverr, 	$bits(Pslverr), 	UVM_DEC);
		printer.print_field("IRQ", 		this.IRQ, 		$bits(IRQ), 		UVM_DEC);
		//printer.print_field("TXD", 		this.TXD, 		$bits(TXD), 		UVM_DEC);
		printer.print_field("baud_o", 	this.baud_o, 	$bits(baud_o), 	UVM_DEC);
		
		//printer.print_field("RBR", 	this.RBR, 	$bits(8), 	UVM_DEC);
		//printer.print_field("THR", 	this.THR, 	$bits(8), 	UVM_DEC);

foreach(RBR[i])
begin
printer.print_field($sformatf("RBR[%0d]",i),this.RBR[i], $bits(8),UVM_DEC);
end
foreach(THR[i])
begin
printer.print_field($sformatf("THR[%0d]",i),this.THR[i],$bits(8),UVM_DEC);
end
		//printer.sprint_queue("RBR", this.RBR);
    	//printer.sprint_queue("THR", this.THR);

		printer.print_field("IER", 		this.IER, 		$bits(IER), 		UVM_DEC);
		printer.print_field("IIR", 		this.IIR, 		$bits(IIR), 		UVM_DEC);
		printer.print_field("FCR", 		this.FCR, 		$bits(FCR), 		UVM_DEC);
		printer.print_field("LCR", 		this.LCR, 		$bits(LCR), 		UVM_DEC);
		printer.print_field("MCR", 		this.MCR, 		$bits(MCR), 		UVM_DEC);
		printer.print_field("LSR", 		this.LSR, 		$bits(LSR), 		UVM_DEC);
		printer.print_field("MSR", 		this.MSR, 		$bits(MSR), 		UVM_DEC);
		printer.print_field("DIV1", 		this.DIV1, 		$bits(DIV1), 		UVM_DEC);
		printer.print_field("DIV2", 		this.DIV2, 		$bits(DIV2), 		UVM_DEC);
	endfunction

endclass