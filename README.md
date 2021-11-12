# Design exploration for the GAMMA (Zhang, et. al.) spGEMM accelerator

This repository contains the results of characterizing area and latency for the high-radix merger component of GAMMA

## Prerequisites for characterization
* To run and verify the RTL testbench
    * Ubuntu (20.04 LTS was used here)
    * Icarus Verilog, Gtkwave: `sudo apt-get install iverilog gtkwave`
* To run the 45nm area/latency characterization flow
    * Install Qflow [following these instructions](http://opencircuitdesign.com/qflow/install.html)

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

## Run the 45nm area/latency characterization flow

1. From the project directory:

```
cd qflow_workspace
qflow gui
```

2. In the Preparation step, set the Verilog source file to be the *local* copy of "merger.v". Set the Verilog module to be "merger".
3. Run the Preparation step.
4. Run the Synthesize step and let the process proceed.

