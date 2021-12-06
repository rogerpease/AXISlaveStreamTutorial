
`timescale 1 ns / 1 ps

	module AXISlaveStreamTutorialIP #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface SlaveRegisterFile
		parameter integer C_SlaveRegisterFile_DATA_WIDTH	= 32,
		parameter integer C_SlaveRegisterFile_ADDR_WIDTH	= 4,

		// Parameters of Axi Slave Bus Interface SlaveStream
		parameter integer C_SlaveStream_TDATA_WIDTH	= 32
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface SlaveRegisterFile
		input wire  slaveregisterfile_aclk,
		input wire  slaveregisterfile_aresetn,
		input wire [C_SlaveRegisterFile_ADDR_WIDTH-1 : 0] slaveregisterfile_awaddr,
		input wire [2 : 0] slaveregisterfile_awprot,
		input wire  slaveregisterfile_awvalid,
		output wire  slaveregisterfile_awready,
		input wire [C_SlaveRegisterFile_DATA_WIDTH-1 : 0] slaveregisterfile_wdata,
		input wire [(C_SlaveRegisterFile_DATA_WIDTH/8)-1 : 0] slaveregisterfile_wstrb,
		input wire  slaveregisterfile_wvalid,
		output wire  slaveregisterfile_wready,
		output wire [1 : 0] slaveregisterfile_bresp,
		output wire  slaveregisterfile_bvalid,
		input wire  slaveregisterfile_bready,
		input wire [C_SlaveRegisterFile_ADDR_WIDTH-1 : 0] slaveregisterfile_araddr,
		input wire [2 : 0] slaveregisterfile_arprot,
		input wire  slaveregisterfile_arvalid,
		output wire  slaveregisterfile_arready,
		output wire [C_SlaveRegisterFile_DATA_WIDTH-1 : 0] slaveregisterfile_rdata,
		output wire [1 : 0] slaveregisterfile_rresp,
		output wire  slaveregisterfile_rvalid,
		input wire  slaveregisterfile_rready,

		// Ports of Axi Slave Bus Interface SlaveStream
		input wire  slavestream_aclk,
		input wire  slavestream_aresetn,
		output wire  slavestream_tready,
		input wire [C_SlaveStream_TDATA_WIDTH-1 : 0] slavestream_tdata,
		input wire [(C_SlaveStream_TDATA_WIDTH/8)-1 : 0] slavestream_tstrb,
		input wire  slavestream_tlast,
		input wire  slavestream_tvalid
	);

        wire [31:0] controlRegister; 
        wire [31:0] totalRegister; 

// Instantiation of Axi Bus Interface SlaveRegisterFile
	AXISlaveStreamTutorialIP_SlaveRegisterFile # ( 
		.C_S_AXI_DATA_WIDTH(C_SlaveRegisterFile_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_SlaveRegisterFile_ADDR_WIDTH)
	) AXISlaveStreamTutorialIP_SlaveRegisterFile_inst (
                .controlRegister(controlRegister), 
                .totalRegister  (totalRegister), 
		.S_AXI_ACLK(slaveregisterfile_aclk),
		.S_AXI_ARESETN(slaveregisterfile_aresetn),
		.S_AXI_AWADDR(slaveregisterfile_awaddr),
		.S_AXI_AWPROT(slaveregisterfile_awprot),
		.S_AXI_AWVALID(slaveregisterfile_awvalid),
		.S_AXI_AWREADY(slaveregisterfile_awready),
		.S_AXI_WDATA(slaveregisterfile_wdata),
		.S_AXI_WSTRB(slaveregisterfile_wstrb),
		.S_AXI_WVALID(slaveregisterfile_wvalid),
		.S_AXI_WREADY(slaveregisterfile_wready),
		.S_AXI_BRESP(slaveregisterfile_bresp),
		.S_AXI_BVALID(slaveregisterfile_bvalid),
		.S_AXI_BREADY(slaveregisterfile_bready),
		.S_AXI_ARADDR(slaveregisterfile_araddr),
		.S_AXI_ARPROT(slaveregisterfile_arprot),
		.S_AXI_ARVALID(slaveregisterfile_arvalid),
		.S_AXI_ARREADY(slaveregisterfile_arready),
		.S_AXI_RDATA(slaveregisterfile_rdata),
		.S_AXI_RRESP(slaveregisterfile_rresp),
		.S_AXI_RVALID(slaveregisterfile_rvalid),
		.S_AXI_RREADY(slaveregisterfile_rready)
	);

// Instantiation of Axi Bus Interface SlaveStream
	AXISlaveStreamTutorialIP_SlaveStream # ( 
		.C_S_AXIS_TDATA_WIDTH(C_SlaveStream_TDATA_WIDTH)
	) AXISlaveStreamTutorialIP_SlaveStream_inst (
                .controlRegister(controlRegister), 
                .totalRegister  (totalRegister), 
		.S_AXIS_ACLK(slavestream_aclk),
		.S_AXIS_ARESETN(slavestream_aresetn),
		.S_AXIS_TREADY(slavestream_tready),
		.S_AXIS_TDATA(slavestream_tdata),
		.S_AXIS_TSTRB(slavestream_tstrb),
		.S_AXIS_TLAST(slavestream_tlast),
		.S_AXIS_TVALID(slavestream_tvalid)
	);

	// Add user logic here

	// User logic ends

	endmodule
