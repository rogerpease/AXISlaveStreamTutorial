#!/usr/bin/env python3 
import os 

MYPYNQBOARD="xilinx@192.168.1.128"


PROJECTDIRNAME="AXISlaveStreamTutorial"

os.system("ssh xilinx@192.168.1.128 mkdir /home/xilinx/"+PROJECTDIRNAME)
os.system("scp ./FPGAImageProject/FPGAImageProject.gen/sources_1/bd/FPGABlockDesign/hw_handoff/FPGABlockDesign.hwh xilinx@192.168.1.128:/home/xilinx/"+PROJECTDIRNAME+"/"+PROJECTDIRNAME+".hwh")
os.system("scp ./FPGAImageProject/FPGAImageProject.runs/impl_1/FPGABlockDesign_wrapper.bit xilinx@192.168.1.128:/home/xilinx/"+PROJECTDIRNAME+"/"+PROJECTDIRNAME+".bit")
os.system("scp SendStream.py  "+MYPYNQBOARD+":/home/xilinx/"+PROJECTDIRNAME+"/SendStream.py")
