# MTJ SPICE Model by Verilog-A
This project is a compact model to simulate the dynamic of MTJ motion by SPICE, which can be used for large scale circuit. The physic behavior of MTJ is realized by Verilog-A, also including thermal fluctuation. LLG equation is solved by two different method:
1. use RK4 to solve the differential equation directly
2. transform the magnetization into spherical coordinate and calculate the angles every time step

This model only realize STT part and it have been checked with MATLAB codes, SOT or VCMA or any other functions can be completed later. If you find any issue, please tell me to correct it.


## Quick Start
* Run the spice file `1T1M.sp` to simualte 1T1M MRAM bit cell.
* `PBSScript` is used to simulate on HPC.


## Files Instruction
* testbench
    * `1T1M.sp` Example testbench for Verilog-a model (conduction and LLGS fully written in Verilog-A). Simulate either `MTJ.va` or `MTJ2.va`.

* Verilog-A compact model
    * `32nm_bulk.pm` 32nm BSIM4 MOSFET model
    * `parameters.va` Parameters you need to setup first
    * `constantsfile.va` Physical constants used in this model
    * `MTJ.va` Key file of this model, solving LLG by RK4
    * `MTJ2.va` Key file of this model, solving LLG by spherical method