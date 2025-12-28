
module uart_tb_top;
 
	import uvm_pkg::*;
	import uart_pkg::*;

	bit clk1 = 0;
	bit clk2 = 0;
	
	wire rx,tx;

	always #5 clk1 = ~clk1;
	always #10 clk2  = ~clk2;

	uart_if if1 (clk1);
	uart_if if2 (clk2);
	
	uart_16550 DUV1 (
	  						clk1,
  							if1.Presetn,
  							if1.Paddr,
  							if1.Pwdata,
  							if1.Prdata,
  							if1.Pwrite,
  							if1.Penable,
  							if1.Psel,
  							if1.Pready,
  							if1.Pslverr,
  							if1.IRQ,
  							tx,
  							rx,
  							if1.baud_o
						);
	
	uart_16550 DUV2 (
	  						clk2,
  							if2.Presetn,
  							if2.Paddr,
  							if2.Pwdata,
  							if2.Prdata,
  							if2.Pwrite,
  							if2.Penable,
  							if2.Psel,
  							if2.Pready,
  							if2.Pslverr,
  							if2.IRQ,
  							rx,
  							tx,
  							if2.baud_o
						);
	
	initial 
		begin
			uvm_config_db #(virtual uart_if)::set(null, "*", "if0", if1);
			uvm_config_db #(virtual uart_if)::set(null, "*", "if1", if2);
			run_test();
		end

endmodule
		
	 
	 
