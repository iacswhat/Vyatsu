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
-- CREATED		"Sun Nov 20 22:20:19 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY rg1_block IS 
	PORT
	(
		Y_10_SH_R :  IN  STD_LOGIC;
		Y_9_Ariph_SH :  IN  STD_LOGIC;
		Y_8_LD :  IN  STD_LOGIC;
		clock_rg1 :  IN  STD_LOGIC;
		Data_in :  IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
		Data_out :  OUT  STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END rg1_block;

ARCHITECTURE bdf_type OF rg1_block IS 

COMPONENT lpm_mux0
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rg1
	PORT(clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	rg_1 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	tmp2_out :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(23 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_0 <= (tmp2_out & rg_1(22 DOWNTO 0));


b2v_inst : lpm_mux0
PORT MAP(sel => Y_8_LD,
		 data0x => GDFX_TEMP_SIGNAL_0,
		 data1x => Data_in,
		 result => SYNTHESIZED_WIRE_1);


b2v_inst1 : rg1
PORT MAP(clock => clock_rg1,
		 enable => SYNTHESIZED_WIRE_0,
		 data => SYNTHESIZED_WIRE_1,
		 q => rg_1);


SYNTHESIZED_WIRE_2 <= NOT(Y_9_Ariph_SH);



SYNTHESIZED_WIRE_4 <= rg_1(0) AND SYNTHESIZED_WIRE_2;


tmp2_out <= SYNTHESIZED_WIRE_3 OR SYNTHESIZED_WIRE_4;


SYNTHESIZED_WIRE_3 <= Y_9_Ariph_SH AND rg_1(23);


SYNTHESIZED_WIRE_0 <= Y_10_SH_R OR Y_8_LD;

Data_out <= rg_1;

END bdf_type;