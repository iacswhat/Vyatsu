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
-- CREATED		"Tue Oct 25 19:49:23 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY invert4 IS 
	PORT
	(
		INVERT :  IN  STD_LOGIC;
		DATA4_IN :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		DATA4_OUT :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END invert4;

ARCHITECTURE bdf_type OF invert4 IS 

SIGNAL	x :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	y :  STD_LOGIC_VECTOR(3 DOWNTO 0);


BEGIN 



y(0) <= INVERT XOR x(0);


y(1) <= INVERT XOR x(1);


y(2) <= INVERT XOR x(2);


y(3) <= INVERT XOR x(3);

DATA4_OUT <= y;
x <= DATA4_IN;

END bdf_type;