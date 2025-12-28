class uart_agent_top extends uvm_env;

	`uvm_component_utils(uart_agent_top)
	
	uart_agent u_agt[];

	uart_env_config e_cfg;
	
	function new(string name = "uart_agent_top", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

			if(!uvm_config_db #(uart_env_config)::get(this, "", "uart_env_config", e_cfg))
				`uvm_fatal("uart_agent_config", "config falied")
		
			u_agt = new[e_cfg.no_of_uart_agents];
	
			foreach(u_agt[i]) 
				begin
					u_agt[i] = uart_agent::type_id::create($sformatf("u_agt[%0d]", i), this);
					uvm_config_db #(uart_agent_config)::set(this, $sformatf("u_agt[%0d]*", i), "uart_agent_config", e_cfg.u_cfg[i]);
				end
	endfunction
endclass