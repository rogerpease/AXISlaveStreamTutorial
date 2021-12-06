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
       [TopLevelModule](http://github.com/rogerpease/AXISlaveStreamTutorial/Verilog/modules) Top Level 
       [SlaveStream](file:http://github.com/rogerpease/AXISlaveStreamTutorial/Verilog/modules/SlaveStream)  
       [RegisterFile](file:http://github.com/rogerpease/AXISlaveStreamTutorial/Verilog/modules)  

-rw-rw-r-- 1 rpease rpease 13481 Dec  6 16:15 Verilog/module/AXISlaveStreamTutorialIP_SlaveRegisterFile.v
-rw-rw-r-- 1 rpease rpease  4803 Dec  6 16:15 Verilog/module/AXISlaveStreamTutorialIP_SlaveStream.v
-rw-rw-r-- 1 rpease rpease  4006 Dec  6 16:15 Verilog/module/AXISlaveStreamTutorialIP.v


### Step 2) Package IP.

The simplest way to package the IP through the gui is:
   1) Create a new project (call it whatever you want). 







