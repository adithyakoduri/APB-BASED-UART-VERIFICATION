
class uart_env extends uvm_env;
	
	`uvm_component_utils(uart_env)
	
	uart_env_config e_cfg;
	uart_sb sbh;
	uart_v_seqr v_seqrh;
	uart_agent_top u_agt_toph;
	
	function new (string name = "uart_env", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
	
		
		if(!uvm_config_db #(uart_env_config)::get(this, "", "uart_env_config", e_cfg))
			`uvm_fatal("uart_env", "config falied")
				
		if(e_cfg.has_sb)
		sbh = uart_sb::type_id::create("sbh", this);
	
		if(e_cfg.has_v_seqr)
		v_seqrh = uart_v_seqr::type_id::create("v_seqrh", this);
		
		if(e_cfg.has_uart_agent)
		u_agt_toph = uart_agent_top::type_id::create("u_agt_toph", this);

	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		foreach(u_agt_toph.u_agt[i])
			u_agt_toph.u_agt[i].monh.mon2sb.connect(sbh.fifo_h[i].analysis_export);
	endfunction

endclass
		
