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
-- CREATED		"Fri Oct 28 01:11:44 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY my_or24 IS 
	PORT
	(
		IN_OR24 :  IN  STD_LOGIC_VECTOR(23 DOWNTO 0);
		RES_OR24 :  OUT  STD_LOGIC
	);
END my_or24;

ARCHITECTURE bdf_type OF my_or24 IS 

SIGNAL	or1_12 :  STD_LOGIC;
SIGNAL	or2_12 :  STD_LOGIC;
SIGNAL	x :  STD_LOGIC_VECTOR(23 DOWNTO 0);


BEGIN 



or1_12 <= x(21) OR x(22) OR x(23) OR x(18) OR x(19) OR x(20) OR x(16) OR x(17) OR x(15) OR x(13) OR x(14) OR x(12);


RES_OR24 <= or1_12 OR or2_12;


or2_12 <= x(9) OR x(10) OR x(11) OR x(6) OR x(7) OR x(8) OR x(4) OR x(5) OR x(3) OR x(1) OR x(2) OR x(0);

x <= IN_OR24;

END bdf_type;