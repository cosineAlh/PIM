# iverilog:
iverilog -o .\build\shift_adder.out .\shift_adder.v .\shift_adder_tb.v (-f .\verilog_file.f)

vvp .\build\shift_adder.out

# VCS:
makefile

# Design Complier:
dc_shell

set_app_var search_path ./library

set_app_var target_library typical.db

set_app_var link_library typical.db

read_file -format verilog ./shift_adder.v

check_design

create_clock -period 5 [get_ports clk]

set_input_delay -max 2 -clock clk [remove_from_collection [all_inputs] clk]

set_output_delay -max 1.5 -clock clk [all_outputs]

set_input_transition 0.1 [all_inputs]

check_design

compile
(reports: report_clock, report_timing)

write_sdc full_adder.sdc

write_sdf full_adder.sdf

write_file -format verilog -output shift_adder_netlist.v

# HSPICE
hspice -i ..\src\sp\test.sp -o ..\src\logs

# Makefile for VCS:
```
all: comp sim clean

ALL_DEFINE = +define+DUMP_VPD
#+NET_SIM # sythesis
# netlist
LIB_FILE = -v tsmc13.v

comp:
	#vcs ${ALL_DEFINE} ${LIB_FILE} -ad=vcsAD.init x_tb.v x.v +v2k -debug_all -l output.log #sythesis
	vcs -full64 ${ALL_DEFINE} -ad=vcsAD.init -f verilog_file.f +v2k -debug_all -l comp.log #rtl

sim:
	./simv

clean:
	rm -rf csrc DVEfiles *.vpd simv simv* ucli.key *.log hspice*
```

# LSF
module load cadence/virtuoso/ic618.000

qrsh virtuoso

bsub < LSF.lsf

bjobs

bjobs -l 1234