class uart_sequence extends uvm_sequence #(uart_xtn);
		
	`uvm_object_utils(uart_sequence)
	
	function new (string name = "uart_sequence");
		super.new(name);
	endfunction

endclass

//=================FULL DUPLEX SEQ1=================	
class full_duplex_seq1 extends uart_sequence;
	
	`uvm_object_utils(full_duplex_seq1)
	
	function new (string name = "full_duplex_seq1");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("FDSq1");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 54;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0101;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_0011;});
		finish_item(req);

		//STEP 6 THR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1; Pwdata == 8'h5;});
		finish_item(req);
			
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("FULL_DUPLEX_SEQ1", $sformatf("DATA FROM FULL DUPLEX SEQ1 \n %s", req.sprint), UVM_LOW)
		
	endtask

endclass


//=================FULL DUPLEX SEQ2=================	
class full_duplex_seq2 extends uart_sequence;
	
	`uvm_object_utils(full_duplex_seq2)
	
	function new (string name = "full_duplex_seq2");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("FDSq2");

		//STEP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 27;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0101;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_0011;});
		finish_item(req);

		//STEP 6 THR
		start_item(req);	

		assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1; Pwdata == 8'h10;});
		finish_item(req);
			
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
		
		if(req.IIR[3:0] == 6)	
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("FULL_DUPLEX_SEQ2", $sformatf("DATA FROM FULL DUPLEX SEQ2 \n %s", req.sprint), UVM_LOW)

	endtask

endclass

//=======================HALF DUPLEX SEQ1==================
class half_duplex_seq1 extends uart_sequence;
	
	`uvm_object_utils(half_duplex_seq1)
	
	function new (string name = "half_duplex_seq1");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("HDSq1");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 54;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0101;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_0011;});
		finish_item(req);

		//STEP 6 THR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1; Pwdata == 8'h5;});
		finish_item(req);
			
		//`uvm_info("HALF_DUPLEX_SEQ1", $sformatf("DATA FROM HALF DUPLEX SEQ1 \n %s", req.sprint), UVM_LOW)
		
	endtask

endclass


//=======================HALF DUPLEX SEQ2==================
class half_duplex_seq2 extends uart_sequence;
	
	`uvm_object_utils(half_duplex_seq2)
	
	function new (string name = "half_duplex_seq1");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("HDSq2");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 27;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0101;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_0011;});
		finish_item(req);
	
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
		
		if(req.IIR[3:0] == 6)	
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end

					
		//`uvm_info("HALF_DUPLEX_SEQ2", $sformatf("DATA FROM HALF DUPLEX SEQ2 \n %s", req.sprint), UVM_LOW)
		
	endtask

endclass


//=======================LOOPBACK SEQ1==================
class loopback_seq1 extends uart_sequence;
	
	`uvm_object_utils(loopback_seq1)
	
	function new (string name = "loopback_seq1");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("LBSq1");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 54;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0101;});
		finish_item(req);

		//STEP MCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h10;	Pwrite == 1'b1; Pwdata == 8'b0001_0000;});
		finish_item(req);
		
		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_0011;});
		finish_item(req);

		//STEP 6 THR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1; Pwdata == 8'h25;});
		finish_item(req);
			
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("LOOPBACK_SEQ1", $sformatf("DATA FROM LOOPBACK_SEQ1\n %s", req.sprint), UVM_LOW)
		
	endtask

endclass


//=======================LOOPBACK SEQ2==================
class loopback_seq2 extends uart_sequence;
	
	`uvm_object_utils(loopback_seq2)
	
	function new (string name = "loopback_seq2");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("LBSq2");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 54;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0101;});
		finish_item(req);

		//STEP MCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h10;	Pwrite == 1'b1; Pwdata == 8'b0001_0000;});
		finish_item(req);
		
		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_0011;});
		finish_item(req);

		//STEP 6 THR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1; Pwdata == 8'h30;});
		finish_item(req);
			
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("LOOPBACK_SEQ2", $sformatf("DATA FROM LOOPBACK_SEQ2\n %s", req.sprint), UVM_LOW)
		
	endtask

endclass

//=======================PARITY SEQ1==================
class parity_seq1 extends uart_sequence;
	
	`uvm_object_utils(parity_seq1)
	
	function new (string name = "parity_seq1");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("PRSq1");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 54;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0101;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_1011;});
		finish_item(req);

		//STEP 6 THR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1; Pwdata == 5;});
		finish_item(req);
			
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("PARITY_SEQ1", $sformatf("DATA FROM PARITY_SEQ1\n %s", req.sprint), UVM_LOW)
		
	endtask

endclass


//=======================PARITY SEQ2==================
class parity_seq2 extends uart_sequence;
	
	`uvm_object_utils(parity_seq2)
	
	function new (string name = "parity_seq2");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("PRSq2");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 27;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0101;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0001_1111;});
		finish_item(req);

		//STEP 6 THR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1; Pwdata == 10;});
		finish_item(req);
			
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("PARITY_SEQ2", $sformatf("DATA FROM PARITY_SEQ2\n %s", req.sprint), UVM_LOW)
		
	endtask

endclass



//=================	BREAK ERROR SEQ1=================	
class break_error_seq1 extends uart_sequence;
	
	`uvm_object_utils(break_error_seq1)
	
	function new (string name = "break_error_seq1");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("BRSq1");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 54;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0101;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0100_0011;});
		finish_item(req);

		//STEP 6 THR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1; Pwdata == 5;});
		finish_item(req);
			
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("FULL_DUPLEX_SEQ1", $sformatf("DATA FROM FULL DUPLEX SEQ1 \n %s", req.sprint), UVM_LOW)
		
	endtask

endclass



//=================BREAK ERROR SEQ2=================	
class break_error_seq2 extends uart_sequence;
	
	`uvm_object_utils(break_error_seq2)
	
	function new (string name = "break_error_seq2");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("BRSq2");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		
		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 27;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0101;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0100_0011;});
		finish_item(req);

		//STEP 6 THR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1; Pwdata == 10;});
		finish_item(req);
			
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("FULL_DUPLEX_SEQ1", $sformatf("DATA FROM FULL DUPLEX SEQ1 \n %s", req.sprint), UVM_LOW)
		
	endtask

endclass



//=================OVERRUN ERROR SEQ1=================	
class overrun_error_seq1 extends uart_sequence;
	
	`uvm_object_utils(overrun_error_seq1)
	
	function new (string name = "overrun_error_seq1");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("ORSq1");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 54;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b1100_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0100;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_0011;});
		finish_item(req);

		//STEP 6 THR
		repeat(17)
			begin
				start_item(req);	
				assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1;});
				finish_item(req);
			end
			
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("FULL_DUPLEX_SEQ1", $sformatf("DATA FROM FULL DUPLEX SEQ1 \n %s", req.sprint), UVM_LOW)
		
	endtask

endclass


//=================OVERRUN ERROR SEQ2=================	
class overrun_error_seq2 extends uart_sequence;
	
	`uvm_object_utils(overrun_error_seq2)
	
	function new (string name = "overrun_error_seq2");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("ORSq2");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 27;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b1100_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0100;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_0011;});
		finish_item(req);

		//STEP 6 THR
		repeat(17)
			begin
				start_item(req);	
				assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1;});
				finish_item(req);
			end
			
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("FULL_DUPLEX_SEQ1", $sformatf("DATA FROM FULL DUPLEX SEQ1 \n %s", req.sprint), UVM_LOW)
		
	endtask

endclass

//=================FRAMING ERROR SEQ1=================	
class framing_error_seq1 extends uart_sequence;
	
	`uvm_object_utils(framing_error_seq1)
	
	function new (string name = "framing_error_seq1");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("FRSq1");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 54;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0100;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_0011;});
		finish_item(req);

		//STEP 6 THR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1; Pwdata == 5;});
		finish_item(req);
		
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("FULL_DUPLEX_SEQ1", $sformatf("DATA FROM FULL DUPLEX SEQ1 \n %s", req.sprint), UVM_LOW)
		
	endtask

endclass



//=================FRAMING ERROR SEQ2=================	
class framing_error_seq2 extends uart_sequence;
	
	`uvm_object_utils(framing_error_seq2)
	
	function new (string name = "framing_error_seq2");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("FRSq2");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 27;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0100;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_0000;});
		finish_item(req);

		//STEP 6 THR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1; Pwdata == 10;});
		finish_item(req);
		
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("FULL_DUPLEX_SEQ1", $sformatf("DATA FROM FULL DUPLEX SEQ1 \n %s", req.sprint), UVM_LOW)
		
	endtask

endclass


//=================THR EMPTY ERROR SEQ1=================	
class thr_empty_error_seq1 extends uart_sequence;
	
	`uvm_object_utils(thr_empty_error_seq1)
	
	function new (string name = "thr_empty_error_seq1");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("EMSq1");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 54;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0010;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_0011;});
		finish_item(req);

		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("FULL_DUPLEX_SEQ1", $sformatf("DATA FROM FULL DUPLEX SEQ1 \n %s", req.sprint), UVM_LOW)
		
	endtask

endclass



//=================THR EMPTY ERROR SEQ2=================	
class thr_empty_error_seq2 extends uart_sequence;
	
	`uvm_object_utils(thr_empty_error_seq2)
	
	function new (string name = "thr_empty_error_seq2");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("EMSq2");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 27;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b0000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0010;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_0011;});
		finish_item(req);

		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("FULL_DUPLEX_SEQ1", $sformatf("DATA FROM FULL DUPLEX SEQ1 \n %s", req.sprint), UVM_LOW)
		
	endtask

endclass



//=================TIME OUT ERROR SEQ1=================	
class time_out_error_seq1 extends uart_sequence;
	
	`uvm_object_utils(time_out_error_seq1)
	
	function new (string name = "time_out_error_seq1");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("TESq1");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 54;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b1000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0000;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_1011;});
		finish_item(req);

		//STEP 6 THR
		repeat(17)
			begin
				start_item(req);	
				assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1;});
				finish_item(req);
			end
			
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("FULL_DUPLEX_SEQ1", $sformatf("DATA FROM FULL DUPLEX SEQ1 \n %s", req.sprint), UVM_LOW)
		
	endtask

endclass


//=================TIME OUT ERROR SEQ2=================	
class time_out_error_seq2 extends uart_sequence;
	
	`uvm_object_utils(time_out_error_seq2)
	
	function new (string name = "time_out_error_seq2");
		super.new(name);
	endfunction
		
	task body;
	
		req = uart_xtn::type_id::create("TESq2");

		//SETP 1 DIV1 MSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h20;	Pwrite == 1'b1; Pwdata == 1'b0;});
		finish_item(req);
		

		//STEP 2 DIV2 LSB
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h1c;	Pwrite == 1'b1; Pwdata == 27;});
		finish_item(req);

		//STEP 3 FCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b1; Pwdata == 8'b1000_0110;});
		finish_item(req);

		//STEP 4 IER
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h04;	Pwrite == 1'b1; Pwdata == 8'b0000_0000;});
		finish_item(req);

		//STEP 5 LCR
		start_item(req);	
		assert(req.randomize with { Paddr == 32'h0c;	Pwrite == 1'b1; Pwdata == 8'b0000_1011;});
		finish_item(req);

		//STEP 6 THR
		repeat(17)
			begin
				start_item(req);	
				assert(req.randomize with { Paddr == 32'h00;	Pwrite == 1'b1;});
				finish_item(req);
			end
			
		//STEP 7 IIR
		start_item(req);
		assert(req.randomize with { Paddr == 32'h08;	Pwrite == 1'b0;});
		finish_item(req);
		get_response(req);
	
		if(req.IIR[3:0] == 4)
			begin
				start_item(req);	
				assert(req.randomize with {Paddr == 32'h00; 	Pwrite == 1'b0;});
				finish_item(req);
			end
			
		
		if(req.IIR[3:0] == 6)
			begin
				start_item(req);
				assert(req.randomize with {Paddr == 32'h14;	Pwrite == 1'b0;});
				finish_item(req);
			end
		//`uvm_info("FULL_DUPLEX_SEQ1", $sformatf("DATA FROM FULL DUPLEX SEQ1 \n %s", req.sprint), UVM_LOW)
		
	endtask

endclass