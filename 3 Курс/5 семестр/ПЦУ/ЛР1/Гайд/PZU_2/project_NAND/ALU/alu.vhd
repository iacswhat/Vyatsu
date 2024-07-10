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
-- CREATED		"Mon Nov 21 01:39:28 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY alu IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		High_CLK :  IN  STD_LOGIC;
		IN_X :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		IN_Y :  IN  STD_LOGIC_VECTOR(21 DOWNTO 1);
		PRS_alu :  OUT  STD_LOGIC;
		PMR_alu :  OUT  STD_LOGIC;
		C :  OUT  STD_LOGIC;
		OUT_D :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		OUT_P1 :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 1)
	);
END alu;

ARCHITECTURE bdf_type OF alu IS 

COMPONENT y_store
	PORT(clock : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 aclr : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(20 DOWNTO 0)
	);
END COMPONENT;

COMPONENT dc1_ks2_ks3_ks7_block
	PORT(CT2_7 : IN STD_LOGIC;
		 not_CT2_7 : IN STD_LOGIC;
		 Y_20 : IN STD_LOGIC;
		 from_CT2 : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 out_P_9 : OUT STD_LOGIC;
		 out_P_10 : OUT STD_LOGIC;
		 out_P_11 : OUT STD_LOGIC;
		 to_MS3_out : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rg12_t3_ms2_ks456
	PORT(clock : IN STD_LOGIC;
		 Y_9 : IN STD_LOGIC;
		 Y_8 : IN STD_LOGIC;
		 Y_10 : IN STD_LOGIC;
		 Y_2 : IN STD_LOGIC;
		 Y_4 : IN STD_LOGIC;
		 Y_1 : IN STD_LOGIC;
		 Y_11 : IN STD_LOGIC;
		 Y_12 : IN STD_LOGIC;
		 D_in : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 to_KS4_31_24 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 P_4 : OUT STD_LOGIC;
		 out_T3 : OUT STD_LOGIC;
		 P_5 : OUT STD_LOGIC;
		 P_6 : OUT STD_LOGIC;
		 op_to_p12 : OUT STD_LOGIC;
		 P_7 : OUT STD_LOGIC;
		 KS5_out : OUT STD_LOGIC_VECTOR(22 DOWNTO 0);
		 KS6_out : OUT STD_LOGIC_VECTOR(23 DOWNTO 0);
		 RG1_out : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT cascade_rg4_block
	PORT(node_for_p12 : IN STD_LOGIC;
		 from_T3 : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 Y_19 : IN STD_LOGIC;
		 Y_10 : IN STD_LOGIC;
		 Y_6 : IN STD_LOGIC;
		 Y_1 : IN STD_LOGIC;
		 Y_12 : IN STD_LOGIC;
		 Y_18 : IN STD_LOGIC;
		 Y_17 : IN STD_LOGIC;
		 Y_13 : IN STD_LOGIC;
		 From_KS3 : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 From_KS5 : IN STD_LOGIC_VECTOR(22 DOWNTO 0);
		 From_KS6 : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 From_RG1 : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		 P_15 : OUT STD_LOGIC;
		 P_14 : OUT STD_LOGIC;
		 P_12 : OUT STD_LOGIC;
		 P_13 : OUT STD_LOGIC;
		 RG4_out : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ms7_alu
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ct1_alu
	PORT(sset : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 cnt_en : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rg3_sm2_ms1_ct2_block
	PORT(Y_2 : IN STD_LOGIC;
		 Y_3 : IN STD_LOGIC;
		 Y_4 : IN STD_LOGIC;
		 Y_5 : IN STD_LOGIC;
		 Y_6 : IN STD_LOGIC;
		 Y_7 : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 X_30_23 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 SM2_CRP : OUT STD_LOGIC;
		 CT2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT ks1_t1_block
	PORT(from_CT2_CRP : IN STD_LOGIC;
		 Y_4 : IN STD_LOGIC;
		 from_CT2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 P_1_PRS : OUT STD_LOGIC;
		 P_2_VPRS : OUT STD_LOGIC;
		 P_3_PMR : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	clk_out :  STD_LOGIC;
SIGNAL	ct1 :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	CT2_out :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	Hclk :  STD_LOGIC;
SIGNAL	MS7 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	n_CT2_7 :  STD_LOGIC;
SIGNAL	not_reset :  STD_LOGIC;
SIGNAL	p :  STD_LOGIC_VECTOR(15 DOWNTO 1);
SIGNAL	res1 :  STD_LOGIC;
SIGNAL	RG4 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	T3 :  STD_LOGIC;
SIGNAL	to_A_MS3 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	X :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	y :  STD_LOGIC_VECTOR(21 DOWNTO 1);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(22 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN 

GDFX_TEMP_SIGNAL_0 <= (n_CT2_7 & CT2_out(6 DOWNTO 0));
GDFX_TEMP_SIGNAL_1 <= (T3 & T3);
GDFX_TEMP_SIGNAL_2 <= (RG4(23) & RG4(0));


b2v_inst : y_store
PORT MAP(clock => Hclk,
		 enable => clk,
		 aclr => res1,
		 data => IN_Y,
		 q => y);


clk_out <= NOT(clk);



b2v_inst10 : dc1_ks2_ks3_ks7_block
PORT MAP(CT2_7 => CT2_out(7),
		 not_CT2_7 => n_CT2_7,
		 Y_20 => y(20),
		 from_CT2 => CT2_out(6 DOWNTO 0),
		 out_P_9 => p(9),
		 out_P_10 => p(10),
		 out_P_11 => p(11),
		 to_MS3_out => to_A_MS3);


b2v_inst11 : rg12_t3_ms2_ks456
PORT MAP(clock => clk_out,
		 Y_9 => y(9),
		 Y_8 => y(8),
		 Y_10 => y(10),
		 Y_2 => y(2),
		 Y_4 => y(4),
		 Y_1 => y(1),
		 Y_11 => y(11),
		 Y_12 => y(12),
		 D_in => X(23 DOWNTO 0),
		 to_KS4_31_24 => GDFX_TEMP_SIGNAL_0,
		 P_4 => p(4),
		 out_T3 => T3,
		 P_5 => p(5),
		 P_6 => p(6),
		 op_to_p12 => SYNTHESIZED_WIRE_0,
		 P_7 => p(7),
		 KS5_out => SYNTHESIZED_WIRE_1,
		 KS6_out => SYNTHESIZED_WIRE_2,
		 RG1_out => SYNTHESIZED_WIRE_3);


b2v_inst12 : cascade_rg4_block
PORT MAP(node_for_p12 => SYNTHESIZED_WIRE_0,
		 from_T3 => T3,
		 clk => clk_out,
		 Y_19 => y(19),
		 Y_10 => y(10),
		 Y_6 => y(6),
		 Y_1 => y(1),
		 Y_12 => y(12),
		 Y_18 => y(18),
		 Y_17 => y(17),
		 Y_13 => y(13),
		 From_KS3 => to_A_MS3,
		 From_KS5 => SYNTHESIZED_WIRE_1,
		 From_KS6 => SYNTHESIZED_WIRE_2,
		 From_RG1 => SYNTHESIZED_WIRE_3,
		 P_15 => p(15),
		 P_14 => p(14),
		 P_12 => p(12),
		 P_13 => p(13),
		 RG4_out => RG4);


PROCESS(clk_out,not_reset)
VARIABLE synthesized_var_for_PRS_alu : STD_LOGIC;
BEGIN
IF (not_reset = '0') THEN
	synthesized_var_for_PRS_alu := '0';
ELSIF (RISING_EDGE(clk_out)) THEN
	synthesized_var_for_PRS_alu := (NOT(synthesized_var_for_PRS_alu) AND y(14)) OR (synthesized_var_for_PRS_alu AND (NOT(y(1))));
END IF;
	PRS_alu <= synthesized_var_for_PRS_alu;
END PROCESS;


PROCESS(clk_out,not_reset)
VARIABLE synthesized_var_for_PMR_alu : STD_LOGIC;
BEGIN
IF (not_reset = '0') THEN
	synthesized_var_for_PMR_alu := '0';
ELSIF (RISING_EDGE(clk_out)) THEN
	synthesized_var_for_PMR_alu := (NOT(synthesized_var_for_PMR_alu) AND y(15)) OR (synthesized_var_for_PMR_alu AND (NOT(y(1))));
END IF;
	PMR_alu <= synthesized_var_for_PMR_alu;
END PROCESS;


PROCESS(clk_out,not_reset)
VARIABLE synthesized_var_for_C : STD_LOGIC;
BEGIN
IF (not_reset = '0') THEN
	synthesized_var_for_C := '0';
ELSIF (RISING_EDGE(clk_out)) THEN
	synthesized_var_for_C := (NOT(synthesized_var_for_C) AND SYNTHESIZED_WIRE_4) OR (synthesized_var_for_C AND (NOT(y(1))));
END IF;
	C <= synthesized_var_for_C;
END PROCESS;


SYNTHESIZED_WIRE_4 <= MS7(1) AND y(21);


b2v_inst18 : ms7_alu
PORT MAP(sel => y(16),
		 data0x => GDFX_TEMP_SIGNAL_1,
		 data1x => GDFX_TEMP_SIGNAL_2,
		 result => MS7);


b2v_inst19 : ct1_alu
PORT MAP(sset => y(1),
		 clock => clk_out,
		 cnt_en => y(10),
		 q => ct1);


n_CT2_7 <= NOT(CT2_out(7));


p(8) <= ct1(5);



not_reset <= NOT(res1);



b2v_inst6 : rg3_sm2_ms1_ct2_block
PORT MAP(Y_2 => y(2),
		 Y_3 => y(3),
		 Y_4 => y(4),
		 Y_5 => y(5),
		 Y_6 => y(6),
		 Y_7 => y(7),
		 clk => clk_out,
		 X_30_23 => X(30 DOWNTO 23),
		 SM2_CRP => SYNTHESIZED_WIRE_5,
		 CT2 => CT2_out);


b2v_inst8 : ks1_t1_block
PORT MAP(from_CT2_CRP => SYNTHESIZED_WIRE_5,
		 Y_4 => y(4),
		 from_CT2 => CT2_out,
		 P_1_PRS => p(1),
		 P_2_VPRS => p(2),
		 P_3_PMR => p(3));

res1 <= reset;
Hclk <= High_CLK;
X <= IN_X;
OUT_D(31) <= MS7(1);
OUT_D(30) <= n_CT2_7;
OUT_D(29 DOWNTO 23) <= CT2_out(6 DOWNTO 0);
OUT_D(22 DOWNTO 1) <= RG4(22 DOWNTO 1);
OUT_D(0) <= MS7(0);
OUT_P1 <= p;

END bdf_type;