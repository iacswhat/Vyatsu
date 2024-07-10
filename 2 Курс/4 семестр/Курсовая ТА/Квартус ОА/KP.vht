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

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "04/07/2022 12:23:56"
                                                                        
-- Vhdl Self-Checking Test Bench (with test vectors) for design :       KP
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

LIBRARY STD;                                                            
USE STD.textio.ALL;                                                     

PACKAGE KP_vhd_tb_types IS
-- input port types                                                       
-- output port names                                                     
CONSTANT p_name : STRING (1 TO 1) := "p";
CONSTANT PMR_name : STRING (1 TO 3) := "PMR";
CONSTANT PRS_name : STRING (1 TO 3) := "PRS";
CONSTANT result_name : STRING (1 TO 6) := "result";
CONSTANT y_name : STRING (1 TO 1) := "y";
CONSTANT Z_name : STRING (1 TO 1) := "Z";
-- n(outputs)                                                            
CONSTANT o_num : INTEGER := 6;
-- mismatches vector type                                                
TYPE mmvec IS ARRAY (0 to (o_num - 1)) OF INTEGER;
-- exp o/ first change track vector type                                     
TYPE trackvec IS ARRAY (1 to o_num) OF BIT;
-- sampler type                                                            
SUBTYPE sample_type IS STD_LOGIC;                                          
-- utility functions                                                     
FUNCTION std_logic_to_char (a: STD_LOGIC) RETURN CHARACTER;              
FUNCTION std_logic_vector_to_string (a: STD_LOGIC_VECTOR) RETURN STRING; 
PROCEDURE write (l:INOUT LINE; value:IN STD_LOGIC; justified: IN SIDE:= RIGHT; field:IN WIDTH:=0);                                               
PROCEDURE write (l:INOUT LINE; value:IN STD_LOGIC_VECTOR; justified: IN SIDE:= RIGHT; field:IN WIDTH:=0);                                        
PROCEDURE throw_error(output_port_name: IN STRING; expected_value : IN STD_LOGIC; real_value : IN STD_LOGIC);                                   
PROCEDURE throw_error(output_port_name: IN STRING; expected_value : IN STD_LOGIC_VECTOR; real_value : IN STD_LOGIC_VECTOR);                     

END KP_vhd_tb_types;

PACKAGE BODY KP_vhd_tb_types IS
        FUNCTION std_logic_to_char (a: STD_LOGIC)  
                RETURN CHARACTER IS                
        BEGIN                                      
        CASE a IS                                  
         WHEN 'U' =>                               
          RETURN 'U';                              
         WHEN 'X' =>                               
          RETURN 'X';                              
         WHEN '0' =>                               
          RETURN '0';                              
         WHEN '1' =>                               
          RETURN '1';                              
         WHEN 'Z' =>                               
          RETURN 'Z';                              
         WHEN 'W' =>                               
          RETURN 'W';                              
         WHEN 'L' =>                               
          RETURN 'L';                              
         WHEN 'H' =>                               
          RETURN 'H';                              
         WHEN '-' =>                               
          RETURN 'D';                              
        END CASE;                                  
        END;                                       

        FUNCTION std_logic_vector_to_string (a: STD_LOGIC_VECTOR)       
                RETURN STRING IS                                        
        VARIABLE result : STRING(1 TO a'LENGTH);                        
        VARIABLE j : NATURAL := 1;                                      
        BEGIN                                                           
                FOR i IN a'RANGE LOOP                                   
                        result(j) := std_logic_to_char(a(i));           
                        j := j + 1;                                     
                END LOOP;                                               
                RETURN result;                                          
        END;                                                            

        PROCEDURE write (l:INOUT LINE; value:IN STD_LOGIC; justified: IN SIDE:=RIGHT; field:IN WIDTH:=0) IS 
        BEGIN                                                           
                write(L,std_logic_to_char(VALUE),JUSTIFIED,field);      
        END;                                                            
                                                                        
        PROCEDURE write (l:INOUT LINE; value:IN STD_LOGIC_VECTOR; justified: IN SIDE:= RIGHT; field:IN WIDTH:=0) IS                           
        BEGIN                                                               
                write(L,std_logic_vector_to_string(VALUE),JUSTIFIED,field); 
        END;                                                                

        PROCEDURE throw_error(output_port_name: IN STRING; expected_value : IN STD_LOGIC; real_value : IN STD_LOGIC) IS                               
        VARIABLE txt : LINE;                                              
        BEGIN                                                             
        write(txt,string'("ERROR! Vector Mismatch for output port "));  
        write(txt,output_port_name);                                      
        write(txt,string'(" :: @time = "));                             
        write(txt,NOW);                                                   
		writeline(output,txt);                                            
        write(txt,string'("     Expected value = "));                   
        write(txt,expected_value);                                        
		writeline(output,txt);                                            
        write(txt,string'("     Real value = "));                       
        write(txt,real_value);                                            
        writeline(output,txt);                                            
        END;                                                              

        PROCEDURE throw_error(output_port_name: IN STRING; expected_value : IN STD_LOGIC_VECTOR; real_value : IN STD_LOGIC_VECTOR) IS                 
        VARIABLE txt : LINE;                                              
        BEGIN                                                             
        write(txt,string'("ERROR! Vector Mismatch for output port "));  
        write(txt,output_port_name);                                      
        write(txt,string'(" :: @time = "));                             
        write(txt,NOW);                                                   
		writeline(output,txt);                                            
        write(txt,string'("     Expected value = "));                   
        write(txt,expected_value);                                        
		writeline(output,txt);                                            
        write(txt,string'("     Real value = "));                       
        write(txt,real_value);                                            
        writeline(output,txt);                                            
        END;                                                              

END KP_vhd_tb_types;

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

USE WORK.KP_vhd_tb_types.ALL;                                         

ENTITY KP_vhd_sample_tst IS
PORT (
	clk : IN STD_LOGIC;
	x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	sampler : OUT sample_type
	);
END KP_vhd_sample_tst;

ARCHITECTURE sample_arch OF KP_vhd_sample_tst IS
SIGNAL tbo_int_sample_clk : sample_type := '-';
SIGNAL current_time : TIME := 0 ps;
BEGIN
t_prcs_sample : PROCESS ( clk , x )
BEGIN
	IF (NOW > 0 ps) THEN
		IF (NOW > 0 ps) AND (NOW /= current_time) THEN
			IF (tbo_int_sample_clk = '-') THEN
				tbo_int_sample_clk <= '0';
			ELSE
				tbo_int_sample_clk <= NOT tbo_int_sample_clk ;
			END IF;
		END IF;
		current_time <= NOW;
	END IF;
END PROCESS t_prcs_sample;
sampler <= tbo_int_sample_clk;
END sample_arch;

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

LIBRARY STD;                                                            
USE STD.textio.ALL;                                                     

USE WORK.KP_vhd_tb_types.ALL;                                         

ENTITY KP_vhd_check_tst IS 
GENERIC (
	debug_tbench : BIT := '0'
);
PORT ( 
	p : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	PMR : IN STD_LOGIC;
	PRS : IN STD_LOGIC;
	result : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	y : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	Z : IN STD_LOGIC;
	sampler : IN sample_type
);
END KP_vhd_check_tst;
ARCHITECTURE ovec_arch OF KP_vhd_check_tst IS
SIGNAL p_expected,p_expected_prev,p_prev : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL PMR_expected,PMR_expected_prev,PMR_prev : STD_LOGIC;
SIGNAL PRS_expected,PRS_expected_prev,PRS_prev : STD_LOGIC;
SIGNAL result_expected,result_expected_prev,result_prev : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL y_expected,y_expected_prev,y_prev : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL Z_expected,Z_expected_prev,Z_prev : STD_LOGIC;

SIGNAL trigger : BIT := '0';
SIGNAL trigger_e : BIT := '0';
SIGNAL trigger_r : BIT := '0';
SIGNAL trigger_i : BIT := '0';
SIGNAL num_mismatches : mmvec := (OTHERS => 0);

BEGIN

-- Update history buffers  expected /o
t_prcs_update_o_expected_hist : PROCESS (trigger) 
BEGIN
	p_expected_prev <= p_expected;
	PMR_expected_prev <= PMR_expected;
	PRS_expected_prev <= PRS_expected;
	result_expected_prev <= result_expected;
	y_expected_prev <= y_expected;
	Z_expected_prev <= Z_expected;
END PROCESS t_prcs_update_o_expected_hist;


-- Update history buffers  real /o
t_prcs_update_o_real_hist : PROCESS (trigger) 
BEGIN
	p_prev <= p;
	PMR_prev <= PMR;
	PRS_prev <= PRS;
	result_prev <= result;
	y_prev <= y;
	Z_prev <= Z;
END PROCESS t_prcs_update_o_real_hist;


-- expected p[6]
t_prcs_p_6: PROCESS
BEGIN
	p_expected(6) <= '0';
WAIT;
END PROCESS t_prcs_p_6;
-- expected p[5]
t_prcs_p_5: PROCESS
BEGIN
	p_expected(5) <= '0';
WAIT;
END PROCESS t_prcs_p_5;
-- expected p[4]
t_prcs_p_4: PROCESS
BEGIN
	p_expected(4) <= '1';
WAIT;
END PROCESS t_prcs_p_4;
-- expected p[3]
t_prcs_p_3: PROCESS
BEGIN
	p_expected(3) <= '0';
WAIT;
END PROCESS t_prcs_p_3;
-- expected p[2]
t_prcs_p_2: PROCESS
BEGIN
	p_expected(2) <= '0';
WAIT;
END PROCESS t_prcs_p_2;
-- expected p[1]
t_prcs_p_1: PROCESS
BEGIN
	p_expected(1) <= '0';
WAIT;
END PROCESS t_prcs_p_1;
-- expected p[0]
t_prcs_p_0: PROCESS
BEGIN
	p_expected(0) <= '1';
WAIT;
END PROCESS t_prcs_p_0;

-- expected PRS
t_prcs_PRS: PROCESS
BEGIN
	PRS_expected <= '0';
WAIT;
END PROCESS t_prcs_PRS;

-- expected PMR
t_prcs_PMR: PROCESS
BEGIN
	PMR_expected <= '1';
WAIT;
END PROCESS t_prcs_PMR;

-- expected Z
t_prcs_Z: PROCESS
BEGIN
	Z_expected <= '0';
WAIT;
END PROCESS t_prcs_Z;
-- expected y[11]
t_prcs_y_11: PROCESS
BEGIN
	y_expected(11) <= '0';
WAIT;
END PROCESS t_prcs_y_11;
-- expected y[10]
t_prcs_y_10: PROCESS
BEGIN
	y_expected(10) <= '0';
WAIT;
END PROCESS t_prcs_y_10;
-- expected y[9]
t_prcs_y_9: PROCESS
BEGIN
	y_expected(9) <= '0';
	WAIT FOR 37907 ps;
	y_expected(9) <= '1';
	WAIT FOR 19770 ps;
	y_expected(9) <= '0';
WAIT;
END PROCESS t_prcs_y_9;
-- expected y[8]
t_prcs_y_8: PROCESS
BEGIN
	y_expected(8) <= '0';
WAIT;
END PROCESS t_prcs_y_8;
-- expected y[7]
t_prcs_y_7: PROCESS
BEGIN
	y_expected(7) <= '0';
WAIT;
END PROCESS t_prcs_y_7;
-- expected y[6]
t_prcs_y_6: PROCESS
BEGIN
	y_expected(6) <= '0';
WAIT;
END PROCESS t_prcs_y_6;
-- expected y[5]
t_prcs_y_5: PROCESS
BEGIN
	y_expected(5) <= '0';
WAIT;
END PROCESS t_prcs_y_5;
-- expected y[4]
t_prcs_y_4: PROCESS
BEGIN
	y_expected(4) <= '0';
WAIT;
END PROCESS t_prcs_y_4;
-- expected y[3]
t_prcs_y_3: PROCESS
BEGIN
	y_expected(3) <= '0';
WAIT;
END PROCESS t_prcs_y_3;
-- expected y[2]
t_prcs_y_2: PROCESS
BEGIN
	y_expected(2) <= '0';
	WAIT FOR 18935 ps;
	y_expected(2) <= '1';
	WAIT FOR 19607 ps;
	y_expected(2) <= '0';
WAIT;
END PROCESS t_prcs_y_2;
-- expected y[1]
t_prcs_y_1: PROCESS
BEGIN
	y_expected(1) <= '0';
	WAIT FOR 18628 ps;
	y_expected(1) <= '1';
	WAIT FOR 39867 ps;
	y_expected(1) <= '0';
WAIT;
END PROCESS t_prcs_y_1;
-- expected y[0]
t_prcs_y_0: PROCESS
BEGIN
	y_expected(0) <= '0';
	WAIT FOR 18008 ps;
	y_expected(0) <= '1';
	WAIT FOR 19784 ps;
	y_expected(0) <= '0';
WAIT;
END PROCESS t_prcs_y_0;
-- expected result[15]
t_prcs_result_15: PROCESS
BEGIN
	result_expected(15) <= '0';
WAIT;
END PROCESS t_prcs_result_15;
-- expected result[14]
t_prcs_result_14: PROCESS
BEGIN
	result_expected(14) <= '1';
WAIT;
END PROCESS t_prcs_result_14;
-- expected result[13]
t_prcs_result_13: PROCESS
BEGIN
	result_expected(13) <= '0';
WAIT;
END PROCESS t_prcs_result_13;
-- expected result[12]
t_prcs_result_12: PROCESS
BEGIN
	result_expected(12) <= '0';
WAIT;
END PROCESS t_prcs_result_12;
-- expected result[11]
t_prcs_result_11: PROCESS
BEGIN
	result_expected(11) <= '0';
WAIT;
END PROCESS t_prcs_result_11;
-- expected result[10]
t_prcs_result_10: PROCESS
BEGIN
	result_expected(10) <= '0';
WAIT;
END PROCESS t_prcs_result_10;
-- expected result[9]
t_prcs_result_9: PROCESS
BEGIN
	result_expected(9) <= '0';
WAIT;
END PROCESS t_prcs_result_9;
-- expected result[8]
t_prcs_result_8: PROCESS
BEGIN
	result_expected(8) <= '0';
WAIT;
END PROCESS t_prcs_result_8;
-- expected result[7]
t_prcs_result_7: PROCESS
BEGIN
	result_expected(7) <= '0';
WAIT;
END PROCESS t_prcs_result_7;
-- expected result[6]
t_prcs_result_6: PROCESS
BEGIN
	result_expected(6) <= '0';
WAIT;
END PROCESS t_prcs_result_6;
-- expected result[5]
t_prcs_result_5: PROCESS
BEGIN
	result_expected(5) <= '0';
WAIT;
END PROCESS t_prcs_result_5;
-- expected result[4]
t_prcs_result_4: PROCESS
BEGIN
	result_expected(4) <= '0';
WAIT;
END PROCESS t_prcs_result_4;
-- expected result[3]
t_prcs_result_3: PROCESS
BEGIN
	result_expected(3) <= '0';
WAIT;
END PROCESS t_prcs_result_3;
-- expected result[2]
t_prcs_result_2: PROCESS
BEGIN
	result_expected(2) <= '0';
WAIT;
END PROCESS t_prcs_result_2;
-- expected result[1]
t_prcs_result_1: PROCESS
BEGIN
	result_expected(1) <= '0';
WAIT;
END PROCESS t_prcs_result_1;
-- expected result[0]
t_prcs_result_0: PROCESS
BEGIN
	result_expected(0) <= '0';
WAIT;
END PROCESS t_prcs_result_0;

-- Set trigger on real/expected o/ pattern changes                        

t_prcs_trigger_e : PROCESS(p_expected,PMR_expected,PRS_expected,result_expected,y_expected,Z_expected)
BEGIN
	trigger_e <= NOT trigger_e;
END PROCESS t_prcs_trigger_e;

t_prcs_trigger_r : PROCESS(p,PMR,PRS,result,y,Z)
BEGIN
	trigger_r <= NOT trigger_r;
END PROCESS t_prcs_trigger_r;


t_prcs_selfcheck : PROCESS
VARIABLE i : INTEGER := 1;
VARIABLE txt : LINE;

VARIABLE last_p_exp : STD_LOGIC_VECTOR(6 DOWNTO 0) := "UUUUUUU";
VARIABLE last_PMR_exp : STD_LOGIC := 'U';
VARIABLE last_PRS_exp : STD_LOGIC := 'U';
VARIABLE last_result_exp : STD_LOGIC_VECTOR(15 DOWNTO 0) := "UUUUUUUUUUUUUUUU";
VARIABLE last_y_exp : STD_LOGIC_VECTOR(11 DOWNTO 0) := "UUUUUUUUUUUU";
VARIABLE last_Z_exp : STD_LOGIC := 'U';

VARIABLE on_first_change : trackvec := "111111";
BEGIN

WAIT UNTIL (sampler'LAST_VALUE = '1'OR sampler'LAST_VALUE = '0')
	AND sampler'EVENT;
IF (debug_tbench = '1') THEN
	write(txt,string'("Scanning pattern "));
	write(txt,i);
	writeline(output,txt);
	write(txt,string'("| expected "));write(txt,p_name);write(txt,string'(" = "));write(txt,p_expected_prev);
	write(txt,string'("| expected "));write(txt,PMR_name);write(txt,string'(" = "));write(txt,PMR_expected_prev);
	write(txt,string'("| expected "));write(txt,PRS_name);write(txt,string'(" = "));write(txt,PRS_expected_prev);
	write(txt,string'("| expected "));write(txt,result_name);write(txt,string'(" = "));write(txt,result_expected_prev);
	write(txt,string'("| expected "));write(txt,y_name);write(txt,string'(" = "));write(txt,y_expected_prev);
	write(txt,string'("| expected "));write(txt,Z_name);write(txt,string'(" = "));write(txt,Z_expected_prev);
	writeline(output,txt);
	write(txt,string'("| real "));write(txt,p_name);write(txt,string'(" = "));write(txt,p_prev);
	write(txt,string'("| real "));write(txt,PMR_name);write(txt,string'(" = "));write(txt,PMR_prev);
	write(txt,string'("| real "));write(txt,PRS_name);write(txt,string'(" = "));write(txt,PRS_prev);
	write(txt,string'("| real "));write(txt,result_name);write(txt,string'(" = "));write(txt,result_prev);
	write(txt,string'("| real "));write(txt,y_name);write(txt,string'(" = "));write(txt,y_prev);
	write(txt,string'("| real "));write(txt,Z_name);write(txt,string'(" = "));write(txt,Z_prev);
	writeline(output,txt);
	i := i + 1;
END IF;
IF ( p_expected_prev /= "XXXXXXX" ) AND (p_expected_prev /= "UUUUUUU" ) AND (p_prev /= p_expected_prev) AND (
	(p_expected_prev /= last_p_exp) OR
	(on_first_change(1) = '1')
		) THEN
	throw_error("p",p_expected_prev,p_prev);
	num_mismatches(0) <= num_mismatches(0) + 1;
	on_first_change(1) := '0';
	last_p_exp := p_expected_prev;
END IF;
IF ( PMR_expected_prev /= 'X' ) AND (PMR_expected_prev /= 'U' ) AND (PMR_prev /= PMR_expected_prev) AND (
	(PMR_expected_prev /= last_PMR_exp) OR
	(on_first_change(2) = '1')
		) THEN
	throw_error("PMR",PMR_expected_prev,PMR_prev);
	num_mismatches(1) <= num_mismatches(1) + 1;
	on_first_change(2) := '0';
	last_PMR_exp := PMR_expected_prev;
END IF;
IF ( PRS_expected_prev /= 'X' ) AND (PRS_expected_prev /= 'U' ) AND (PRS_prev /= PRS_expected_prev) AND (
	(PRS_expected_prev /= last_PRS_exp) OR
	(on_first_change(3) = '1')
		) THEN
	throw_error("PRS",PRS_expected_prev,PRS_prev);
	num_mismatches(2) <= num_mismatches(2) + 1;
	on_first_change(3) := '0';
	last_PRS_exp := PRS_expected_prev;
END IF;
IF ( result_expected_prev /= "XXXXXXXXXXXXXXXX" ) AND (result_expected_prev /= "UUUUUUUUUUUUUUUU" ) AND (result_prev /= result_expected_prev) AND (
	(result_expected_prev /= last_result_exp) OR
	(on_first_change(4) = '1')
		) THEN
	throw_error("result",result_expected_prev,result_prev);
	num_mismatches(3) <= num_mismatches(3) + 1;
	on_first_change(4) := '0';
	last_result_exp := result_expected_prev;
END IF;
IF ( y_expected_prev /= "XXXXXXXXXXXX" ) AND (y_expected_prev /= "UUUUUUUUUUUU" ) AND (y_prev /= y_expected_prev) AND (
	(y_expected_prev /= last_y_exp) OR
	(on_first_change(5) = '1')
		) THEN
	throw_error("y",y_expected_prev,y_prev);
	num_mismatches(4) <= num_mismatches(4) + 1;
	on_first_change(5) := '0';
	last_y_exp := y_expected_prev;
END IF;
IF ( Z_expected_prev /= 'X' ) AND (Z_expected_prev /= 'U' ) AND (Z_prev /= Z_expected_prev) AND (
	(Z_expected_prev /= last_Z_exp) OR
	(on_first_change(6) = '1')
		) THEN
	throw_error("Z",Z_expected_prev,Z_prev);
	num_mismatches(5) <= num_mismatches(5) + 1;
	on_first_change(6) := '0';
	last_Z_exp := Z_expected_prev;
END IF;
    trigger_i <= NOT trigger_i;
END PROCESS t_prcs_selfcheck;


t_prcs_trigger_res : PROCESS(trigger_e,trigger_i,trigger_r)
BEGIN
	trigger <= trigger_i XOR trigger_e XOR trigger_r;
END PROCESS t_prcs_trigger_res;

t_prcs_endsim : PROCESS
VARIABLE txt : LINE;
VARIABLE total_mismatches : INTEGER := 0;
BEGIN
WAIT FOR 1000000 ps;
total_mismatches := num_mismatches(0) + num_mismatches(1) + num_mismatches(2) + num_mismatches(3) + num_mismatches(4) + num_mismatches(5);
IF (total_mismatches = 0) THEN                                              
        write(txt,string'("Simulation passed !"));                        
        writeline(output,txt);                                              
ELSE                                                                        
        write(txt,total_mismatches);                                        
        write(txt,string'(" mismatched vectors : Simulation failed !"));  
        writeline(output,txt);                                              
END IF;                                                                     
WAIT;
END PROCESS t_prcs_endsim;

END ovec_arch;

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

LIBRARY STD;                                                            
USE STD.textio.ALL;                                                     

USE WORK.KP_vhd_tb_types.ALL;                                         

ENTITY KP_vhd_vec_tst IS
END KP_vhd_vec_tst;
ARCHITECTURE KP_arch OF KP_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL p : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL PMR : STD_LOGIC;
SIGNAL PRS : STD_LOGIC;
SIGNAL result : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL x : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL y : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL Z : STD_LOGIC;
SIGNAL sampler : sample_type;

COMPONENT KP
	PORT (
	clk : IN STD_LOGIC;
	p : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	PMR : OUT STD_LOGIC;
	PRS : OUT STD_LOGIC;
	result : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	y : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	Z : OUT STD_LOGIC
	);
END COMPONENT;
COMPONENT KP_vhd_check_tst
PORT ( 
	p : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	PMR : IN STD_LOGIC;
	PRS : IN STD_LOGIC;
	result : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	y : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	Z : IN STD_LOGIC;
	sampler : IN sample_type
);
END COMPONENT;
COMPONENT KP_vhd_sample_tst
PORT (
	clk : IN STD_LOGIC;
	x : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	sampler : OUT sample_type
	);
END COMPONENT;
BEGIN
	i1 : KP
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	p => p,
	PMR => PMR,
	PRS => PRS,
	result => result,
	x => x,
	y => y,
	Z => Z
	);

-- clk
t_prcs_clk: PROCESS
BEGIN
LOOP
	clk <= '0';
	WAIT FOR 10000 ps;
	clk <= '1';
	WAIT FOR 10000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clk;
-- x[15]
t_prcs_x_15: PROCESS
BEGIN
	x(15) <= '0';
WAIT;
END PROCESS t_prcs_x_15;
-- x[14]
t_prcs_x_14: PROCESS
BEGIN
	x(14) <= '0';
WAIT;
END PROCESS t_prcs_x_14;
-- x[13]
t_prcs_x_13: PROCESS
BEGIN
	x(13) <= '0';
WAIT;
END PROCESS t_prcs_x_13;
-- x[12]
t_prcs_x_12: PROCESS
BEGIN
	x(12) <= '0';
WAIT;
END PROCESS t_prcs_x_12;
-- x[11]
t_prcs_x_11: PROCESS
BEGIN
	x(11) <= '0';
WAIT;
END PROCESS t_prcs_x_11;
-- x[10]
t_prcs_x_10: PROCESS
BEGIN
	x(10) <= '0';
WAIT;
END PROCESS t_prcs_x_10;
-- x[9]
t_prcs_x_9: PROCESS
BEGIN
	x(9) <= '0';
WAIT;
END PROCESS t_prcs_x_9;
-- x[8]
t_prcs_x_8: PROCESS
BEGIN
	x(8) <= '0';
WAIT;
END PROCESS t_prcs_x_8;
-- x[7]
t_prcs_x_7: PROCESS
BEGIN
	x(7) <= '0';
WAIT;
END PROCESS t_prcs_x_7;
-- x[6]
t_prcs_x_6: PROCESS
BEGIN
	x(6) <= '0';
WAIT;
END PROCESS t_prcs_x_6;
-- x[5]
t_prcs_x_5: PROCESS
BEGIN
	x(5) <= '0';
WAIT;
END PROCESS t_prcs_x_5;
-- x[4]
t_prcs_x_4: PROCESS
BEGIN
	x(4) <= '0';
WAIT;
END PROCESS t_prcs_x_4;
-- x[3]
t_prcs_x_3: PROCESS
BEGIN
	x(3) <= '0';
WAIT;
END PROCESS t_prcs_x_3;
-- x[2]
t_prcs_x_2: PROCESS
BEGIN
	x(2) <= '0';
WAIT;
END PROCESS t_prcs_x_2;
-- x[1]
t_prcs_x_1: PROCESS
BEGIN
	x(1) <= '0';
WAIT;
END PROCESS t_prcs_x_1;
-- x[0]
t_prcs_x_0: PROCESS
BEGIN
	x(0) <= '0';
WAIT;
END PROCESS t_prcs_x_0;
tb_sample : KP_vhd_sample_tst
PORT MAP (
	clk => clk,
	x => x,
	sampler => sampler
	);

tb_out : KP_vhd_check_tst
PORT MAP (
	p => p,
	PMR => PMR,
	PRS => PRS,
	result => result,
	y => y,
	Z => Z,
	sampler => sampler
	);
END KP_arch;
