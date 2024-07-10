// megafunction wizard: %LPM_SHIFTREG%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: lpm_shiftreg 

// ============================================================
// File Name: RG1.v
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
module RG1 (
	clock,
	data,
	enable,
	load,
	sclr,
	shiftin,
	q);

	input	  clock;
	input	[24:0]  data;
	input	  enable;
	input	  load;
	input	  sclr;
	input	  shiftin;
	output	[24:0]  q;

	wire [24:0] sub_wire0;
	wire [24:0] q = sub_wire0[24:0];

	lpm_shiftreg	lpm_shiftreg_component (
				.enable (enable),
				.load (load),
				.sclr (sclr),
				.clock (clock),
				.data (data),
				.shiftin (shiftin),
				.q (sub_wire0)
				// synopsys translate_off
				,
				.aclr (),
				.aset (),
				.shiftout (),
				.sset ()
				// synopsys translate_on
				);
	defparam
		lpm_shiftreg_component.lpm_direction = "RIGHT",
		lpm_shiftreg_component.lpm_type = "LPM_SHIFTREG",
		lpm_shiftreg_component.lpm_width = 25;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ACLR NUMERIC "0"
// Retrieval info: PRIVATE: ALOAD NUMERIC "0"
// Retrieval info: PRIVATE: ASET NUMERIC "0"
// Retrieval info: PRIVATE: ASET_ALL1 NUMERIC "1"
// Retrieval info: PRIVATE: CLK_EN NUMERIC "1"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
// Retrieval info: PRIVATE: LeftShift NUMERIC "0"
// Retrieval info: PRIVATE: ParallelDataInput NUMERIC "1"
// Retrieval info: PRIVATE: Q_OUT NUMERIC "1"
// Retrieval info: PRIVATE: SCLR NUMERIC "1"
// Retrieval info: PRIVATE: SLOAD NUMERIC "1"
// Retrieval info: PRIVATE: SSET NUMERIC "0"
// Retrieval info: PRIVATE: SSET_ALL1 NUMERIC "1"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: SerialShiftInput NUMERIC "1"
// Retrieval info: PRIVATE: SerialShiftOutput NUMERIC "0"
// Retrieval info: PRIVATE: nBit NUMERIC "25"
// Retrieval info: CONSTANT: LPM_DIRECTION STRING "RIGHT"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_SHIFTREG"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "25"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL clock
// Retrieval info: USED_PORT: data 0 0 25 0 INPUT NODEFVAL data[24..0]
// Retrieval info: USED_PORT: enable 0 0 0 0 INPUT NODEFVAL enable
// Retrieval info: USED_PORT: load 0 0 0 0 INPUT NODEFVAL load
// Retrieval info: USED_PORT: q 0 0 25 0 OUTPUT NODEFVAL q[24..0]
// Retrieval info: USED_PORT: sclr 0 0 0 0 INPUT NODEFVAL sclr
// Retrieval info: USED_PORT: shiftin 0 0 0 0 INPUT NODEFVAL shiftin
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: q 0 0 25 0 @q 0 0 25 0
// Retrieval info: CONNECT: @enable 0 0 0 0 enable 0 0 0 0
// Retrieval info: CONNECT: @shiftin 0 0 0 0 shiftin 0 0 0 0
// Retrieval info: CONNECT: @load 0 0 0 0 load 0 0 0 0
// Retrieval info: CONNECT: @sclr 0 0 0 0 sclr 0 0 0 0
// Retrieval info: CONNECT: @data 0 0 25 0 data 0 0 25 0
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: GEN_FILE: TYPE_NORMAL RG1.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL RG1.inc TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL RG1.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL RG1.bsf TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL RG1_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL RG1_bb.v TRUE
// Retrieval info: LIB_FILE: lpm
