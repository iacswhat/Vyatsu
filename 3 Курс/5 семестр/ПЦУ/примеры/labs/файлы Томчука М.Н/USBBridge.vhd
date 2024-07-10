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
-- VERSION		"Version 10.1 Build 153 11/29/2010 SJ Web Edition"
-- CREATED		"Wed Aug 24 19:47:32 2011"

LIBRARY ieee;																	-- библиотека стандарта типов данных
USE ieee.std_logic_1164.all; 													-- тип std_logic

LIBRARY work;																	-- рабочая библиотека проекта

ENTITY USBBridge IS 															-- описание портов
	PORT
	(
		mode_usb_n :  IN  STD_LOGIC;											-- режим работы USB (1 - программирование, 0 - обмен); вывод 23
		USB_TXEn :  IN  STD_LOGIC;												-- разрешение передачи USB (низкий уровень); вывод 42
		USB_RXFn :  IN  STD_LOGIC;												-- разрешение чтения (низкий уровень говорит о наличии данных); вывод 39
		CLKIN :  IN  STD_LOGIC;													-- входной тактовый сигнал (рекомендуемый - скважность 2 частота <=1 МГц)
		RDY :  IN  STD_LOGIC;													-- флаг готовности
		ZF :  IN  STD_LOGIC;													-- флаг нуля
		SF :  IN  STD_LOGIC;													-- флаг знака
		CF :  IN  STD_LOGIC;													-- флаг переноса
		DIV0 :  IN  STD_LOGIC;													-- флаг деления на 0
		PRS :  IN  STD_LOGIC;													-- флаг переполнения
		BusOut :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);							-- вход результата (к нему подключается выходная шина устройства, данные сохраняются в регистре моста по спаду сигнала Z)
		P :  IN  STD_LOGIC_VECTOR(63 DOWNTO 0);									-- осведомительные сигналы
		USB_Data :  INOUT  STD_LOGIC_VECTOR(7 DOWNTO 0);						-- шина данных для обмена с FIFO USB; выводы 38, 32, 44, 50, 30, 28, 31
		USB_WR :  OUT  STD_LOGIC;												-- запись в очередь FIFO USB; вывод 98
		USB_RDn :  OUT  STD_LOGIC;												-- чтение очереди FIFO USB; вывод 43
		Mode :  OUT  STD_LOGIC;													-- режим работы (задаётся с ЭВМ - низкий уровень - clk из программы, высокий - CLKIN)
		OClk :  OUT  STD_LOGIC;													-- тактовый сигнал для АЛУ
		Reset :  OUT  STD_LOGIC;												-- сброс АЛУ, формируется в программе
		X :  OUT  STD_LOGIC;													-- сигнал готовности операнда
		Z :  OUT  STD_LOGIC;													-- сигнал готовности к приёму результата
		BusIn :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);							-- выход операнда, подаётся на вход АЛУ. Операнд подаётся при высоком уровне Х и CLK
		Y :  OUT  STD_LOGIC_VECTOR(63 DOWNTO 0)									-- правляющие сигналы
	);
END USBBridge;

ARCHITECTURE bdf_type OF USBBridge IS 
																				-- компоненты моста
COMPONENT usb_rg8e																-- восьмиразрядный регистр
	PORT(C : IN STD_LOGIC;
		 E : IN STD_LOGIC;
		 DI : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 DO : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT usb_mux1x2															-- одноразрядный мультиплексор 2 в 1
	PORT(data0 : IN STD_LOGIC;
		 data1 : IN STD_LOGIC;
		 sel : IN STD_LOGIC;
		 result : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT usb_dc8																-- дешифратор
	PORT(enable : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 eq0 : OUT STD_LOGIC;
		 eq1 : OUT STD_LOGIC;
		 eq10 : OUT STD_LOGIC;
		 eq11 : OUT STD_LOGIC;
		 eq12 : OUT STD_LOGIC;
		 eq13 : OUT STD_LOGIC;
		 eq14 : OUT STD_LOGIC;
		 eq15 : OUT STD_LOGIC;
		 eq16 : OUT STD_LOGIC;
		 eq17 : OUT STD_LOGIC;
		 eq18 : OUT STD_LOGIC;
		 eq19 : OUT STD_LOGIC;
		 eq2 : OUT STD_LOGIC;
		 eq3 : OUT STD_LOGIC;
		 eq4 : OUT STD_LOGIC;
		 eq5 : OUT STD_LOGIC;
		 eq6 : OUT STD_LOGIC;
		 eq7 : OUT STD_LOGIC;
		 eq8 : OUT STD_LOGIC;
		 eq9 : OUT STD_LOGIC;
		 eq20 : OUT STD_LOGIC;
		 eq28 : OUT STD_LOGIC;
		 eq21 : OUT STD_LOGIC;
		 eq22 : OUT STD_LOGIC;
		 eq23 : OUT STD_LOGIC;
		 eq24 : OUT STD_LOGIC;
		 eq25 : OUT STD_LOGIC;
		 eq26 : OUT STD_LOGIC;
		 eq27 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT usb_ct3																-- счётчик
	PORT(clock : IN STD_LOGIC;
		 cnt_en : IN STD_LOGIC;
		 aclr : IN STD_LOGIC;
		 q : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END COMPONENT;

COMPONENT usb_dc3																-- троичный дешифратор
	PORT(data : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 eq0 : OUT STD_LOGIC;
		 eq1 : OUT STD_LOGIC;
		 eq2 : OUT STD_LOGIC;
		 eq3 : OUT STD_LOGIC;
		 eq4 : OUT STD_LOGIC;
		 eq5 : OUT STD_LOGIC;
		 eq6 : OUT STD_LOGIC;
		 eq7 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT usb_mux8x2 															-- восьмиразрядный мультиплексор 2 в 1
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT usb_mux8x19															-- восьмиразрядный мультиплексор 28 в 1
	PORT(data0x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data10x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data11x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data12x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data13x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data14x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data15x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data16x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data17x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data18x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data19x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data20x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data21x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data22x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data23x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data24x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data25x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data26x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data27x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data2x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data3x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data4x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data5x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data6x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data7x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data8x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data9x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 sel : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;
																				-- сигналы
SIGNAL	CLKINn :  STD_LOGIC;
SIGNAL	DOAdr :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	DOBusIn :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	DOBusOut :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	DOCT3 :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	DOMode :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	DOStrobes :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	DOY :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	E0 :  STD_LOGIC;
SIGNAL	E1 :  STD_LOGIC;
SIGNAL	E17 :  STD_LOGIC;
SIGNAL	E19 :  STD_LOGIC;
SIGNAL	E2 :  STD_LOGIC;
SIGNAL	E20 :  STD_LOGIC;
SIGNAL	E21 :  STD_LOGIC;
SIGNAL	E22 :  STD_LOGIC;
SIGNAL	E23 :  STD_LOGIC;
SIGNAL	E24 :  STD_LOGIC;
SIGNAL	E25 :  STD_LOGIC;
SIGNAL	E26 :  STD_LOGIC;
SIGNAL	E27 :  STD_LOGIC;
SIGNAL	E28 :  STD_LOGIC;
SIGNAL	E3 :  STD_LOGIC;
SIGNAL	E4 :  STD_LOGIC;
SIGNAL	E5 :  STD_LOGIC;
SIGNAL	E6 :  STD_LOGIC;
SIGNAL	E7 :  STD_LOGIC;
SIGNAL	ena_usb :  STD_LOGIC;
SIGNAL	Flags :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	Mode_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	OCLK_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	Reset_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	rst :  STD_LOGIC;
SIGNAL	rstn :  STD_LOGIC;
SIGNAL	State0 :  STD_LOGIC;
SIGNAL	State1 :  STD_LOGIC;
SIGNAL	State2 :  STD_LOGIC;
SIGNAL	State3 :  STD_LOGIC;
SIGNAL	State4 :  STD_LOGIC;
SIGNAL	State5 :  STD_LOGIC;
SIGNAL	State6 :  STD_LOGIC;
SIGNAL	State7 :  STD_LOGIC;
SIGNAL	USBDO :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	USBRDn :  STD_LOGIC;
SIGNAL	USBWR :  STD_LOGIC;
SIGNAL	X_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	Y_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(63 DOWNTO 0);
SIGNAL	Z_ALTERA_SYNTHESIZED :  STD_LOGIC;
SIGNAL	Zn :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_31 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_32 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_33 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_34 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC;
SIGNAL	DFFE_inst23 :  STD_LOGIC;
SIGNAL	DFFE_inst33 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_35 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_19 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_21 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_23 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_24 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_25 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_26 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_27 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_28 :  STD_LOGIC_VECTOR(0 TO 7);
SIGNAL	SYNTHESIZED_WIRE_29 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_30 :  STD_LOGIC;


BEGIN 
SYNTHESIZED_WIRE_4 <= '1';
SYNTHESIZED_WIRE_7 <= '1';
SYNTHESIZED_WIRE_11 <= '1';
SYNTHESIZED_WIRE_15 <= '1';
SYNTHESIZED_WIRE_35 <= '1';
SYNTHESIZED_WIRE_28 <= "00000000";



b2v_inst : usb_rg8e
PORT MAP(C => USBRDn,
		 E => E0,
		 DI => USB_Data,
		 DO => DOBusIn(7 DOWNTO 0));



SYNTHESIZED_WIRE_25 <= NOT(State3 OR State1);


Y_ALTERA_SYNTHESIZED(48) <= DOY(48) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(49) <= DOY(49) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(50) <= DOY(50) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(51) <= DOY(51) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(52) <= DOY(52) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(53) <= DOY(53) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(54) <= DOY(54) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(55) <= DOY(55) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(56) <= DOY(56) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(57) <= DOY(57) AND OCLK_ALTERA_SYNTHESIZED;


b2v_inst11 : usb_rg8e
PORT MAP(C => USBRDn,
		 E => E19,
		 DI => USB_Data,
		 DO => DOMode);


Y_ALTERA_SYNTHESIZED(58) <= DOY(58) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(59) <= DOY(59) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(60) <= DOY(60) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(61) <= DOY(61) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(62) <= DOY(62) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(63) <= DOY(63) AND OCLK_ALTERA_SYNTHESIZED;


b2v_inst116 : usb_mux1x2
PORT MAP(data0 => DOStrobes(1),
		 data1 => CLKIN,
		 sel => Mode_ALTERA_SYNTHESIZED,
		 result => OCLK_ALTERA_SYNTHESIZED);


SYNTHESIZED_WIRE_26 <= State7 OR State5;

Mode_ALTERA_SYNTHESIZED <= DOMode(0);



b2v_inst14 : usb_dc8
PORT MAP(enable => SYNTHESIZED_WIRE_0,
		 data => DOAdr(6 DOWNTO 0),
		 eq0 => E0,
		 eq1 => E1,
		 eq17 => E17,
		 eq19 => E19,
		 eq2 => E2,
		 eq3 => E3,
		 eq20 => E20,
		 eq21 => E21,
		 eq22 => E22,
		 eq23 => E23,
		 eq24 => E24,
		 eq25 => E25,
		 eq26 => E26,
		 eq27 => E27);


CLKINn <= NOT(CLKIN);



ena_usb <= NOT(mode_usb_n);



SYNTHESIZED_WIRE_21 <= NOT(SYNTHESIZED_WIRE_1);




PROCESS(USBRDn)
BEGIN
IF (RISING_EDGE(USBRDn)) THEN
	IF (E17 = '1') THEN
	DOStrobes(0) <= USB_Data(0);
	END IF;
END IF;
END PROCESS;


PROCESS(USBRDn)
BEGIN
IF (RISING_EDGE(USBRDn)) THEN
	IF (E17 = '1') THEN
	DOStrobes(1) <= USB_Data(1);
	END IF;
END IF;
END PROCESS;


PROCESS(USBRDn,SYNTHESIZED_WIRE_31)
BEGIN
IF (SYNTHESIZED_WIRE_31 = '0') THEN
	DOStrobes(2) <= '0';
ELSIF (RISING_EDGE(USBRDn)) THEN
	IF (E17 = '1') THEN
	DOStrobes(2) <= USB_Data(2);
	END IF;
END IF;
END PROCESS;



PROCESS(SYNTHESIZED_WIRE_32,SYNTHESIZED_WIRE_31)
BEGIN
IF (SYNTHESIZED_WIRE_31 = '0') THEN
	X_ALTERA_SYNTHESIZED <= '0';
ELSIF (RISING_EDGE(SYNTHESIZED_WIRE_32)) THEN
	IF (DOStrobes(2) = '1') THEN
	X_ALTERA_SYNTHESIZED <= SYNTHESIZED_WIRE_4;
	END IF;
END IF;
END PROCESS;



SYNTHESIZED_WIRE_32 <= NOT(OCLK_ALTERA_SYNTHESIZED);



PROCESS(SYNTHESIZED_WIRE_32,SYNTHESIZED_WIRE_31)
BEGIN
IF (SYNTHESIZED_WIRE_31 = '0') THEN
	DFFE_inst23 <= '0';
ELSIF (RISING_EDGE(SYNTHESIZED_WIRE_32)) THEN
	IF (X_ALTERA_SYNTHESIZED = '1') THEN
	DFFE_inst23 <= SYNTHESIZED_WIRE_7;
	END IF;
END IF;
END PROCESS;




PROCESS(USBRDn,SYNTHESIZED_WIRE_33)
BEGIN
IF (SYNTHESIZED_WIRE_33 = '0') THEN
	DOStrobes(3) <= '0';
ELSIF (RISING_EDGE(USBRDn)) THEN
	IF (E17 = '1') THEN
	DOStrobes(3) <= USB_Data(3);
	END IF;
END IF;
END PROCESS;


PROCESS(SYNTHESIZED_WIRE_34,SYNTHESIZED_WIRE_33)
BEGIN
IF (SYNTHESIZED_WIRE_33 = '0') THEN
	Z_ALTERA_SYNTHESIZED <= '0';
ELSIF (RISING_EDGE(SYNTHESIZED_WIRE_34)) THEN
	IF (DOStrobes(3) = '1') THEN
	Z_ALTERA_SYNTHESIZED <= SYNTHESIZED_WIRE_11;
	END IF;
END IF;
END PROCESS;


PROCESS(USBWR,ena_usb)
BEGIN
if (ena_usb = '1') THEN
	USB_WR <= USBWR;
ELSE
	USB_WR <= 'Z';
END IF;
END PROCESS;


PROCESS(USBRDn,ena_usb)
BEGIN
if (ena_usb = '1') THEN
	USB_RDn <= USBRDn;
ELSE
	USB_RDn <= 'Z';
END IF;
END PROCESS;


b2v_inst3 : usb_rg8e
PORT MAP(C => USBRDn,
		 E => E1,
		 DI => USB_Data,
		 DO => DOBusIn(15 DOWNTO 8));


PROCESS(USBDO,SYNTHESIZED_WIRE_13)
BEGIN
if (SYNTHESIZED_WIRE_13 = '1') THEN
	USB_Data(7) <= USBDO(7);
ELSE
	USB_Data(7) <= 'Z';
END IF;
END PROCESS;

PROCESS(USBDO,SYNTHESIZED_WIRE_13)
BEGIN
if (SYNTHESIZED_WIRE_13 = '1') THEN
	USB_Data(6) <= USBDO(6);
ELSE
	USB_Data(6) <= 'Z';
END IF;
END PROCESS;

PROCESS(USBDO,SYNTHESIZED_WIRE_13)
BEGIN
if (SYNTHESIZED_WIRE_13 = '1') THEN
	USB_Data(5) <= USBDO(5);
ELSE
	USB_Data(5) <= 'Z';
END IF;
END PROCESS;

PROCESS(USBDO,SYNTHESIZED_WIRE_13)
BEGIN
if (SYNTHESIZED_WIRE_13 = '1') THEN
	USB_Data(4) <= USBDO(4);
ELSE
	USB_Data(4) <= 'Z';
END IF;
END PROCESS;

PROCESS(USBDO,SYNTHESIZED_WIRE_13)
BEGIN
if (SYNTHESIZED_WIRE_13 = '1') THEN
	USB_Data(3) <= USBDO(3);
ELSE
	USB_Data(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(USBDO,SYNTHESIZED_WIRE_13)
BEGIN
if (SYNTHESIZED_WIRE_13 = '1') THEN
	USB_Data(2) <= USBDO(2);
ELSE
	USB_Data(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(USBDO,SYNTHESIZED_WIRE_13)
BEGIN
if (SYNTHESIZED_WIRE_13 = '1') THEN
	USB_Data(1) <= USBDO(1);
ELSE
	USB_Data(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(USBDO,SYNTHESIZED_WIRE_13)
BEGIN
if (SYNTHESIZED_WIRE_13 = '1') THEN
	USB_Data(0) <= USBDO(0);
ELSE
	USB_Data(0) <= 'Z';
END IF;
END PROCESS;



SYNTHESIZED_WIRE_34 <= NOT(OCLK_ALTERA_SYNTHESIZED);



PROCESS(SYNTHESIZED_WIRE_34,SYNTHESIZED_WIRE_33)
BEGIN
IF (SYNTHESIZED_WIRE_33 = '0') THEN
	DFFE_inst33 <= '0';
ELSIF (RISING_EDGE(SYNTHESIZED_WIRE_34)) THEN
	IF (Z_ALTERA_SYNTHESIZED = '1') THEN
	DFFE_inst33 <= SYNTHESIZED_WIRE_15;
	END IF;
END IF;
END PROCESS;



SYNTHESIZED_WIRE_31 <= NOT(Reset_ALTERA_SYNTHESIZED OR rst OR DFFE_inst23);


SYNTHESIZED_WIRE_33 <= NOT(Reset_ALTERA_SYNTHESIZED OR rst OR DFFE_inst33);


b2v_inst37 : usb_rg8e
PORT MAP(C => Zn,
		 E => SYNTHESIZED_WIRE_35,
		 DI => BusOut(23 DOWNTO 16),
		 DO => DOBusOut(23 DOWNTO 16));


b2v_inst38 : usb_rg8e
PORT MAP(C => Zn,
		 E => SYNTHESIZED_WIRE_35,
		 DI => BusOut(31 DOWNTO 24),
		 DO => DOBusOut(31 DOWNTO 24));


b2v_inst39 : usb_rg8e
PORT MAP(C => USBRDn,
		 E => E21,
		 DI => USB_Data,
		 DO => DOY(15 DOWNTO 8));


b2v_inst4 : usb_rg8e
PORT MAP(C => USBRDn,
		 E => E2,
		 DI => USB_Data,
		 DO => DOBusIn(23 DOWNTO 16));


b2v_inst40 : usb_rg8e
PORT MAP(C => USBRDn,
		 E => E22,
		 DI => USB_Data,
		 DO => DOY(23 DOWNTO 16));


PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(31) <= DOBusIn(31);
ELSE
	BusIn(31) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(30) <= DOBusIn(30);
ELSE
	BusIn(30) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(29) <= DOBusIn(29);
ELSE
	BusIn(29) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(28) <= DOBusIn(28);
ELSE
	BusIn(28) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(27) <= DOBusIn(27);
ELSE
	BusIn(27) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(26) <= DOBusIn(26);
ELSE
	BusIn(26) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(25) <= DOBusIn(25);
ELSE
	BusIn(25) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(24) <= DOBusIn(24);
ELSE
	BusIn(24) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(23) <= DOBusIn(23);
ELSE
	BusIn(23) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(22) <= DOBusIn(22);
ELSE
	BusIn(22) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(21) <= DOBusIn(21);
ELSE
	BusIn(21) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(20) <= DOBusIn(20);
ELSE
	BusIn(20) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(19) <= DOBusIn(19);
ELSE
	BusIn(19) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(18) <= DOBusIn(18);
ELSE
	BusIn(18) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(17) <= DOBusIn(17);
ELSE
	BusIn(17) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(16) <= DOBusIn(16);
ELSE
	BusIn(16) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(15) <= DOBusIn(15);
ELSE
	BusIn(15) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(14) <= DOBusIn(14);
ELSE
	BusIn(14) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(13) <= DOBusIn(13);
ELSE
	BusIn(13) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(12) <= DOBusIn(12);
ELSE
	BusIn(12) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(11) <= DOBusIn(11);
ELSE
	BusIn(11) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(10) <= DOBusIn(10);
ELSE
	BusIn(10) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(9) <= DOBusIn(9);
ELSE
	BusIn(9) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(8) <= DOBusIn(8);
ELSE
	BusIn(8) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(7) <= DOBusIn(7);
ELSE
	BusIn(7) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(6) <= DOBusIn(6);
ELSE
	BusIn(6) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(5) <= DOBusIn(5);
ELSE
	BusIn(5) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(4) <= DOBusIn(4);
ELSE
	BusIn(4) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(3) <= DOBusIn(3);
ELSE
	BusIn(3) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(2) <= DOBusIn(2);
ELSE
	BusIn(2) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(1) <= DOBusIn(1);
ELSE
	BusIn(1) <= 'Z';
END IF;
END PROCESS;

PROCESS(DOBusIn,SYNTHESIZED_WIRE_19)
BEGIN
if (SYNTHESIZED_WIRE_19 = '1') THEN
	BusIn(0) <= DOBusIn(0);
ELSE
	BusIn(0) <= 'Z';
END IF;
END PROCESS;


SYNTHESIZED_WIRE_19 <= OCLK_ALTERA_SYNTHESIZED AND X_ALTERA_SYNTHESIZED;


b2v_inst43 : usb_rg8e
PORT MAP(C => Zn,
		 E => SYNTHESIZED_WIRE_35,
		 DI => BusOut(7 DOWNTO 0),
		 DO => DOBusOut(7 DOWNTO 0));


Zn <= NOT(Z_ALTERA_SYNTHESIZED);




b2v_inst46 : usb_rg8e
PORT MAP(C => USBRDn,
		 E => E20,
		 DI => USB_Data,
		 DO => DOY(7 DOWNTO 0));


b2v_inst47 : usb_rg8e
PORT MAP(C => USBRDn,
		 E => E23,
		 DI => USB_Data,
		 DO => DOY(31 DOWNTO 24));


b2v_inst48 : usb_rg8e
PORT MAP(C => USBRDn,
		 E => E24,
		 DI => USB_Data,
		 DO => DOY(39 DOWNTO 32));


b2v_inst49 : usb_rg8e
PORT MAP(C => USBRDn,
		 E => E25,
		 DI => USB_Data,
		 DO => DOY(47 DOWNTO 40));


b2v_inst5 : usb_ct3
PORT MAP(clock => CLKIN,
		 cnt_en => SYNTHESIZED_WIRE_21,
		 aclr => rst,
		 q => DOCT3);


b2v_inst50 : usb_rg8e
PORT MAP(C => USBRDn,
		 E => E26,
		 DI => USB_Data,
		 DO => DOY(55 DOWNTO 48));


b2v_inst51 : usb_rg8e
PORT MAP(C => USBRDn,
		 E => E27,
		 DI => USB_Data,
		 DO => DOY(63 DOWNTO 56));


Y_ALTERA_SYNTHESIZED(0) <= DOY(0) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(1) <= DOY(1) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(2) <= DOY(2) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(3) <= DOY(3) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(4) <= DOY(4) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(5) <= DOY(5) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(6) <= DOY(6) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(7) <= DOY(7) AND OCLK_ALTERA_SYNTHESIZED;


b2v_inst6 : usb_rg8e
PORT MAP(C => USBRDn,
		 E => E3,
		 DI => USB_Data,
		 DO => DOBusIn(31 DOWNTO 24));


Y_ALTERA_SYNTHESIZED(8) <= DOY(8) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(9) <= DOY(9) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(10) <= DOY(10) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(11) <= DOY(11) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(12) <= DOY(12) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(13) <= DOY(13) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(14) <= DOY(14) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(15) <= DOY(15) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(16) <= DOY(16) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(17) <= DOY(17) AND OCLK_ALTERA_SYNTHESIZED;


SYNTHESIZED_WIRE_24 <= State6 OR State4;


Y_ALTERA_SYNTHESIZED(18) <= DOY(18) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(19) <= DOY(19) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(20) <= DOY(20) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(21) <= DOY(21) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(22) <= DOY(22) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(23) <= DOY(23) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(24) <= DOY(24) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(25) <= DOY(25) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(26) <= DOY(26) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(27) <= DOY(27) AND OCLK_ALTERA_SYNTHESIZED;

rst <= mode_usb_n;



Y_ALTERA_SYNTHESIZED(28) <= DOY(28) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(29) <= DOY(29) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(30) <= DOY(30) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(31) <= DOY(31) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(32) <= DOY(32) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(33) <= DOY(33) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(34) <= DOY(34) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(35) <= DOY(35) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(36) <= DOY(36) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(37) <= DOY(37) AND OCLK_ALTERA_SYNTHESIZED;


b2v_inst9 : usb_rg8e
PORT MAP(C => Zn,
		 E => SYNTHESIZED_WIRE_35,
		 DI => BusOut(15 DOWNTO 8),
		 DO => DOBusOut(15 DOWNTO 8));


Y_ALTERA_SYNTHESIZED(38) <= DOY(38) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(39) <= DOY(39) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(40) <= DOY(40) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(41) <= DOY(41) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(42) <= DOY(42) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(43) <= DOY(43) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(44) <= DOY(44) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(45) <= DOY(45) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(46) <= DOY(46) AND OCLK_ALTERA_SYNTHESIZED;


Y_ALTERA_SYNTHESIZED(47) <= DOY(47) AND OCLK_ALTERA_SYNTHESIZED;


SYNTHESIZED_WIRE_30 <= SYNTHESIZED_WIRE_23 AND USB_RXFn;


SYNTHESIZED_WIRE_13 <= ena_usb AND USBWR;


SYNTHESIZED_WIRE_0 <= DOCT3(2) AND DOAdr(7);


SYNTHESIZED_WIRE_29 <= SYNTHESIZED_WIRE_24 AND USB_TXEn;


b2v_instdc3 : usb_dc3
PORT MAP(data => DOCT3,
		 eq0 => State0,
		 eq1 => State1,
		 eq2 => State2,
		 eq3 => State3,
		 eq4 => State4,
		 eq5 => State5,
		 eq6 => State6,
		 eq7 => State7);


PROCESS(CLKINn)
BEGIN
IF (RISING_EDGE(CLKINn)) THEN
	USBRDn <= SYNTHESIZED_WIRE_25;
END IF;
END PROCESS;


PROCESS(CLKINn)
BEGIN
IF (RISING_EDGE(CLKINn)) THEN
	USBWR <= SYNTHESIZED_WIRE_26;
END IF;
END PROCESS;


b2v_instmux1 : usb_mux8x2
PORT MAP(sel => State0,
		 data0x => DOAdr,
		 data1x => SYNTHESIZED_WIRE_27,
		 result => USBDO);


b2v_instmux2 : usb_mux8x19
PORT MAP(data0x => DOBusIn(7 DOWNTO 0),
		 data10x => P(23 DOWNTO 16),
		 data11x => P(31 DOWNTO 24),
		 data12x => P(39 DOWNTO 32),
		 data13x => P(47 DOWNTO 40),
		 data14x => P(55 DOWNTO 48),
		 data15x => P(63 DOWNTO 56),
		 data16x => SYNTHESIZED_WIRE_28,
		 data17x => DOStrobes,
		 data18x => Flags,
		 data19x => DOMode,
		 data1x => DOBusIn(15 DOWNTO 8),
		 data20x => DOY(7 DOWNTO 0),
		 data21x => DOY(15 DOWNTO 8),
		 data22x => DOY(23 DOWNTO 16),
		 data23x => DOY(31 DOWNTO 24),
		 data24x => DOY(39 DOWNTO 32),
		 data25x => DOY(47 DOWNTO 40),
		 data26x => DOY(55 DOWNTO 48),
		 data27x => DOY(63 DOWNTO 56),
		 data2x => DOBusIn(23 DOWNTO 16),
		 data3x => DOBusIn(31 DOWNTO 24),
		 data4x => DOBusOut(7 DOWNTO 0),
		 data5x => DOBusOut(15 DOWNTO 8),
		 data6x => DOBusOut(23 DOWNTO 16),
		 data7x => DOBusOut(31 DOWNTO 24),
		 data8x => P(7 DOWNTO 0),
		 data9x => P(15 DOWNTO 8),
		 sel => DOAdr(4 DOWNTO 0),
		 result => SYNTHESIZED_WIRE_27);


SYNTHESIZED_WIRE_23 <= State2 OR State0;


SYNTHESIZED_WIRE_1 <= SYNTHESIZED_WIRE_29 OR SYNTHESIZED_WIRE_30;


b2v_instRgAdr : usb_rg8e
PORT MAP(C => USBRDn,
		 E => DOCT3(1),
		 DI => USB_Data,
		 DO => DOAdr);

Reset_ALTERA_SYNTHESIZED <= DOStrobes(0);
Mode <= Mode_ALTERA_SYNTHESIZED;
OClk <= OCLK_ALTERA_SYNTHESIZED;
Reset <= Reset_ALTERA_SYNTHESIZED;
X <= X_ALTERA_SYNTHESIZED;
Z <= Z_ALTERA_SYNTHESIZED;
Y <= Y_ALTERA_SYNTHESIZED;

DOStrobes(7 DOWNTO 4) <= "0000";
Flags(0) <= RDY;
Flags(1) <= ZF;
Flags(2) <= SF;
Flags(3) <= CF;
Flags(5) <= DIV0;
Flags(7 DOWNTO 6) <= "00";
Flags(4) <= PRS;
END bdf_type;