
package uart_pkg;
		
	import uvm_pkg::*;

	`include "uvm_macros.svh"
	`include "uart_reg.sv"
	`include "uart_reg_block.sv"
	
	`include "uart_agent_config.sv"
	`include "uart_env_config.sv"
	
	`include "uart_xtn.sv"

	`include "uart_driver.sv"
	`include "uart_monitor.sv"
	`include "uart_sequencer.sv"
	`include "uart_sequence.sv"
	
	`include "uart_agent.sv"
	
	`include "uart_agent_top.sv"

	`include "uart_sb.sv"
	`include "uart_v_seqr.sv"
	
	`include "uart_env.sv"
	
	`include "uart_test.sv"
endpackage
