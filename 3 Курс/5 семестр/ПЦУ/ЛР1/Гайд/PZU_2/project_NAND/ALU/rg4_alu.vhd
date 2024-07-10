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
-- CREATED		"Mon Nov 21 00:17:51 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY rg4_alu IS 
	PORT
	(
		Y_1 :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		Y_6 :  IN  STD_LOGIC;
		Y_10 :  IN  STD_LOGIC;
		Y_19 :  IN  STD_LOGIC;
		data_in :  IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
		P_14_nNorm :  OUT  STD_LOGIC;
		P_15_zero :  OUT  STD_LOGIC;
		data_out :  OUT  STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END rg4_alu;

ARCHITECTURE bdf_type OF rg4_alu IS 

COMPONENT rg4
	PORT(sclr : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rg4_shifter
	PORT(distance : IN STD_LOGIC;
		 direction : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_mux0
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT my_or24
	PORT(IN_OR24 : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 RES_OR24 : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	p14 :  STD_LOGIC;
SIGNAL	p15 :  STD_LOGIC;
SIGNAL	rg4 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	y1 :  STD_LOGIC;
SIGNAL	y10 :  STD_LOGIC;
SIGNAL	y19 :  STD_LOGIC;
SIGNAL	y6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;


BEGIN 



b2v_inst : rg4
PORT MAP(sclr => y1,
		 clock => clk,
		 enable => SYNTHESIZED_WIRE_0,
		 data => SYNTHESIZED_WIRE_1,
		 q => rg4);


b2v_inst2 : rg4_shifter
PORT MAP(distance => SYNTHESIZED_WIRE_7,
		 direction => y10,
		 data => SYNTHESIZED_WIRE_3,
		 result => SYNTHESIZED_WIRE_1);


b2v_inst3 : lpm_mux0
PORT MAP(sel => SYNTHESIZED_WIRE_7,
		 data0x => data_in,
		 data1x => rg4,
		 result => SYNTHESIZED_WIRE_3);


SYNTHESIZED_WIRE_7 <= y10 OR y6;


SYNTHESIZED_WIRE_0 <= SYNTHESIZED_WIRE_7 OR y1 OR y19;


b2v_inst6 : my_or24
PORT MAP(IN_OR24 => rg4,
		 RES_OR24 => SYNTHESIZED_WIRE_6);


p15 <= NOT(SYNTHESIZED_WIRE_6);



p14 <= rg4(23) XOR rg4(22);

P_14_nNorm <= p14;
y1 <= Y_1;
y10 <= Y_10;
y6 <= Y_6;
y19 <= Y_19;
P_15_zero <= p15;
data_out <= rg4;

END bdf_type;