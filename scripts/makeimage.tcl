#-----------------------------------------------------------
# Vivado v2021.1 (64-bit)
# SW Build 3247384 on Thu Jun 10 19:36:07 MDT 2021
# IP Build 3246043 on Fri Jun 11 00:30:35 MDT 2021
# Start of session at: Mon Dec  6 09:37:17 2021
# Process ID: 438900
# Current directory: /home/rpease/AXISlaveStreamTutorial
# Command line: vivado
# Log file: /home/rpease/AXISlaveStreamTutorial/vivado.log
# Journal file: /home/rpease/AXISlaveStreamTutorial/vivado.jou
#-----------------------------------------------------------
create_project FPGAImageProject ./AXISlaveStreamTutorial/FPGAImageProject -part xc7z020clg400-1
set_property board_part tul.com.tw:pynq-z2:part0:1.0 [current_project]
create_bd_design "FPGABlockDesign"
update_compile_order -fileset sources_1
set_property  ip_repo_paths  . [current_project]
update_ip_catalog
startgroup
create_bd_cell -type ip -vlnv user.org:user:AXISlaveStreamTutorialIP:1.0 AXISlaveStreamTutori_0
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup
set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1} CONFIG.PCW_USE_S_AXI_HP1 {0}] [get_bd_cells processing_system7_0]
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
startgroup
set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1}] [get_bd_cells processing_system7_0]
endgroup
set_property -dict [list CONFIG.c_include_sg {0} CONFIG.c_sg_include_stscntrl_strm {0} CONFIG.c_include_mm2s_dre {1} CONFIG.c_include_s2mm {0}] [get_bd_cells axi_dma_0]
startgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/axi_dma_0/S_AXI_LITE} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_dma_0/S_AXI_LITE]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/AXISlaveStreamTutori_0/slaveregisterfile} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins AXISlaveStreamTutori_0/slaveregisterfile]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/axi_dma_0/M_AXI_MM2S} Slave {/processing_system7_0/S_AXI_HP0} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
endgroup
connect_bd_net [get_bd_pins AXISlaveStreamTutori_0/slavestream_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0]
connect_bd_net [get_bd_pins AXISlaveStreamTutori_0/slavestream_aresetn] [get_bd_pins rst_ps7_0_100M/peripheral_aresetn]
connect_bd_intf_net [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins AXISlaveStreamTutori_0/slavestream]
make_wrapper -files [get_files ./FPGAImageProject/FPGAImageProject.srcs/sources_1/bd/FPGABlockDesign/FPGABlockDesign.bd] -top
add_files -norecurse ./FPGAImageProject/FPGAImageProject.gen/sources_1/bd/FPGABlockDesign/hdl/FPGABlockDesign_wrapper.v
launch_runs impl_1 -to_step write_bitstream -jobs 2
wait_on_run impl_1
