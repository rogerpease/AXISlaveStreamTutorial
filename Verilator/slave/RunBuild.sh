#!/bin/sh 

set -e 
verilator ../../Verilog/module/AXISlaveStreamTutorialIP_SlaveStream.v --cc  --exe TestModule.cpp AXISlaveStreamVerification.cpp --build
./obj_dir/VAXISlaveStreamTutorialIP_SlaveStream
exit 0
