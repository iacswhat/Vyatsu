-- megafunction wizard: %LPM_MUX%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: lpm_mux 

-- ============================================================
-- File Name: SMUX.vhd
-- Megafunction Name(s):
-- 			lpm_mux
--
-- Simulation Library Files(s):
-- 			lpm
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 9.1 Build 350 03/24/2010 SP 2 SJ Web Edition
-- ************************************************************


--Copyright (C) 1991-2010 Altera Corporation
--Your use of Altera Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Altera Program License 
--Subscription Agreement, Altera MegaCore Function License 
--Agreement, or other applicable license agreement, including, 
--without limitation, that your use is for the sole purpose of 
--programming logic devices manufactured by Altera and sold by 
--Altera or its authorized distributors.  Please refer to the 
--applicable agreement for further details.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.lpm_components.all;

ENTITY SMUX IS
	PORT
	(
		data0x		: IN STD_LOGIC_VECTOR (23 DOWNTO 0);
		data1x		: IN STD_LOGIC_VECTOR (23 DOWNTO 0);
		sel		: IN STD_LOGIC ;
		result		: OUT STD_LOGIC_VECTOR (23 DOWNTO 0)
	);
END SMUX;


ARCHITECTURE SYN OF smux IS

--	type STD_LOGIC_2D is array (NATURAL RANGE <>, NATURAL RANGE <>) of STD_LOGIC;

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (23 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC ;
	SIGNAL sub_wire2	: STD_LOGIC_VECTOR (0 DOWNTO 0);
	SIGNAL sub_wire3	: STD_LOGIC_VECTOR (23 DOWNTO 0);
	SIGNAL sub_wire4	: STD_LOGIC_2D (1 DOWNTO 0, 23 DOWNTO 0);
	SIGNAL sub_wire5	: STD_LOGIC_VECTOR (23 DOWNTO 0);

BEGIN
	sub_wire5    <= data0x(23 DOWNTO 0);
	result    <= sub_wire0(23 DOWNTO 0);
	sub_wire1    <= sel;
	sub_wire2(0)    <= sub_wire1;
	sub_wire3    <= data1x(23 DOWNTO 0);
	sub_wire4(1, 0)    <= sub_wire3(0);
	sub_wire4(1, 1)    <= sub_wire3(1);
	sub_wire4(1, 2)    <= sub_wire3(2);
	sub_wire4(1, 3)    <= sub_wire3(3);
	sub_wire4(1, 4)    <= sub_wire3(4);
	sub_wire4(1, 5)    <= sub_wire3(5);
	sub_wire4(1, 6)    <= sub_wire3(6);
	sub_wire4(1, 7)    <= sub_wire3(7);
	sub_wire4(1, 8)    <= sub_wire3(8);
	sub_wire4(1, 9)    <= sub_wire3(9);
	sub_wire4(1, 10)    <= sub_wire3(10);
	sub_wire4(1, 11)    <= sub_wire3(11);
	sub_wire4(1, 12)    <= sub_wire3(12);
	sub_wire4(1, 13)    <= sub_wire3(13);
	sub_wire4(1, 14)    <= sub_wire3(14);
	sub_wire4(1, 15)    <= sub_wire3(15);
	sub_wire4(1, 16)    <= sub_wire3(16);
	sub_wire4(1, 17)    <= sub_wire3(17);
	sub_wire4(1, 18)    <= sub_wire3(18);
	sub_wire4(1, 19)    <= sub_wire3(19);
	sub_wire4(1, 20)    <= sub_wire3(20);
	sub_wire4(1, 21)    <= sub_wire3(21);
	sub_wire4(1, 22)    <= sub_wire3(22);
	sub_wire4(1, 23)    <= sub_wire3(23);
	sub_wire4(0, 0)    <= sub_wire5(0);
	sub_wire4(0, 1)    <= sub_wire5(1);
	sub_wire4(0, 2)    <= sub_wire5(2);
	sub_wire4(0, 3)    <= sub_wire5(3);
	sub_wire4(0, 4)    <= sub_wire5(4);
	sub_wire4(0, 5)    <= sub_wire5(5);
	sub_wire4(0, 6)    <= sub_wire5(6);
	sub_wire4(0, 7)    <= sub_wire5(7);
	sub_wire4(0, 8)    <= sub_wire5(8);
	sub_wire4(0, 9)    <= sub_wire5(9);
	sub_wire4(0, 10)    <= sub_wire5(10);
	sub_wire4(0, 11)    <= sub_wire5(11);
	sub_wire4(0, 12)    <= sub_wire5(12);
	sub_wire4(0, 13)    <= sub_wire5(13);
	sub_wire4(0, 14)    <= sub_wire5(14);
	sub_wire4(0, 15)    <= sub_wire5(15);
	sub_wire4(0, 16)    <= sub_wire5(16);
	sub_wire4(0, 17)    <= sub_wire5(17);
	sub_wire4(0, 18)    <= sub_wire5(18);
	sub_wire4(0, 19)    <= sub_wire5(19);
	sub_wire4(0, 20)    <= sub_wire5(20);
	sub_wire4(0, 21)    <= sub_wire5(21);
	sub_wire4(0, 22)    <= sub_wire5(22);
	sub_wire4(0, 23)    <= sub_wire5(23);

	lpm_mux_component : lpm_mux
	GENERIC MAP (
		lpm_size => 2,
		lpm_type => "LPM_MUX",
		lpm_width => 24,
		lpm_widths => 1
	)
	PORT MAP (
		sel => sub_wire2,
		data => sub_wire4,
		result => sub_wire0
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone III"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: CONSTANT: LPM_SIZE NUMERIC "2"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_MUX"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "24"
-- Retrieval info: CONSTANT: LPM_WIDTHS NUMERIC "1"
-- Retrieval info: USED_PORT: data0x 0 0 24 0 INPUT NODEFVAL data0x[23..0]
-- Retrieval info: USED_PORT: data1x 0 0 24 0 INPUT NODEFVAL data1x[23..0]
-- Retrieval info: USED_PORT: result 0 0 24 0 OUTPUT NODEFVAL result[23..0]
-- Retrieval info: USED_PORT: sel 0 0 0 0 INPUT NODEFVAL sel
-- Retrieval info: CONNECT: result 0 0 24 0 @result 0 0 24 0
-- Retrieval info: CONNECT: @data 1 1 24 0 data1x 0 0 24 0
-- Retrieval info: CONNECT: @data 1 0 24 0 data0x 0 0 24 0
-- Retrieval info: CONNECT: @sel 0 0 1 0 sel 0 0 0 0
-- Retrieval info: LIBRARY: lpm lpm.lpm_components.all
-- Retrieval info: GEN_FILE: TYPE_NORMAL SMUX.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL SMUX.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL SMUX.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL SMUX.bsf TRUE FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL SMUX_inst.vhd FALSE
-- Retrieval info: LIB_FILE: lpm
