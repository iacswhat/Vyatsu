// megafunction wizard: %LPM_SHIFTREG%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: lpm_shiftreg 

// ============================================================
// File Name: RG3.v
// Megafunction Name(s):
// 			lpm_shiftreg
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 9.1 Build 350 03/24/2010 SP 2 SJ Web Edition
// ************************************************************


//Copyright (C) 1991-2010 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module RG3 (
	aclr,
	clock,
	data,
	enable,
	load,
	shiftin,
	q);

	input	  aclr;
	input	  clock;
	input	[47:0]  data;
	input	  enable;
	input	  load;
	input	  shiftin;
	output	[47:0]  q;

	wire [47:0] sub_wire0;
	wire [47:0] q = sub_wire0[47:0];

	lpm_shiftreg	lpm_shiftreg_component (
				.enable (enable),
				.load (load),
				.aclr (aclr),
				.clock (clock),
				.data (data),
				.shiftin (shiftin),
				.q (sub_wire0)
				// synopsys translate_off
				,
				.aset (),
				.sclr (),
				.shiftout (),
				.sset ()
				// synopsys translate_on
				);
	defparam
		lpm_shiftreg_component.lpm_direction = "LEFT",
		lpm_shiftreg_component.lpm_type = "LPM_SHIFTREG",
		lpm_shiftreg_component.lpm_width = 48;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ACLR NUMERIC "1"
// Retrieval info: PRIVATE: ALOAD NUMERIC "0"
// Retrieval info: PRIVATE: ASET NUMERIC "0"
// Retrieval info: PRIVATE: ASET_ALL1 NUMERIC "1"
// Retrieval info: PRIVATE: CLK_EN NUMERIC "1"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
// Retrieval info: PRIVATE: LeftShift NUMERIC "1"
// Retrieval info: PRIVATE: ParallelDataInput NUMERIC "1"
// Retrieval info: PRIVATE: Q_OUT NUMERIC "1"
// Retrieval info: PRIVATE: SCLR NUMERIC "0"
// Retrieval info: PRIVATE: SLOAD NUMERIC "1"
// Retrieval info: PRIVATE: SSET NUMERIC "0"
// Retrieval info: PRIVATE: SSET_ALL1 NUMERIC "1"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: SerialShiftInput NUMERIC "1"
// Retrieval info: PRIVATE: SerialShiftOutput NUMERIC "0"
// Retrieval info: PRIVATE: nBit NUMERIC "48"
// Retrieval info: CONSTANT: LPM_DIRECTION STRING "LEFT"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_SHIFTREG"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "48"
// Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT NODEFVAL aclr
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL clock
// Retrieval info: USED_PORT: data 0 0 48 0 INPUT NODEFVAL data[47..0]
// Retrieval info: USED_PORT: enable 0 0 0 0 INPUT NODEFVAL enable
// Retrieval info: USED_PORT: load 0 0 0 0 INPUT NODEFVAL load
// Retrieval info: USED_PORT: q 0 0 48 0 OUTPUT NODEFVAL q[47..0]
// Retrieval info: USED_PORT: shiftin 0 0 0 0 INPUT NODEFVAL shiftin
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: q 0 0 48 0 @q 0 0 48 0
// Retrieval info: CONNECT: @enable 0 0 0 0 enable 0 0 0 0
// Retrieval info: CONNECT: @shiftin 0 0 0 0 shiftin 0 0 0 0
// Retrieval info: CONNECT: @load 0 0 0 0 load 0 0 0 0
// Retrieval info: CONNECT: @aclr 0 0 0 0 aclr 0 0 0 0
// Retrieval info: CONNECT: @data 0 0 48 0 data 0 0 48 0
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: GEN_FILE: TYPE_NORMAL RG3.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL RG3.inc TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL RG3.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL RG3.bsf TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL RG3_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL RG3_bb.v TRUE
// Retrieval info: LIB_FILE: lpm
