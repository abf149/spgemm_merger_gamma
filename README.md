# Design exploration for the GAMMA (Zhang, et. al.) spGEMM accelerator

This repository contains the results of characterizing area and latency for the high-radix merger component of GAMMA

## Prerequisites for running the RTL testbench
* Icarus Verilog, Gtkwave: `sudo apt-get install iverilog gtkwave`
* Ubuntu environment (20.04 LTS was used here)

## Getting started

Clone and run testbench in Icarus Verilog:
```
git clone https://github.com/abf149/spgemm_merger_gamma.git
make all
```

Verify testbench results in Gtkwave:
```
make all_gui
```
