# AXISlaveStreamTutorial


## Purpose

This tutorial is meant for Verilog programmers who want to use the Xilinx ZYNQ 7000 to stream through an AXI Slave Interface. 

## Versions/Equipment:

* PYNQ 2.6 image
* TUL-2 Board 
* Vivado 2021.1 

## Steps 

### Step 1) Build Verilog model 

In this case I took verilog from the AXI Peripherals and edited it to build a simple counting interface. 
There are three modules:

* [TopLevelModule](http://github.com/rogerpease/AXISlaveStreamTutorial/Verilog/module/AXISlaveStreamTutorialIP.v  "Top Level")
* [SlaveStream](http://github.com/rogerpease/AXISlaveStreamTutorial/Verilog/modules/AXISlaveStreamTutorialIP_SlaveStream.v) which takes in an AXI stream and accumulates data. 
* [RegisterFile](http://github.com/rogerpease/AXISlaveStreamTutorial/Verilog/modules/AXISlaveStreamTutorialIP_SlaveRegisterFile.v) which interfaces to the CPU to return summed results.   

### Step 2) Package IP

The simplest way to package the IP through the gui is:

1. git clone http://github.com/rogerpease/AXISlaveStreamTutorial 
1. cd AXISlaveStreamTutorial 
1. Start Vivado and Create a new project (call it whatever you want). 
1. Tools->Create and Package New IP
1. Select the AXISlaveStreamTutorial directory 
1. It should figure out the AXI interfaces. All you should need to do is fill in the names of the IP and User and click 'Package IP'. 

These steps are captured for automation in the [RunPackageIP.py](http://github.com/rogerpease/AXISlaveStreamTutorial/RunPackageIP.py) script.  

### Step 3) Make an FPGA Image and instance the IP 

1. Start Vivado and Create a new project (I call mine FPGAImageProject). 
1. Click "Create Block Design" and make a new Block design.  
1. Add the AXISlaveStreamTutorial directory as an IP Repository. It should find one directory.  
1. Add the following:
2. ZYNQ 7000 
2. "AXI Direct Memory Access" 
2. AXISlaveStreamTutorialIP 
1. Run "Run Block Automation" (should be an option in a ribbon at the top of the Block Diagram). 
1. Update the ZYNQ 7000 to include a Slave High Performance Port. 
1. Update the AXI Direct Memory Access to:
2. Remove the Write Channel 
2. Turn off Scatter-Gather 
1. Run "Run Connection Automation" 
1. Go to the "FPGA Image" sources area and click "Generate HDL Wrapper". The tool that makes the netlists can't read a Block Diagram. 
1. Run "Generate Bitstream"

You should find a .bit file and .hwh file in your directory  

These steps are captured for automation in the [RunMakeImage.py](http://github.com/rogerpease/AXISlaveStreamTutorial/RunMakeImage.py) script.  

### Step 4) Upload FPGA Image to your ZYNQ

I normally upload to /home/xilinx/AXISlaveStreamTutorial 

There is a [SendStream.py](http://github.com/rogerpease/AXISlaveStreamTutorial/SendStream.py) script which will:
1. Stream in numbers to the streaming interface. *BE SURE TO RUN THE SCRIPT AS ROOT* 
1. Those numbers are summed together and the result is placed in the Register File. 
1. The total is read back the sum through the register file. 

The copy steps are captured for automation in the 
[PushFiles.py](http://github.com/rogerpease/AXISlaveStreamTutorial/PushFiles.py) script.  
