# Design exploration for the GAMMA (Zhang, et. al.) spGEMM accelerator

This repository contains the results of characterizing area and latency for the high-radix merger component of GAMMA

## Prerequisites for characterization
* To run and verify the RTL testbench
    * Ubuntu (20.04 LTS was used here)
    * Icarus Verilog, Gtkwave: `sudo apt-get install iverilog gtkwave`
* To produce 45nm area and latency estimates
    * Install qflow [following these instructions](http://opencircuitdesign.com/qflow/install.html)

## Run and verify the merger RTL testbench

Clone and run testbench in Icarus Verilog:
```
git clone https://github.com/abf149/spgemm_merger_gamma.git
make all
```

Verify testbench results in Gtkwave:
```
make all_gui
```
