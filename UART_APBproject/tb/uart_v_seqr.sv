
class uart_v_seqr extends uvm_sequencer #(uvm_sequence_item);
	
	`uvm_component_utils(uart_v_seqr)
	
	function new (string name = "uart_v_seqr", uvm_component parent);	
		super.new(name, parent);	
	endfunction
endclass
