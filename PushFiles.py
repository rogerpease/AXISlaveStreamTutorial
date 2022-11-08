#!/usr/bin/env python3 
import os 

MYPYNQBOARD="xilinx@10.0.0.151"


PROJECTDIRNAME="AXISlaveStreamTutorial"

os.system("ssh "+MYPYNQBOARD+" mkdir /home/xilinx/"+PROJECTDIRNAME)
os.system("scp ./FPGAImageProject/FPGAImageProject.gen/sources_1/bd/FPGABlockDesign/hw_handoff/FPGABlockDesign.hwh "+MYPYNQBOARD+":/home/xilinx/"+PROJECTDIRNAME+"/"+PROJECTDIRNAME+".hwh")
os.system("scp ./FPGAImageProject/FPGAImageProject.runs/impl_1/FPGABlockDesign_wrapper.bit "+MYPYNQBOARD+":/home/xilinx/"+PROJECTDIRNAME+"/"+PROJECTDIRNAME+".bit")
os.system("scp SendStream.py  "+MYPYNQBOARD+":/home/xilinx/"+PROJECTDIRNAME+"/SendStream.py")
