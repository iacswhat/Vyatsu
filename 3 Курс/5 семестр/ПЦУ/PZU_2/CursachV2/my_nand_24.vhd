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
-- CREATED		"Fri Oct 28 01:13:32 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY my_nand_24 IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		High_CLK :  IN  STD_LOGIC;
		IN_D :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		IN_Y :  IN  STD_LOGIC_VECTOR(19 DOWNTO 0);
		IS_Y :  OUT  STD_LOGIC;
		OUT_D :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		OUT_P1 :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END my_nand_24;

ARCHITECTURE bdf_type OF my_nand_24 IS 

COMPONENT and24
	PORT(data0x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
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

COMPONENT rg41
	PORT(sclr : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ms8
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
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

COMPONENT my_or24
	PORT(IN_OR24 : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 RES_OR24 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT lpm_dff1
	PORT(clock : IN STD_LOGIC;
		 aclr : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	clk_out :  STD_LOGIC;
SIGNAL	D :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	h80 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	Hclk :  STD_LOGIC;
SIGNAL	log0 :  STD_LOGIC;
SIGNAL	log1 :  STD_LOGIC;
SIGNAL	p :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	res1 :  STD_LOGIC;
SIGNAL	res2 :  STD_LOGIC;
SIGNAL	res_chrt :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	RG4_out :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	y :  STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(23 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_0 <= (D(31) & D(22 DOWNTO 0));
GDFX_TEMP_SIGNAL_1 <= (D(31) & D(22 DOWNTO 0));


b2v_inst : and24
PORT MAP(data0x => SYNTHESIZED_WIRE_0,
		 data1x => SYNTHESIZED_WIRE_1,
		 result => SYNTHESIZED_WIRE_3);

h80(4) <= log0;


h80(3) <= log0;



b2v_inst12 : ct2
PORT MAP(sclr => y(14),
		 sload => y(2),
		 clock => clk_out,
		 cnt_en => y(7),
		 data => SYNTHESIZED_WIRE_2,
		 q => res_chrt);

h80(2) <= log0;


h80(1) <= log0;


h80(0) <= log0;



b2v_inst16 : rg1
PORT MAP(clock => clk_out,
		 enable => y(16),
		 data => GDFX_TEMP_SIGNAL_0,
		 q => SYNTHESIZED_WIRE_0);


b2v_inst17 : rg2
PORT MAP(clock => clk_out,
		 enable => y(1),
		 data => GDFX_TEMP_SIGNAL_1,
		 q => SYNTHESIZED_WIRE_1);


b2v_inst18 : rg41
PORT MAP(sclr => y(0),
		 clock => clk_out,
		 enable => y(6),
		 data => SYNTHESIZED_WIRE_3,
		 q => RG4_out);


b2v_inst2 : ms8
PORT MAP(sel => y(10),
		 data0x => D(30 DOWNTO 23),
		 data1x => h80,
		 result => SYNTHESIZED_WIRE_2);


p(0) <= NOT(SYNTHESIZED_WIRE_4);



p(1) <= RG4_out(23) XOR RG4_out(22);


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



b2v_inst26 : my_or24
PORT MAP(IN_OR24 => RG4_out,
		 RES_OR24 => SYNTHESIZED_WIRE_4);


b2v_inst3 : lpm_dff1
PORT MAP(clock => Hclk,
		 aclr => res1,
		 data => IN_Y,
		 q => y);



h80(7) <= log1;


h80(6) <= log0;


h80(5) <= log0;


Hclk <= High_CLK;
res1 <= reset;
OUT_D(31) <= RG4_out(23);
OUT_D(30 DOWNTO 23) <= res_chrt;
OUT_D(22 DOWNTO 0) <= RG4_out(22 DOWNTO 0);
clk_out <= clk;
D <= IN_D;
OUT_P1 <= p;

log0 <= '0';
log1 <= '1';
END bdf_type;