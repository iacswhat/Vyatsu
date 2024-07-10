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
-- CREATED		"Mon Nov 21 01:25:48 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY cascade_rg4_block IS 
	PORT
	(
		Y_19 :  IN  STD_LOGIC;
		Y_10 :  IN  STD_LOGIC;
		Y_6 :  IN  STD_LOGIC;
		Y_1 :  IN  STD_LOGIC;
		Y_12 :  IN  STD_LOGIC;
		Y_18 :  IN  STD_LOGIC;
		Y_17 :  IN  STD_LOGIC;
		Y_13 :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		from_T3 :  IN  STD_LOGIC;
		node_for_p12 :  IN  STD_LOGIC;
		From_KS3 :  IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
		From_KS5 :  IN  STD_LOGIC_VECTOR(22 DOWNTO 0);
		From_KS6 :  IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
		From_RG1 :  IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
		P_15 :  OUT  STD_LOGIC;
		P_14 :  OUT  STD_LOGIC;
		P_12 :  OUT  STD_LOGIC;
		P_13 :  OUT  STD_LOGIC;
		RG4_out :  OUT  STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END cascade_rg4_block;

ARCHITECTURE bdf_type OF cascade_rg4_block IS 

COMPONENT rg4_alu
	PORT(Y_19 : IN STD_LOGIC;
		 Y_10 : IN STD_LOGIC;
		 Y_6 : IN STD_LOGIC;
		 Y_1 : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 P_15_zero : OUT STD_LOGIC;
		 P_14_nNorm : OUT STD_LOGIC;
		 data_out : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ms3
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sm1_alu
	PORT(cin : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ms5_alu
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT const_h400000
	PORT(		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ms6
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	fks5 :  STD_LOGIC_VECTOR(22 DOWNTO 0);
SIGNAL	log0 :  STD_LOGIC;
SIGNAL	p12 :  STD_LOGIC;
SIGNAL	p13 :  STD_LOGIC;
SIGNAL	p14 :  STD_LOGIC;
SIGNAL	p15 :  STD_LOGIC;
SIGNAL	rg4 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	y1 :  STD_LOGIC;
SIGNAL	y10 :  STD_LOGIC;
SIGNAL	y12 :  STD_LOGIC;
SIGNAL	y13 :  STD_LOGIC;
SIGNAL	y17 :  STD_LOGIC;
SIGNAL	y18 :  STD_LOGIC;
SIGNAL	y19 :  STD_LOGIC;
SIGNAL	y6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(23 DOWNTO 0);

SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(23 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_0 <= (log0 & fks5(22 DOWNTO 0));
GDFX_TEMP_SIGNAL_1 <= (log0 & rg4(22 DOWNTO 0));


b2v_inst : rg4_alu
PORT MAP(Y_19 => y19,
		 Y_10 => y10,
		 Y_6 => y6,
		 Y_1 => y1,
		 clk => clk,
		 data_in => SYNTHESIZED_WIRE_0,
		 P_15_zero => p15,
		 P_14_nNorm => p14,
		 data_out => rg4);


b2v_inst1 : ms3
PORT MAP(sel => y13,
		 data0x => From_KS3,
		 data1x => GDFX_TEMP_SIGNAL_0,
		 result => SYNTHESIZED_WIRE_1);


p13 <= rg4(22) XOR from_T3;



b2v_inst3 : ms3
PORT MAP(sel => y13,
		 data0x => From_RG1,
		 data1x => GDFX_TEMP_SIGNAL_1,
		 result => SYNTHESIZED_WIRE_2);


b2v_inst4 : sm1_alu
PORT MAP(cin => y12,
		 dataa => SYNTHESIZED_WIRE_1,
		 datab => SYNTHESIZED_WIRE_2,
		 result => SYNTHESIZED_WIRE_3);


b2v_inst5 : ms5_alu
PORT MAP(sel => y18,
		 data0x => SYNTHESIZED_WIRE_3,
		 data1x => SYNTHESIZED_WIRE_4,
		 result => SYNTHESIZED_WIRE_5);


b2v_inst6 : const_h400000
PORT MAP(		 result => SYNTHESIZED_WIRE_4);


b2v_inst7 : ms6
PORT MAP(sel => y17,
		 data0x => SYNTHESIZED_WIRE_5,
		 data1x => From_KS6,
		 result => SYNTHESIZED_WIRE_0);


p12 <= rg4(23) AND node_for_p12;

P_15 <= p15;
y19 <= Y_19;
y10 <= Y_10;
y6 <= Y_6;
y1 <= Y_1;
y17 <= Y_17;
y18 <= Y_18;
y12 <= Y_12;
y13 <= Y_13;
fks5 <= From_KS5;
P_14 <= p14;
P_12 <= p12;
P_13 <= p13;
RG4_out <= rg4;

log0 <= '0';
END bdf_type;