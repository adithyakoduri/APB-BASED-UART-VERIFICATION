
class uart_test extends uvm_test;
	
	`uvm_component_utils(uart_test)

	uart_env_config 	e_cfg;
	uart_agent_config	u_cfg[];
	uart_env 		envh;
	uart_reg_block regmodel;
	bit has_sb  = 1;
	bit has_uart_agent = 1;
	bit has_v_seqr = 1;
	int no_of_uart_agents = 2;

	function new (string name = "uart_test", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		
		e_cfg = uart_env_config::type_id::create("e_cfg");
	
		e_cfg.has_sb = has_sb;
		e_cfg.has_uart_agent = has_uart_agent;
		e_cfg.has_v_seqr = has_v_seqr; 
		e_cfg.no_of_uart_agents = no_of_uart_agents;

		u_cfg = new[no_of_uart_agents];
		e_cfg.u_cfg = new[no_of_uart_agents];
		foreach(u_cfg[i])
			begin
				u_cfg[i] = uart_agent_config::type_id::create($sformatf("u_cfg[%0d]", i));
				if(!uvm_config_db #(virtual uart_if)::get(this, "", $sformatf("if%0d", i), u_cfg[i].vif))
				`uvm_fatal("uart_test", "config falied")
				e_cfg.u_cfg[i] = u_cfg[i];
			end

		uvm_config_db #(uart_env_config)::set(this, "*", "uart_env_config", e_cfg);
		regmodel=uart_reg_block::type_id::create("regmodel");
		regmodel.build();
		e_cfg.regmodel=this.regmodel;
		
		envh = uart_env::type_id::create("envh", this);

	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology;
	endfunction

endclass

//==========FULL DUPLEX TEST=============
class full_duplex_test extends uart_test;
	`uvm_component_utils(full_duplex_test)
	
	function new (string name = "full_duplex_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	full_duplex_seq1 full_duplex_seq1h;
	full_duplex_seq2 full_duplex_seq2h;
		
	task run_phase(uvm_phase phase);

		full_duplex_seq1h = full_duplex_seq1::type_id::create("full_duplex_seq1h");
		full_duplex_seq2h = full_duplex_seq2::type_id::create("full_duplex_seq2h");
	
		phase.raise_objection(this);
			fork 
				full_duplex_seq1h.start(envh.u_agt_toph.u_agt[0].seqrh);
				full_duplex_seq2h.start(envh.u_agt_toph.u_agt[1].seqrh);
			join
		#20;
		phase.drop_objection(this);
	
	endtask
endclass


//==========HALF DUPLEX TEST=============
class half_duplex_test extends uart_test;
	`uvm_component_utils(half_duplex_test)
	
	function new (string name = "half_duplex_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	half_duplex_seq1 half_duplex_seq1h;
	half_duplex_seq2 half_duplex_seq2h;
		
	task run_phase(uvm_phase phase);

		half_duplex_seq1h = half_duplex_seq1::type_id::create("half_duplex_seq1h");
		half_duplex_seq2h = half_duplex_seq2::type_id::create("half_duplex_seq2h");
	
		phase.raise_objection(this);
			fork
				half_duplex_seq1h.start(envh.u_agt_toph.u_agt[0].seqrh);
				half_duplex_seq2h.start(envh.u_agt_toph.u_agt[1].seqrh);
			join
			#40;
		phase.drop_objection(this);
	
	endtask
endclass

//==========LOOPBACK TEST=============
class loopback_test extends uart_test;
	`uvm_component_utils(loopback_test)
	
	function new (string name = "loopback_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	loopback_seq1 loopback_seq1h;
	loopback_seq2 loopback_seq2h;
		
	task run_phase(uvm_phase phase);

		loopback_seq1h = loopback_seq1::type_id::create("loopback_seq1h");
		loopback_seq2h = loopback_seq2::type_id::create("loopback_seq2h");
	
		phase.raise_objection(this);
			fork
				loopback_seq1h.start(envh.u_agt_toph.u_agt[0].seqrh);
				loopback_seq2h.start(envh.u_agt_toph.u_agt[1].seqrh);
			join
			#50;
		phase.drop_objection(this);
	
	endtask
endclass

//==========PARITY TEST=============
class parity_test extends uart_test;
	`uvm_component_utils(parity_test)
	
	function new (string name = "parity_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	parity_seq1 parity_seq1h;
	parity_seq2 parity_seq2h;
		
	task run_phase(uvm_phase phase);

		parity_seq1h = parity_seq1::type_id::create("parity_seq1h");
		parity_seq2h = parity_seq2::type_id::create("parity_seq2h");
	
		phase.raise_objection(this);
			fork
				parity_seq1h.start(envh.u_agt_toph.u_agt[0].seqrh);
				parity_seq2h.start(envh.u_agt_toph.u_agt[1].seqrh);
			join
		#40;
		phase.drop_objection(this);
	
	endtask
endclass

//==========BREAK ERROR TEST=============
class break_error_test extends uart_test;
	`uvm_component_utils(break_error_test)
	
	function new (string name = "break_error_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	break_error_seq1 break_error_seq1h;
	break_error_seq2 break_error_seq2h;
		
	task run_phase(uvm_phase phase);

		break_error_seq1h = break_error_seq1::type_id::create("break_error_seq1h");
		break_error_seq2h = break_error_seq2::type_id::create("break_error_seq2h");
	
		phase.raise_objection(this);
			fork
				break_error_seq1h.start(envh.u_agt_toph.u_agt[0].seqrh);
				break_error_seq2h.start(envh.u_agt_toph.u_agt[1].seqrh);
			join
		#40;
		phase.drop_objection(this);
	
	endtask
endclass


//==========OVERRUN ERROR TEST=============
class overrun_error_test extends uart_test;
	`uvm_component_utils(overrun_error_test)
	
	function new (string name = "overrun_error_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	overrun_error_seq1 overrun_error_seq1h;
	overrun_error_seq2 overrun_error_seq2h;
		
	task run_phase(uvm_phase phase);

		overrun_error_seq1h = overrun_error_seq1::type_id::create("overrun_error_seq1h");
		overrun_error_seq2h = overrun_error_seq2::type_id::create("overrun_error_seq2h");
	
		phase.raise_objection(this);
			fork
				overrun_error_seq1h.start(envh.u_agt_toph.u_agt[0].seqrh);
				overrun_error_seq2h.start(envh.u_agt_toph.u_agt[1].seqrh);
			join
		#40;
		phase.drop_objection(this);
	
	endtask
endclass


//==========FRAMING ERROR TEST=============
class framing_error_test extends uart_test;
	`uvm_component_utils(framing_error_test)
	
	function new (string name = "framing_error_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	framing_error_seq1 framing_error_seq1h;
	framing_error_seq2 framing_error_seq2h;
		
	task run_phase(uvm_phase phase);

		framing_error_seq1h = framing_error_seq1::type_id::create("framing_error_seq1h");
		framing_error_seq2h = framing_error_seq2::type_id::create("framing_error_seq2h");
	
		phase.raise_objection(this);
			fork
				framing_error_seq1h.start(envh.u_agt_toph.u_agt[0].seqrh);
				framing_error_seq2h.start(envh.u_agt_toph.u_agt[1].seqrh);
			join
		#40;
		phase.drop_objection(this);
	
	endtask
endclass


//==========THR EMPTY ERROR TEST=============
class thr_empty_error_test extends uart_test;
	`uvm_component_utils(thr_empty_error_test)
	
	function new (string name = "thr_empty_error_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	thr_empty_error_seq1 thr_empty_error_seq1h;
	thr_empty_error_seq2 thr_empty_error_seq2h;
		
	task run_phase(uvm_phase phase);

		thr_empty_error_seq1h = thr_empty_error_seq1::type_id::create("thr_empty_error_seq1h");
		thr_empty_error_seq2h = thr_empty_error_seq2::type_id::create("thr_empty_error_seq2h");
	
		phase.raise_objection(this);
			fork
				thr_empty_error_seq1h.start(envh.u_agt_toph.u_agt[0].seqrh);
				thr_empty_error_seq2h.start(envh.u_agt_toph.u_agt[1].seqrh);
			join
		#40;
		phase.drop_objection(this);
	
	endtask
endclass


//==========TIME OUT ERROR TEST=============
class time_out_error_test extends uart_test;
	`uvm_component_utils(time_out_error_test)
	
	function new (string name = "time_out_error_test", uvm_component parent);
		super.new(name, parent);
	endfunction
	
	time_out_error_seq1 time_out_error_seq1h;
	time_out_error_seq2 time_out_error_seq2h;
		
	task run_phase(uvm_phase phase);

		time_out_error_seq1h = time_out_error_seq1::type_id::create("time_out_error_seq1h");
		time_out_error_seq2h = time_out_error_seq2::type_id::create("time_out_error_seq2h");
	
		phase.raise_objection(this);
			fork
				time_out_error_seq1h.start(envh.u_agt_toph.u_agt[0].seqrh);
				time_out_error_seq2h.start(envh.u_agt_toph.u_agt[1].seqrh);
			join
		#40;
		phase.drop_objection(this);
	
	endtask
endclass
