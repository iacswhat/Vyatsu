-- Copyright (C) 1991-2010 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II"
-- VERSION		"Version 9.1 Build 350 03/24/2010 Service Pack 2 SJ Web Edition"
-- CREATED		"Sun Nov 20 20:11:21 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ks1_t1_block IS 
	PORT
	(
		from_CT2_CRP :  IN  STD_LOGIC;
		Y_4 :  IN  STD_LOGIC;
		from_CT2 :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		P_1_PRS :  OUT  STD_LOGIC;
		P_2_VPRS :  OUT  STD_LOGIC;
		P_3_PMR :  OUT  STD_LOGIC
	);
END ks1_t1_block;

ARCHITECTURE bdf_type OF ks1_t1_block IS 

COMPONENT ks1_alu
	PORT(data0 : IN STD_LOGIC;
		 data1 : IN STD_LOGIC;
		 data2 : IN STD_LOGIC;
		 data3 : IN STD_LOGIC;
		 data4 : IN STD_LOGIC;
		 data5 : IN STD_LOGIC;
		 data6 : IN STD_LOGIC;
		 result : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	tmp1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;


BEGIN 
P_2_VPRS <= SYNTHESIZED_WIRE_1;



P_1_PRS <= SYNTHESIZED_WIRE_0 AND SYNTHESIZED_WIRE_1;


PROCESS(Y_4)
BEGIN
IF (RISING_EDGE(Y_4)) THEN
	SYNTHESIZED_WIRE_2 <= from_CT2_CRP;
END IF;
END PROCESS;


b2v_inst2 : ks1_alu
PORT MAP(data0 => tmp1(6),
		 data1 => tmp1(5),
		 data2 => tmp1(4),
		 data3 => tmp1(3),
		 data4 => tmp1(2),
		 data5 => tmp1(1),
		 data6 => tmp1(0),
		 result => SYNTHESIZED_WIRE_0);


SYNTHESIZED_WIRE_1 <= tmp1(7) AND SYNTHESIZED_WIRE_2;


P_3_PMR <= NOT(SYNTHESIZED_WIRE_2 OR tmp1(7));

tmp1 <= from_CT2;

END bdf_type;