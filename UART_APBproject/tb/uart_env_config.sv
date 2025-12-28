
class uart_env_config extends uvm_object;
	
	`uvm_object_utils (uart_env_config)
	
	function new (string name = "uart_env_config"); 
		super.new(name);
	endfunction

	bit has_sb;
	bit has_uart_agent;
	bit has_v_seqr;
	int no_of_uart_agents;
		
	uart_agent_config u_cfg[];
	uart_reg_block regmodel;
	
endclass
	 
