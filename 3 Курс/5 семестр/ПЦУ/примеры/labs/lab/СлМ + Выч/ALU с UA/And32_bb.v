// megafunction wizard: %LPM_AND%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: lpm_and 

// ============================================================
// File Name: And32.v
// Megafunction Name(s):
// 			lpm_and
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

module And32 (
	data0x,
	data1x,
	data2x,
	result);

	input	[31:0]  data0x;
	input	[31:0]  data1x;
	input	[31:0]  data2x;
	output	[31:0]  result;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: CompactSymbol NUMERIC "0"
// Retrieval info: PRIVATE: GateFunction NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
// Retrieval info: PRIVATE: InputAsBus NUMERIC "0"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: WidthInput NUMERIC "32"
// Retrieval info: PRIVATE: nInput NUMERIC "3"
// Retrieval info: CONSTANT: LPM_SIZE NUMERIC "3"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_AND"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "32"
// Retrieval info: USED_PORT: data0x 0 0 32 0 INPUT NODEFVAL data0x[31..0]
// Retrieval info: USED_PORT: data1x 0 0 32 0 INPUT NODEFVAL data1x[31..0]
// Retrieval info: USED_PORT: data2x 0 0 32 0 INPUT NODEFVAL data2x[31..0]
// Retrieval info: USED_PORT: result 0 0 32 0 OUTPUT NODEFVAL result[31..0]
// Retrieval info: CONNECT: @data 0 0 32 0 data0x 0 0 32 0
// Retrieval info: CONNECT: @data 0 0 32 32 data1x 0 0 32 0
// Retrieval info: CONNECT: @data 0 0 32 64 data2x 0 0 32 0
// Retrieval info: CONNECT: result 0 0 32 0 @result 0 0 32 0
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: GEN_FILE: TYPE_NORMAL And32.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL And32.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL And32.cmp TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL And32.bsf TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL And32_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL And32_bb.v TRUE
// Retrieval info: LIB_FILE: lpm
