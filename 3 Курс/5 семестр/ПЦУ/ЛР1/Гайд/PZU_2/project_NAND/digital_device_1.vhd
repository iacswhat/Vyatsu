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
-- CREATED		"Mon Nov 21 01:50:07 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY digital_device_1 IS 
	PORT
	(
		clk_25mhz :  IN  STD_LOGIC;
		mode_usb_n :  IN  STD_LOGIC;
		usb_txen :  IN  STD_LOGIC;
		usb_rxfn :  IN  STD_LOGIC;
		usb_d :  INOUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		usb_wr :  OUT  STD_LOGIC;
		usb_rdn :  OUT  STD_LOGIC;
		led :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END digital_device_1;

ARCHITECTURE bdf_type OF digital_device_1 IS 

COMPONENT usbbridge
	PORT(CLKIN : IN STD_LOGIC;
		 mode_usb_n : IN STD_LOGIC;
		 USB_TXEn : IN STD_LOGIC;
		 USB_RXFn : IN STD_LOGIC;
		 RDY : IN STD_LOGIC;
		 ZF : IN STD_LOGIC;
		 SF : IN STD_LOGIC;
		 CF : IN STD_LOGIC;
		 PRS : IN STD_LOGIC;
		 DIV0 : IN STD_LOGIC;
		 BusOut : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 P : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		 USB_Data : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 X : OUT STD_LOGIC;
		 Mode : OUT STD_LOGIC;
		 Z : OUT STD_LOGIC;
		 Reset : OUT STD_LOGIC;
		 USB_WR : OUT STD_LOGIC;
		 USB_RDn : OUT STD_LOGIC;
		 OClk : OUT STD_LOGIC;
		 BusIn : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 Y : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pll1
	PORT(inclk0 : IN STD_LOGIC;
		 c0 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT alu
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 High_CLK : IN STD_LOGIC;
		 IN_X : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 IN_Y : IN STD_LOGIC_VECTOR(21 DOWNTO 1);
		 PRS_alu : OUT STD_LOGIC;
		 PMR_alu : OUT STD_LOGIC;
		 C : OUT STD_LOGIC;
		 OUT_D : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 OUT_P1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 1)
	);
END COMPONENT;

SIGNAL	BusIn :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	BusOut :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	c_a :  STD_LOGIC;
SIGNAL	clk_1MHz :  STD_LOGIC;
SIGNAL	clock :  STD_LOGIC;
SIGNAL	ledn :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	P :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	pmr_a :  STD_LOGIC;
SIGNAL	prs_a :  STD_LOGIC;
SIGNAL	Reset_ALU :  STD_LOGIC;
SIGNAL	Y :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;


BEGIN 
SYNTHESIZED_WIRE_3 <= '0';



b2v_inst : usbbridge
PORT MAP(CLKIN => clk_1MHz,
		 mode_usb_n => mode_usb_n,
		 USB_TXEn => usb_txen,
		 USB_RXFn => usb_rxfn,
		 RDY => SYNTHESIZED_WIRE_3,
		 ZF => pmr_a,
		 SF => SYNTHESIZED_WIRE_3,
		 CF => c_a,
		 PRS => prs_a,
		 DIV0 => SYNTHESIZED_WIRE_3,
		 BusOut => BusOut,
		 P => P,
		 USB_Data => usb_d,
		 Reset => Reset_ALU,
		 USB_WR => usb_wr,
		 USB_RDn => usb_rdn,
		 OClk => clock,
		 BusIn => BusIn,
		 Y => Y);



b2v_inst3 : pll1
PORT MAP(inclk0 => clk_25mhz,
		 c0 => clk_1MHz);


b2v_inst4 : alu
PORT MAP(clk => clock,
		 reset => Reset_ALU,
		 High_CLK => clk_25mhz,
		 IN_X => BusIn,
		 IN_Y => Y(21 DOWNTO 1),
		 PRS_alu => prs_a,
		 PMR_alu => pmr_a,
		 C => c_a,
		 OUT_D => BusOut,
		 OUT_P1 => P(15 DOWNTO 1));



led <= ledn;

ledn <= "00000000";
END bdf_type;