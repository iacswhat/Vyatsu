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
-- CREATED		"Thu Jun 30 11:26:14 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY test2 IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		res :  IN  STD_LOGIC;
		xpin :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		apin :  OUT  STD_LOGIC_VECTOR(8 DOWNTO 0);
		ctpin :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		outpin :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		ypin :  OUT  STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END test2;

ARCHITECTURE bdf_type OF test2 IS 

COMPONENT ili5
	PORT(data0 : IN STD_LOGIC;
		 data1 : IN STD_LOGIC;
		 data2 : IN STD_LOGIC;
		 data3 : IN STD_LOGIC;
		 data4 : IN STD_LOGIC;
		 result : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ili9
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

COMPONENT reg
	PORT(clock : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dc4
	PORT(data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
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
		 eq15 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT ct4pm
	PORT(sclr : IN STD_LOGIC;
		 updown : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 cnt_en : IN STD_LOGIC;
		 aload : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	a :  STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL	ct :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	cten :  STD_LOGIC;
SIGNAL	d :  STD_LOGIC;
SIGNAL	f :  STD_LOGIC;
SIGNAL	g :  STD_LOGIC;
SIGNAL	gnd :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	h :  STD_LOGIC;
SIGNAL	i :  STD_LOGIC;
SIGNAL	m :  STD_LOGIC;
SIGNAL	n :  STD_LOGIC;
SIGNAL	nx :  STD_LOGIC_VECTOR(6 DOWNTO 1);
SIGNAL	out :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	pl :  STD_LOGIC;
SIGNAL	q :  STD_LOGIC;
SIGNAL	s :  STD_LOGIC;
SIGNAL	t :  STD_LOGIC;
SIGNAL	u :  STD_LOGIC;
SIGNAL	v :  STD_LOGIC;
SIGNAL	w :  STD_LOGIC;
SIGNAL	x :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	y :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	yy :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(4 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_0 <= (cten & gnd(2 DOWNTO 0) & v);


y(2) <= a(0) AND x(0);


t <= a(6) AND nx(5) AND x(1);


u <= a(6) AND x(5) AND x(3) AND x(2);


i <= a(1) AND nx(1);


f <= a(3) AND nx(1);


d <= a(4) AND x(6);


w <= a(7) AND x(4);


b2v_inst16 : ili5
PORT MAP(data0 => y(2),
		 data1 => i,
		 data2 => f,
		 data3 => m,
		 data4 => w,
		 result => y(1));


y(0) <= g OR y(2);


y(3) <= h OR s;


y(4) <= t OR n;


s <= a(1) AND x(1);


y(5) <= q OR a(5);


y(6) <= q OR y(7) OR a(5);


y(8) <= i OR m OR w OR f;


y(9) <= u OR d;


SYNTHESIZED_WIRE_0 <= a(4) AND nx(6) AND nx(4) AND nx(1);


b2v_inst25 : ili9
PORT MAP(data0 => SYNTHESIZED_WIRE_0,
		 data1 => y(2),
		 data2 => s,
		 data3 => g,
		 data4 => h,
		 data5 => n,
		 data6 => a(5),
		 data7 => y(7),
		 data8 => y(10),
		 result => pl);


SYNTHESIZED_WIRE_2 <= a(6) AND x(5) AND x(3) AND nx(2);


b2v_inst27 : reg
PORT MAP(clock => clk,
		 data => y,
		 q => yy);


g <= a(2) AND x(0);


ct(5 DOWNTO 1) <= GDFX_TEMP_SIGNAL_0;




SYNTHESIZED_WIRE_1 <= NOT(t);



ct(6) <= pl AND SYNTHESIZED_WIRE_1;


SYNTHESIZED_WIRE_3 <= a(7) AND nx(4);


ct(0) <= SYNTHESIZED_WIRE_2 OR i OR SYNTHESIZED_WIRE_3 OR f OR d OR m OR u OR w;


h <= a(3) AND x(1);


cten <= t OR pl;


y(10) <= a(8) AND x(7);


n <= a(4) AND nx(6) AND nx(4) AND x(1);


m <= a(4) AND nx(6) AND x(4);


y(7) <= a(6) AND x(5) AND nx(3);


q <= a(6) AND nx(5) AND nx(1);


nx <= NOT(x(6 DOWNTO 1));



b2v_UAinst28 : dc4
PORT MAP(data => out,
		 eq0 => a(8),
		 eq1 => a(0),
		 eq2 => a(1),
		 eq3 => a(2),
		 eq4 => a(3),
		 eq5 => a(4),
		 eq6 => a(5),
		 eq7 => a(6),
		 eq8 => a(7));


b2v_UAinst38 : ct4pm
PORT MAP(sclr => ct(0),
		 updown => ct(6),
		 clock => clk,
		 cnt_en => ct(5),
		 aload => res,
		 data => ct(4 DOWNTO 1),
		 q => out);

apin <= a;
x <= xpin;
ctpin <= ct;
outpin <= out;
ypin <= yy;

gnd <= "000";
v <= '1';
END bdf_type;