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
-- CREATED		"Tue Oct 25 19:34:59 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY invert24 IS 
	PORT
	(
		INVERT24 :  IN  STD_LOGIC;
		DATA24_IN :  IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
		DATA24_OUT :  OUT  STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END invert24;

ARCHITECTURE bdf_type OF invert24 IS 

COMPONENT invert4
	PORT(INVERT : IN STD_LOGIC;
		 DATA4_IN : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 DATA4_OUT : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	x :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	y :  STD_LOGIC_VECTOR(23 DOWNTO 0);


BEGIN 



b2v_inst : invert4
PORT MAP(INVERT => INVERT24,
		 DATA4_IN => x(3 DOWNTO 0),
		 DATA4_OUT => y(3 DOWNTO 0));


b2v_inst3 : invert4
PORT MAP(INVERT => INVERT24,
		 DATA4_IN => x(7 DOWNTO 4),
		 DATA4_OUT => y(7 DOWNTO 4));


b2v_inst4 : invert4
PORT MAP(INVERT => INVERT24,
		 DATA4_IN => x(11 DOWNTO 8),
		 DATA4_OUT => y(11 DOWNTO 8));


b2v_inst5 : invert4
PORT MAP(INVERT => INVERT24,
		 DATA4_IN => x(15 DOWNTO 12),
		 DATA4_OUT => y(15 DOWNTO 12));


b2v_inst6 : invert4
PORT MAP(INVERT => INVERT24,
		 DATA4_IN => x(19 DOWNTO 16),
		 DATA4_OUT => y(19 DOWNTO 16));


b2v_inst7 : invert4
PORT MAP(INVERT => INVERT24,
		 DATA4_IN => x(23 DOWNTO 20),
		 DATA4_OUT => y(23 DOWNTO 20));

DATA24_OUT <= y;
x <= DATA24_IN;

END bdf_type;