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
-- CREATED		"Tue Oct 25 19:49:47 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY mult_dk_1 IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		High_CLK :  IN  STD_LOGIC;
		IN_D :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		IN_Y :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		PMR_F :  OUT  STD_LOGIC;
		PRS_F :  OUT  STD_LOGIC;
		IS_Y :  OUT  STD_LOGIC;
		OUT_D :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		OUT_P :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END mult_dk_1;

ARCHITECTURE bdf_type OF mult_dk_1 IS 

COMPONENT rg3
	PORT(clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT reg_y
	PORT(clock : IN STD_LOGIC;
		 aclr : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lg_or_7
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

COMPONENT sm2
	PORT(dataa : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 cout : OUT STD_LOGIC;
		 result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ct2
	PORT(sclr : IN STD_LOGIC;
		 sload : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 cnt_en : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT what
	PORT(distance : IN STD_LOGIC;
		 direction : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rg41
	PORT(sclr : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT smux
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT sm1
	PORT(cin : IN STD_LOGIC;
		 dataa : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
		 cout : OUT STD_LOGIC;
		 result : OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_or11
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
		 result : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ms
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
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

COMPONENT lpm_mux2
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(22 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ct1
	PORT(sset : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 cnt_en : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rg1
	PORT(clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rg2
	PORT(clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	clk_out :  STD_LOGIC;
SIGNAL	ct1_out :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	D :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	gnd1 :  STD_LOGIC;
SIGNAL	Hclk :  STD_LOGIC;
SIGNAL	ks0_out :  STD_LOGIC_VECTOR(22 DOWNTO 0);
SIGNAL	ks1_out :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	p :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	res1 :  STD_LOGIC;
SIGNAL	res2 :  STD_LOGIC;
SIGNAL	res_chrt :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	res_mnt :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	RG1_out :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	RG2_out :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	RG3_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	sign :  STD_LOGIC;
SIGNAL	sign_chrt :  STD_LOGIC;
SIGNAL	sm1_cout :  STD_LOGIC;
SIGNAL	sm1_res :  STD_LOGIC_VECTOR(22 DOWNTO 0);
SIGNAL	sm2_cr :  STD_LOGIC;
SIGNAL	sm2_res :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	y :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(23 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_2 <= (D(31) & D(22 DOWNTO 0));
GDFX_TEMP_SIGNAL_4 <= (D(31) & D(22 DOWNTO 0));
GDFX_TEMP_SIGNAL_1 <= (RG1_out(0) & RG1_out(23 DOWNTO 1));
GDFX_TEMP_SIGNAL_0 <= (sm1_cout & sm1_res(22 DOWNTO 0));
GDFX_TEMP_SIGNAL_3 <= (gnd1 & ks0_out(22 DOWNTO 0));


b2v_inst : rg3
PORT MAP(clock => clk_out,
		 enable => y(1),
		 data => D(30 DOWNTO 23));


b2v_inst1 : reg_y
PORT MAP(clock => Hclk,
		 aclr => res1,
		 data => IN_Y,
		 q => y);


b2v_inst10 : lg_or_7
PORT MAP(data0 => res_chrt(6),
		 data1 => res_chrt(5),
		 data2 => res_chrt(4),
		 data3 => res_chrt(3),
		 data4 => res_chrt(2),
		 data5 => res_chrt(1),
		 data6 => res_chrt(0),
		 result => SYNTHESIZED_WIRE_0);


b2v_inst11 : sm2
PORT MAP(dataa => RG3_out,
		 datab => res_chrt,
		 cout => SYNTHESIZED_WIRE_6,
		 result => sm2_res);


b2v_inst12 : ct2
PORT MAP(sclr => y(0),
		 sload => y(2),
		 clock => clk_out,
		 cnt_en => y(7),
		 data => sm2_res,
		 q => res_chrt);


p(6) <= SYNTHESIZED_WIRE_0 AND p(4);


p(4) <= sm2_cr AND res_chrt(7);


SYNTHESIZED_WIRE_9 <= RG1_out(23) XOR RG2_out(23);


PROCESS(clk_out,res2)
BEGIN
IF (res2 = '0') THEN
	PRS_F <= '0';
ELSIF (RISING_EDGE(clk_out)) THEN
	PRS_F <= y(9);
END IF;
END PROCESS;


p(5) <= NOT(res_chrt(7) OR sm2_cr);


b2v_inst18 : what
PORT MAP(distance => SYNTHESIZED_WIRE_11,
		 direction => y(3),
		 data => SYNTHESIZED_WIRE_2,
		 result => SYNTHESIZED_WIRE_4);


p(0) <= NOT(RG2_out(22) OR RG2_out(23));


b2v_inst2 : rg41
PORT MAP(sclr => y(0),
		 clock => clk_out,
		 enable => SYNTHESIZED_WIRE_3,
		 data => SYNTHESIZED_WIRE_4,
		 q => res_mnt);


b2v_inst20 : smux
PORT MAP(sel => SYNTHESIZED_WIRE_11,
		 data0x => GDFX_TEMP_SIGNAL_0,
		 data1x => res_mnt,
		 result => SYNTHESIZED_WIRE_2);


b2v_inst21 : sm1
PORT MAP(cin => y(5),
		 dataa => ks1_out(22 DOWNTO 0),
		 datab => res_mnt(22 DOWNTO 0),
		 cout => sm1_cout,
		 result => sm1_res);


PROCESS(clk_out,res2)
BEGIN
IF (res2 = '0') THEN
	PMR_F <= '0';
ELSIF (RISING_EDGE(clk_out)) THEN
	PMR_F <= y(10);
END IF;
END PROCESS;


b2v_inst23 : lpm_or11
PORT MAP(data0 => y(0),
		 data1 => y(1),
		 data2 => y(2),
		 data3 => y(3),
		 data4 => y(4),
		 data5 => y(5),
		 data6 => y(6),
		 data7 => y(7),
		 data8 => y(8),
		 data9 => y(9),
		 data10 => y(10),
		 result => IS_Y);


res2 <= NOT(res1);



b2v_inst25 : ms
PORT MAP(sel => y(0),
		 data0x => GDFX_TEMP_SIGNAL_1,
		 data1x => GDFX_TEMP_SIGNAL_2,
		 result => SYNTHESIZED_WIRE_8);


b2v_inst26 : invert24
PORT MAP(INVERT24 => y(5),
		 DATA24_IN => GDFX_TEMP_SIGNAL_3,
		 DATA24_OUT => ks1_out);


b2v_inst27 : lpm_mux2
PORT MAP(sel => y(4),
		 data0x => RG2_out(22 DOWNTO 0),
		 data1x => RG1_out(23 DOWNTO 1),
		 result => ks0_out);



b2v_inst29 : ct1
PORT MAP(sset => y(0),
		 clock => clk_out,
		 cnt_en => y(3),
		 q => ct1_out);


sign_chrt <= NOT(res_chrt(7));



PROCESS(y(2))
BEGIN
IF (RISING_EDGE(y(2))) THEN
	sm2_cr <= SYNTHESIZED_WIRE_6;
END IF;
END PROCESS;

p(2) <= RG2_out(23);



b2v_inst32 : rg1
PORT MAP(clock => clk_out,
		 enable => SYNTHESIZED_WIRE_7,
		 data => SYNTHESIZED_WIRE_8,
		 q => RG1_out);

p(1) <= RG1_out(0);


p(3) <= ct1_out(5);



PROCESS(y(2))
BEGIN
IF (RISING_EDGE(y(2))) THEN
	sign <= SYNTHESIZED_WIRE_9;
END IF;
END PROCESS;


p(7) <= sign XOR res_mnt(22);


SYNTHESIZED_WIRE_3 <= y(6) OR y(0) OR SYNTHESIZED_WIRE_11;


SYNTHESIZED_WIRE_7 <= y(3) OR y(0);


SYNTHESIZED_WIRE_11 <= y(7) OR y(3);


b2v_inst9 : rg2
PORT MAP(clock => clk_out,
		 enable => y(1),
		 data => GDFX_TEMP_SIGNAL_4,
		 q => RG2_out);

res1 <= reset;
clk_out <= clk;
Hclk <= High_CLK;
OUT_D(31) <= sign;
OUT_D(30) <= sign_chrt;
OUT_D(29 DOWNTO 23) <= res_chrt(6 DOWNTO 0);
OUT_D(22 DOWNTO 1) <= res_mnt(22 DOWNTO 1);
OUT_D(0) <= sign;
D <= IN_D;
OUT_P <= p;

gnd1 <= '0';
END bdf_type;