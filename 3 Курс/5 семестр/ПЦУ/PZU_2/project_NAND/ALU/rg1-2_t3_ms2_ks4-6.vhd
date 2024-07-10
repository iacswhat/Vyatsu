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
-- CREATED		"Sun Nov 20 23:21:34 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY rg1-2_t3_ms2_ks4-6 IS 
	PORT
	(
		clock :  IN  STD_LOGIC;
		Y_9 :  IN  STD_LOGIC;
		Y_10 :  IN  STD_LOGIC;
		Y_8 :  IN  STD_LOGIC;
		Y_2 :  IN  STD_LOGIC;
		Y_4 :  IN  STD_LOGIC;
		Y_1 :  IN  STD_LOGIC;
		Y_11 :  IN  STD_LOGIC;
		Y_12 :  IN  STD_LOGIC;
		D_in :  IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
		to_KS4_31_24 :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		out_T3 :  OUT  STD_LOGIC;
		P_4 :  OUT  STD_LOGIC;
		P_5 :  OUT  STD_LOGIC;
		P_6 :  OUT  STD_LOGIC;
		P_7 :  OUT  STD_LOGIC;
		op_to_p12 :  OUT  STD_LOGIC;
		KS5_out :  OUT  STD_LOGIC_VECTOR(22 DOWNTO 0);
		KS6_out :  OUT  STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END rg1-2_t3_ms2_ks4-6;

ARCHITECTURE bdf_type OF rg1-2_t3_ms2_ks4-6 IS 

COMPONENT rg1_block
	PORT(Y_8_LD : IN STD_LOGIC;
		 Y_9_Ariph_SH : IN STD_LOGIC;
		 Y_10_SH_R : IN STD_LOGIC;
		 clock_rg1 : IN STD_LOGIC;
		 Data_in : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 Data_out : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rg2
	PORT(clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ks6_alu
	PORT(data0x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT invert24
	PORT(INVERT24 : IN STD_LOGIC;
		 DATA24_IN : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 DATA24_OUT : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ks4_alu
	PORT(data0 : IN STD_LOGIC;
		 data1 : IN STD_LOGIC;
		 data2 : IN STD_LOGIC;
		 data3 : IN STD_LOGIC;
		 data4 : IN STD_LOGIC;
		 data5 : IN STD_LOGIC;
		 data6 : IN STD_LOGIC;
		 data7 : IN STD_LOGIC;
		 data8 : IN STD_LOGIC;
		 data9 : IN STD_LOGIC;
		 data10 : IN STD_LOGIC;
		 data11 : IN STD_LOGIC;
		 data12 : IN STD_LOGIC;
		 data13 : IN STD_LOGIC;
		 data14 : IN STD_LOGIC;
		 data15 : IN STD_LOGIC;
		 data16 : IN STD_LOGIC;
		 data17 : IN STD_LOGIC;
		 data18 : IN STD_LOGIC;
		 data19 : IN STD_LOGIC;
		 data20 : IN STD_LOGIC;
		 data21 : IN STD_LOGIC;
		 data22 : IN STD_LOGIC;
		 data23 : IN STD_LOGIC;
		 data24 : IN STD_LOGIC;
		 data25 : IN STD_LOGIC;
		 data26 : IN STD_LOGIC;
		 data27 : IN STD_LOGIC;
		 data28 : IN STD_LOGIC;
		 data29 : IN STD_LOGIC;
		 data30 : IN STD_LOGIC;
		 data31 : IN STD_LOGIC;
		 result : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ms2_alu
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	clk :  STD_LOGIC;
SIGNAL	d :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	data1 :  STD_LOGIC;
SIGNAL	gnd :  STD_LOGIC;
SIGNAL	ks5 :  STD_LOGIC_VECTOR(22 DOWNTO 0);
SIGNAL	ms2_s :  STD_LOGIC_VECTOR(22 DOWNTO 0);
SIGNAL	not_rg2_23 :  STD_LOGIC;
SIGNAL	rg1 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	rg2 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	tks4 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	y1 :  STD_LOGIC;
SIGNAL	y10 :  STD_LOGIC;
SIGNAL	y11 :  STD_LOGIC;
SIGNAL	y12 :  STD_LOGIC;
SIGNAL	y4 :  STD_LOGIC;
SIGNAL	y8 :  STD_LOGIC;
SIGNAL	y9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(23 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_0 <= (gnd & ms2_s(22 DOWNTO 0));
ks5(22) <= GDFX_TEMP_SIGNAL_1(23);
ks5(21) <= GDFX_TEMP_SIGNAL_1(22);
ks5(20) <= GDFX_TEMP_SIGNAL_1(21);
ks5(19) <= GDFX_TEMP_SIGNAL_1(20);
ks5(18) <= GDFX_TEMP_SIGNAL_1(19);
ks5(17) <= GDFX_TEMP_SIGNAL_1(18);
ks5(16) <= GDFX_TEMP_SIGNAL_1(17);
ks5(15) <= GDFX_TEMP_SIGNAL_1(16);
ks5(14) <= GDFX_TEMP_SIGNAL_1(15);
ks5(13) <= GDFX_TEMP_SIGNAL_1(14);
ks5(12) <= GDFX_TEMP_SIGNAL_1(13);
ks5(11) <= GDFX_TEMP_SIGNAL_1(12);
ks5(10) <= GDFX_TEMP_SIGNAL_1(11);
ks5(9) <= GDFX_TEMP_SIGNAL_1(10);
ks5(8) <= GDFX_TEMP_SIGNAL_1(9);
ks5(7) <= GDFX_TEMP_SIGNAL_1(8);
ks5(6) <= GDFX_TEMP_SIGNAL_1(7);
ks5(5) <= GDFX_TEMP_SIGNAL_1(6);
ks5(4) <= GDFX_TEMP_SIGNAL_1(5);
ks5(3) <= GDFX_TEMP_SIGNAL_1(4);
ks5(2) <= GDFX_TEMP_SIGNAL_1(3);
ks5(1) <= GDFX_TEMP_SIGNAL_1(2);
ks5(0) <= GDFX_TEMP_SIGNAL_1(1);



b2v_inst : rg1_block
PORT MAP(Y_8_LD => y8,
		 Y_9_Ariph_SH => y9,
		 Y_10_SH_R => y10,
		 clock_rg1 => clk,
		 Data_in => d,
		 Data_out => rg1);


b2v_inst1 : rg2
PORT MAP(clock => clk,
		 enable => Y_2,
		 data => d,
		 q => rg2);


b2v_inst11 : ks6_alu
PORT MAP(data0x => rg1,
		 data1x => rg2,
		 result => SYNTHESIZED_WIRE_0);


b2v_inst13 : ks6_alu
PORT MAP(data => SYNTHESIZED_WIRE_0,
		 result => KS6_out);


b2v_inst14 : invert24
PORT MAP(INVERT24 => y12,
		 DATA24_IN => GDFX_TEMP_SIGNAL_0,
		 DATA24_OUT => GDFX_TEMP_SIGNAL_1);



not_rg2_23 <= NOT(rg2(23));



b2v_inst3 : ks4_alu
PORT MAP(data0 => tks4(0),
		 data1 => tks4(1),
		 data2 => tks4(2),
		 data3 => tks4(3),
		 data4 => tks4(4),
		 data5 => tks4(5),
		 data6 => tks4(6),
		 data7 => tks4(7),
		 data8 => not_rg2_23,
		 data9 => rg2(22),
		 data10 => rg2(21),
		 data11 => rg2(20),
		 data12 => rg2(19),
		 data13 => rg2(18),
		 data14 => rg2(17),
		 data15 => rg2(16),
		 data16 => rg2(15),
		 data17 => rg2(14),
		 data18 => rg2(13),
		 data19 => rg2(12),
		 data20 => rg2(11),
		 data21 => rg2(10),
		 data22 => rg2(9),
		 data23 => rg2(8),
		 data24 => rg2(7),
		 data25 => rg2(6),
		 data26 => rg2(5),
		 data27 => rg2(4),
		 data28 => rg2(3),
		 data29 => rg2(2),
		 data30 => rg2(1),
		 data31 => rg2(0),
		 result => P_7);


PROCESS(y4,SYNTHESIZED_WIRE_1)
BEGIN
IF (SYNTHESIZED_WIRE_1 = '0') THEN
	out_T3 <= '0';
ELSIF (RISING_EDGE(y4)) THEN
	out_T3 <= SYNTHESIZED_WIRE_2;
END IF;
END PROCESS;


SYNTHESIZED_WIRE_2 <= rg2(23) XOR rg1(23);


SYNTHESIZED_WIRE_1 <= NOT(y1);



P_5 <= NOT(rg2(22) OR rg2(23));


b2v_inst9 : ms2_alu
PORT MAP(sel => y11,
		 data0x => rg2(22 DOWNTO 0),
		 data1x => rg1(23 DOWNTO 1),
		 result => ms2_s);

y1 <= Y_1;
y4 <= Y_4;
clk <= clock;
d <= D_in;
y8 <= Y_8;
y9 <= Y_9;
y10 <= Y_10;
P_4 <= rg2(23);
P_6 <= rg1(0);
tks4 <= to_KS4_31_24;
op_to_p12 <= not_rg2_23;
KS5_out <= ks5;
y12 <= Y_12;
y11 <= Y_11;

data1 <= GDFX_TEMP_SIGNAL_1(23);
gnd <= '0';
ks5(22 DOWNTO 0) <= GDFX_TEMP_SIGNAL_1(22 DOWNTO 0);
END bdf_type;