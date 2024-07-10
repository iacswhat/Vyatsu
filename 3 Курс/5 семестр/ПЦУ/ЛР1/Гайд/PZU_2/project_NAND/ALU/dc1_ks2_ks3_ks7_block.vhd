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
-- CREATED		"Sun Nov 20 23:37:24 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY dc1_ks2_ks3_ks7_block IS 
	PORT
	(
		not_CT2_7 :  IN  STD_LOGIC;
		CT2_7 :  IN  STD_LOGIC;
		Y_20 :  IN  STD_LOGIC;
		from_CT2 :  IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
		out_P_9 :  OUT  STD_LOGIC;
		out_P_11 :  OUT  STD_LOGIC;
		out_P_10 :  OUT  STD_LOGIC;
		to_MS3_out :  OUT  STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END dc1_ks2_ks3_ks7_block;

ARCHITECTURE bdf_type OF dc1_ks2_ks3_ks7_block IS 

COMPONENT dc1_alu
	PORT(data : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 eq0 : OUT STD_LOGIC;
		 eq1 : OUT STD_LOGIC;
		 eq2 : OUT STD_LOGIC;
		 eq3 : OUT STD_LOGIC;
		 eq4 : OUT STD_LOGIC;
		 eq5 : OUT STD_LOGIC;
		 eq6 : OUT STD_LOGIC;
		 eq7 : OUT STD_LOGIC;
		 eq8 : OUT STD_LOGIC;
		 eq9 : OUT STD_LOGIC;
		 eq10 : OUT STD_LOGIC;
		 eq11 : OUT STD_LOGIC;
		 eq12 : OUT STD_LOGIC;
		 eq13 : OUT STD_LOGIC;
		 eq14 : OUT STD_LOGIC;
		 eq15 : OUT STD_LOGIC;
		 eq16 : OUT STD_LOGIC;
		 eq17 : OUT STD_LOGIC;
		 eq18 : OUT STD_LOGIC;
		 eq19 : OUT STD_LOGIC;
		 eq20 : OUT STD_LOGIC;
		 eq21 : OUT STD_LOGIC;
		 eq22 : OUT STD_LOGIC;
		 eq23 : OUT STD_LOGIC;
		 eq24 : OUT STD_LOGIC;
		 eq25 : OUT STD_LOGIC;
		 eq26 : OUT STD_LOGIC;
		 eq27 : OUT STD_LOGIC;
		 eq28 : OUT STD_LOGIC;
		 eq29 : OUT STD_LOGIC;
		 eq30 : OUT STD_LOGIC;
		 eq31 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ks3
	PORT(data0x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ks3_y20
	PORT(data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ks2_alu
	PORT(data0 : IN STD_LOGIC;
		 data1 : IN STD_LOGIC;
		 data2 : IN STD_LOGIC;
		 data3 : IN STD_LOGIC;
		 data4 : IN STD_LOGIC;
		 data5 : IN STD_LOGIC;
		 data6 : IN STD_LOGIC;
		 data7 : IN STD_LOGIC;
		 data8 : IN STD_LOGIC;
		 result : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ks7_alu
	PORT(data0 : IN STD_LOGIC;
		 data1 : IN STD_LOGIC;
		 data2 : IN STD_LOGIC;
		 data3 : IN STD_LOGIC;
		 data4 : IN STD_LOGIC;
		 data5 : IN STD_LOGIC;
		 data6 : IN STD_LOGIC;
		 data7 : IN STD_LOGIC;
		 result : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	dc1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ks2_out :  STD_LOGIC;
SIGNAL	ks7_out :  STD_LOGIC;
SIGNAL	to_MS3 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(23 DOWNTO 0);

BEGIN 
out_P_11 <= CT2_7;

GDFX_TEMP_SIGNAL_0 <= (Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20 & Y_20);


b2v_inst : dc1_alu
PORT MAP(data => from_CT2(4 DOWNTO 0),
		 eq0 => dc1(0),
		 eq1 => dc1(1),
		 eq2 => dc1(2),
		 eq3 => dc1(3),
		 eq4 => dc1(4),
		 eq5 => dc1(5),
		 eq6 => dc1(6),
		 eq7 => dc1(7),
		 eq8 => dc1(8),
		 eq9 => dc1(9),
		 eq10 => dc1(10),
		 eq11 => dc1(11),
		 eq12 => dc1(12),
		 eq13 => dc1(13),
		 eq14 => dc1(14),
		 eq15 => dc1(15),
		 eq16 => dc1(16),
		 eq17 => dc1(17),
		 eq18 => dc1(18),
		 eq19 => dc1(19),
		 eq20 => dc1(20),
		 eq21 => dc1(21),
		 eq22 => dc1(22),
		 eq23 => dc1(23),
		 eq24 => dc1(24),
		 eq25 => dc1(25),
		 eq26 => dc1(26),
		 eq27 => dc1(27),
		 eq28 => dc1(28),
		 eq29 => dc1(29),
		 eq30 => dc1(30),
		 eq31 => dc1(31));

to_MS3(23) <= dc1(0);


to_MS3(14) <= dc1(9);


to_MS3(13) <= dc1(10);


to_MS3(12) <= dc1(11);


to_MS3(11) <= dc1(12);


to_MS3(10) <= dc1(13);


to_MS3(9) <= dc1(14);


to_MS3(8) <= dc1(15);


to_MS3(7) <= dc1(16);


to_MS3(6) <= dc1(17);


to_MS3(5) <= dc1(18);


to_MS3(22) <= dc1(1);


to_MS3(4) <= dc1(19);


to_MS3(3) <= dc1(20);


to_MS3(2) <= dc1(21);


to_MS3(1) <= dc1(22);


to_MS3(0) <= dc1(23);



b2v_inst25 : ks3
PORT MAP(data0x => SYNTHESIZED_WIRE_0,
		 data1x => to_MS3,
		 result => to_MS3_out);


b2v_inst26 : ks3_y20
PORT MAP(data => GDFX_TEMP_SIGNAL_0,
		 result => SYNTHESIZED_WIRE_0);


b2v_inst28 : ks2_alu
PORT MAP(data0 => dc1(0),
		 data1 => dc1(1),
		 data2 => dc1(2),
		 data3 => dc1(3),
		 data4 => dc1(4),
		 data5 => dc1(5),
		 data6 => dc1(6),
		 data7 => dc1(7),
		 data8 => dc1(8),
		 result => ks2_out);

to_MS3(21) <= dc1(2);



b2v_inst30 : ks7_alu
PORT MAP(data0 => dc1(24),
		 data1 => dc1(25),
		 data2 => dc1(26),
		 data3 => dc1(27),
		 data4 => dc1(28),
		 data5 => dc1(29),
		 data6 => dc1(30),
		 data7 => dc1(31),
		 result => ks7_out);


SYNTHESIZED_WIRE_1 <= NOT(from_CT2(6) OR from_CT2(5));


SYNTHESIZED_WIRE_2 <= NOT(from_CT2(5) AND from_CT2(6));


SYNTHESIZED_WIRE_3 <= SYNTHESIZED_WIRE_1 OR ks7_out;


SYNTHESIZED_WIRE_4 <= SYNTHESIZED_WIRE_2 OR ks2_out;


out_P_9 <= not_CT2_7 AND SYNTHESIZED_WIRE_3;


out_P_10 <= SYNTHESIZED_WIRE_4 AND CT2_7;

to_MS3(20) <= dc1(3);


to_MS3(19) <= dc1(4);


to_MS3(18) <= dc1(5);


to_MS3(17) <= dc1(6);


to_MS3(16) <= dc1(7);


to_MS3(15) <= dc1(8);



END bdf_type;