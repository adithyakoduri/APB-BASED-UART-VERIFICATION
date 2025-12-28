
# SIMULATOR = Questa for Mentor's Questasim
#SIMULATOR = VCS
SIMULATOR = Questa

FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64

RTL   = ../uart_rtl/*
work  = work
SVTB1 = ../tb/uart_tb_top.sv
SVTB2 = ../test/uart_pkg.sv
INC   = +incdir+../tb +incdir+../test +incdir+../uart_agent_top

VSIMOPT = -voptargs=+acc=rn


VSIMCOV = -coverage -sva

# -------------------------
# Batch commands (FIXED)
# -------------------------
VSIMBATCH1  = -do "log -r /* ; coverage save -onexit mem_cov1 ; run -all ; quit"
VSIMBATCH2  = -do "log -r /* ; coverage save -onexit mem_cov2 ; run -all ; quit"
VSIMBATCH3  = -do "log -r /* ; coverage save -onexit mem_cov3 ; run -all ; quit"
VSIMBATCH4  = -do "log -r /* ; coverage save -onexit mem_cov4 ; run -all ; quit"
VSIMBATCH5  = -do "log -r /* ; coverage save -onexit mem_cov5 ; run -all ; quit"
VSIMBATCH6  = -do "log -r /* ; coverage save -onexit mem_cov6 ; run -all ; quit"
VSIMBATCH7  = -do "log -r /* ; coverage save -onexit mem_cov7 ; run -all ; quit"
VSIMBATCH8  = -do "log -r /* ; coverage save -onexit mem_cov8 ; run -all ; quit"
VSIMBATCH9  = -do "log -r /* ; coverage save -onexit mem_cov9 ; run -all ; quit"
VSIMBATCH10 = -do "log -r /* ; coverage save -onexit mem_cov10 ; run -all ; quit"

# ============================================================
# User targets
# ============================================================
clean       : clean_$(SIMULATOR)
sv_cmp      : sv_cmp_$(SIMULATOR)
run_test    : run_test_$(SIMULATOR)
run_test1   : run_test1_$(SIMULATOR)
run_test2   : run_test2_$(SIMULATOR)
run_test3   : run_test3_$(SIMULATOR)
run_test4   : run_test4_$(SIMULATOR)
run_test5   : run_test5_$(SIMULATOR)
run_test6   : run_test6_$(SIMULATOR)
run_test7   : run_test7_$(SIMULATOR)
run_test8   : run_test8_$(SIMULATOR)
run_test9   : run_test9_$(SIMULATOR)

view_wave1  : view_wave1_$(SIMULATOR)
view_wave2  : view_wave2_$(SIMULATOR)
view_wave3  : view_wave3_$(SIMULATOR)
view_wave4  : view_wave4_$(SIMULATOR)
view_wave5  : view_wave5_$(SIMULATOR)
view_wave6  : view_wave6_$(SIMULATOR)
view_wave7  : view_wave7_$(SIMULATOR)
view_wave8  : view_wave8_$(SIMULATOR)
view_wave9  : view_wave9_$(SIMULATOR)
view_wave10 : view_wave10_$(SIMULATOR)

regress     : regress_$(SIMULATOR)
report      : report_$(SIMULATOR)
cov         : cov_$(SIMULATOR)

# ============================================================
# Questa Targets
# ============================================================

sv_cmp_Questa:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1)

run_test_Questa: sv_cmp
	vsim -c -wlf wave_file1.wlf -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
	     $(VSIMBATCH1) -l test1.log -sv_seed random \
	     work.uart_tb_top +UVM_TESTNAME=uart_test
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

run_test1_Questa: sv_cmp
	vsim -c -wlf wave_file2.wlf -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
	     $(VSIMBATCH2) -l test2.log -sv_seed random \
	     work.uart_tb_top +UVM_TESTNAME=full_duplex_test
	vcover report -html mem_cov2

run_test2_Questa: sv_cmp
	vsim -c -wlf wave_file3.wlf -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
	     $(VSIMBATCH3) -l test3.log -sv_seed random \
	     work.uart_tb_top +UVM_TESTNAME=half_duplex_test
	vcover report -html mem_cov3

run_test3_Questa: sv_cmp
	vsim -c -wlf wave_file4.wlf -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
	     $(VSIMBATCH4) -l test4.log -sv_seed random \
	     work.uart_tb_top +UVM_TESTNAME=loopback_test
	vcover report -html mem_cov4

run_test4_Questa: sv_cmp
	vsim -c -wlf wave_file5.wlf -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
	     $(VSIMBATCH5) -l test5.log -sv_seed random \
	     work.uart_tb_top +UVM_TESTNAME=parity_test
	vcover report -html mem_cov5

run_test5_Questa: sv_cmp
	vsim -c -wlf wave_file6.wlf -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
	     $(VSIMBATCH6) -l test6.log -sv_seed random \
	     work.uart_tb_top +UVM_TESTNAME=break_error_test
	vcover report -html mem_cov6

run_test6_Questa: sv_cmp
	vsim -c -wlf wave_file7.wlf -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
	     $(VSIMBATCH7) -l test7.log -sv_seed random \
	     work.uart_tb_top +UVM_TESTNAME=overrun_error_test
	vcover report -html mem_cov7

run_test7_Questa: sv_cmp
	vsim -c -wlf wave_file8.wlf -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
	     $(VSIMBATCH8) -l test8.log -sv_seed random \
	     work.uart_tb_top +UVM_TESTNAME=framing_error_test
	vcover report -html mem_cov8

run_test8_Questa: sv_cmp
	vsim -c -wlf wave_file9.wlf -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
	     $(VSIMBATCH9) -l test9.log -sv_seed random \
	     work.uart_tb_top +UVM_TESTNAME=thr_empty_error_test
	vcover report -html mem_cov9

run_test9_Questa: sv_cmp
	vsim -c -wlf wave_file10.wlf -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
	     $(VSIMBATCH10) -l test10.log -sv_seed random \
	     work.uart_tb_top +UVM_TESTNAME=time_out_error_test
	vcover report -html mem_cov10

# -------------------------
# View waves
# -------------------------
view_wave1_Questa:  ; vsim -view wave_file1.wlf
view_wave2_Questa:  ; vsim -view wave_file2.wlf
view_wave3_Questa:  ; vsim -view wave_file3.wlf
view_wave4_Questa:  ; vsim -view wave_file4.wlf
view_wave5_Questa:  ; vsim -view wave_file5.wlf
view_wave6_Questa:  ; vsim -view wave_file6.wlf
view_wave7_Questa:  ; vsim -view wave_file7.wlf
view_wave8_Questa:  ; vsim -view wave_file8.wlf
view_wave9_Questa:  ; vsim -view wave_file9.wlf
view_wave10_Questa: ; vsim -view wave_file10.wlf

# -------------------------
# Regression & report
# -------------------------
report_Questa:
	vcover merge mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5 mem_cov6 mem_cov7 mem_cov8 mem_cov9 mem_cov10 mem_cov
	vcover report -html mem_cov1

regress_Questa: clean_Questa run_test run_test1 run_test2 run_test3 run_test4 run_test5 run_test6 run_test7 run_test8 run_test9 report_Questa cov_Questa

cov_Questa:
	firefox covhtmlreport/index.html &

clean_Questa:
	rm -rf transcript* *.log *.wlf mem_cov* covhtml* modelsim.ini work
	clear


# ============================================================
# VCS compile
# ============================================================

sv_cmp_VCS:
	rm -rf simv csrc *.daidir *.key *.log *.fsdb
	vcs -full64 -sverilog -ntb_opts uvm \
	    -debug_access+all -kdb \
	    $(INC) $(RTL) $(SVTB2) $(SVTB1) \
	    -l compile.log

# ============================================================
# Run tests
# ============================================================

run_test_VCS: sv_cmp_VCS
	./simv +UVM_TESTNAME=uart_test \
	       +ntb_random_seed_automatic \
	       -l test1.log \
	       +fsdbfile=wave1.fsdb

run_test1_VCS: sv_cmp_VCS
	./simv +UVM_TESTNAME=full_duplex_test \
	       +ntb_random_seed_automatic \
	       -l test2.log \
	       +fsdbfile=wave2.fsdb

run_test2_VCS: sv_cmp_VCS
	./simv +UVM_TESTNAME=half_duplex_test \
	       +ntb_random_seed_automatic \
	       -l test3.log \
	       +fsdbfile=wave3.fsdb

run_test3_VCS: sv_cmp_VCS
	./simv +UVM_TESTNAME=loopback_test \
	       +ntb_random_seed_automatic \
	       -l test4.log \
	       +fsdbfile=wave4.fsdb

run_test4_VCS: sv_cmp_VCS
	./simv +UVM_TESTNAME=parity_test \
	       +ntb_random_seed_automatic \
	       -l test5.log \
	       +fsdbfile=wave5.fsdb

run_test5_VCS: sv_cmp_VCS
	./simv +UVM_TESTNAME=break_error_test \
	       +ntb_random_seed_automatic \
	       -l test6.log \
	       +fsdbfile=wave6.fsdb

run_test6_VCS: sv_cmp_VCS
	./simv +UVM_TESTNAME=overrun_error_test \
	       +ntb_random_seed_automatic \
	       -l test7.log \
	       +fsdbfile=wave7.fsdb

run_test7_VCS: sv_cmp_VCS
	./simv +UVM_TESTNAME=framing_error_test \
	       +ntb_random_seed_automatic \
	       -l test8.log \
	       +fsdbfile=wave8.fsdb

run_test8_VCS: sv_cmp_VCS
	./simv +UVM_TESTNAME=thr_empty_error_test \
	       +ntb_random_seed_automatic \
	       -l test9.log \
	       +fsdbfile=wave9.fsdb

run_test9_VCS: sv_cmp_VCS
	./simv +UVM_TESTNAME=time_out_error_test \
	       +ntb_random_seed_automatic \
	       -l test10.log \
	       +fsdbfile=wave10.fsdb

# ============================================================
# View waveform (Verdi)
# ============================================================

view_wave1_VCS:
	verdi -sv -f filelist.f -ssf wave1.fsdb &

view_wave2_VCS:
	verdi -sv -f filelist.f -ssf wave2.fsdb &

view_wave3_VCS:
	verdi -sv -f filelist.f -ssf wave3.fsdb &

view_wave4_VCS:
	verdi -sv -f filelist.f -ssf wave4.fsdb &

view_wave5_VCS:
	verdi -sv -f filelist.f -ssf wave5.fsdb &

view_wave6_VCS:
	verdi -sv -f filelist.f -ssf wave6.fsdb &

view_wave7_VCS:
	verdi -sv -f filelist.f -ssf wave7.fsdb &

view_wave8_VCS:
	verdi -sv -f filelist.f -ssf wave8.fsdb &

view_wave9_VCS:
	verdi -sv -f filelist.f -ssf wave9.fsdb &

view_wave10_VCS:
	verdi -sv -f filelist.f -ssf wave10.fsdb &

# ============================================================
# Regression
# ============================================================

regress_VCS: clean_VCS \
             run_test run_test1 run_test2 run_test3 run_test4 \
             run_test5 run_test6 run_test7 run_test8 run_test9

# ============================================================
# Clean
# ============================================================

clean_VCS:
	rm -rf simv simv.daidir csrc *.log *.fsdb *.key *.vpd
	clear

