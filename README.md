# AXISlaveStreamTutorial


## Purpose

This tutorial is meant for Verilog programmers who want to use the Xilinx ZYNQ 7000 to stream through an AXI Slave Interface. 


## Versions/Equipment:
   PYNQ 2.6 image
   TUL-2 Board 
   Vivado 2021.1 

## Steps 

### Step 1) Build Verilog model 

In this case I took verilog from the AXI Peripherals and edited it to build a simple counting interface. 
There are three modules:

* [TopLevelModule](http://github.com/rogerpease/AXISlaveStreamTutorial/Verilog/module/AXISlaveStreamTutorialIP.v)  Top Level 
* [SlaveStream](file:http://github.com/rogerpease/AXISlaveStreamTutorial/Verilog/modules/AXISlaveStreamTutorialIP_SlaveStream.v) Accumulates Data.
* [RegisterFile](file:http://github.com/rogerpease/AXISlaveStreamTutorial/Verilog/modules/AXISlaveStreamTutorialIP_SlaveRegisterFile.v) Holds read-back total 

### Step 2) Package IP

The simplest way to package the IP through the gui is:
1 Create a new project (call it whatever you want). 
1 

[RegisterFile](file:http://github.com/rogerpease/AXISlaveStreamTutorial/Verilog/modules/AXISlaveStreamTutorialIP_SlaveRegisterFile.v) Holds read-back total 

### Step 3) Make an FPGA Image and instance the IP 






