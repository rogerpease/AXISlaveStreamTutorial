#!/usr/bin/env python3 

from pynq import Overlay
from pynq import allocate

overlay = Overlay("AXISlaveStreamTutorial.bit")

output_buffer    = allocate(shape=(8,),dtype='u4')
output_buffer[:] = [x*10 for x in range(1,9)] 
overlay.axi_dma_0.sendchannel.start()
overlay.axi_dma_0.sendchannel.transfer(output_buffer)
output_buffer[:] = [x*20 for x in range(1,9)] 
overlay.axi_dma_0.sendchannel.transfer(output_buffer)
overlay.axi_dma_0.sendchannel.wait() 
overlay.axi_dma_0.sendchannel.stop() 

total = overlay.AXISlaveStreamTutori_0.read(0x04)

#
# This should be the total of all the values written. 
# 10-80 by tens sums to 360, 20-160 to 720 so the total should be 1080.  
#

if (total == 1080):
  print("PASS") 
else:
  print("FAIL!", total) 
