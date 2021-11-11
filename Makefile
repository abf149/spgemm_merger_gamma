SHELL = /bin/bash

all:
	iverilog -o simv -c merger.f
	vvp simv > sim.rpt
	tail -n 100 sim.rpt

all_gui:
	iverilog -o simv -c merger.f
	vvp simv > sim.rpt
	tail -n 100 sim.rpt
	gtkwave merger.vcd

clean:
	rm -rf *.rpt *.key simv* csrc simv.daidir DVEfiles inter.vpd .restartSimSession* .synopsys_dve_re* *.lib .cds*
