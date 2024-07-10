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
-- CREATED		"Sun Nov 20 19:32:07 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY rg3_sm2_ms1_ct2_block IS 
	PORT
	(
		Y_2 :  IN  STD_LOGIC;
		Y_3 :  IN  STD_LOGIC;
		Y_4 :  IN  STD_LOGIC;
		Y_5 :  IN  STD_LOGIC;
		Y_6 :  IN  STD_LOGIC;
		Y_7 :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		X_30_23 :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		SM2_CRP :  OUT  STD_LOGIC;
		CT2 :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END rg3_sm2_ms1_ct2_block;

ARCHITECTURE bdf_type OF rg3_sm2_ms1_ct2_block IS 

COMPONENT ct2_alu
	PORT(sclr : IN STD_LOGIC;
		 sload : IN STD_LOGIC;
		 updown : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 cnt_en : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ms1_alu
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rg3_alu
	PORT(clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sm2_alu
	PORT(dataa : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 cout : OUT STD_LOGIC;
		 result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	CT2_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	not_x7 :  STD_LOGIC;
SIGNAL	X :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(7 DOWNTO 0);

SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_0 <= (not_x7 & X(6 DOWNTO 0));


b2v_inst : ct2_alu
PORT MAP(sclr => Y_7,
		 sload => Y_4,
		 updown => Y_5,
		 clock => clk,
		 cnt_en => SYNTHESIZED_WIRE_0,
		 data => SYNTHESIZED_WIRE_1,
		 q => CT2_out);


b2v_inst1 : ms1_alu
PORT MAP(sel => Y_3,
		 data0x => SYNTHESIZED_WIRE_2,
		 data1x => GDFX_TEMP_SIGNAL_0,
		 result => SYNTHESIZED_WIRE_1);


SYNTHESIZED_WIRE_0 <= Y_6 OR Y_5;


b2v_inst3 : rg3_alu
PORT MAP(clock => clk,
		 enable => Y_2,
		 data => X,
		 q => SYNTHESIZED_WIRE_3);


b2v_inst4 : sm2_alu
PORT MAP(dataa => SYNTHESIZED_WIRE_3,
		 datab => CT2_out,
		 cout => SM2_CRP,
		 result => SYNTHESIZED_WIRE_2);


not_x7 <= NOT(X(7));


X <= X_30_23;
CT2 <= CT2_out;

END bdf_type;