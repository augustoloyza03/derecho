-- Copyright (C) 1991-2013 Altera Corporation
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

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Thu Nov 21 22:49:27 2024"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY esqumaticoADC IS 
	PORT
	(
		inclk0 :  IN  STD_LOGIC;
		areset :  IN  STD_LOGIC;
		ADC_DOUT :  IN  STD_LOGIC;
		ADC_SCLK :  OUT  STD_LOGIC;
		ADC_CS_N :  OUT  STD_LOGIC;
		ADC_DIN :  OUT  STD_LOGIC;
		izquierda :  OUT  STD_LOGIC;
		derecha :  OUT  STD_LOGIC
	);
END esqumaticoADC;

ARCHITECTURE bdf_type OF esqumaticoADC IS 

COMPONENT adc
	PORT(CLOCK : IN STD_LOGIC;
		 ADC_DOUT : IN STD_LOGIC;
		 RESET : IN STD_LOGIC;
		 ADC_SCLK : OUT STD_LOGIC;
		 ADC_CS_N : OUT STD_LOGIC;
		 ADC_DIN : OUT STD_LOGIC;
		 CH0 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 CH1 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 CH2 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 CH3 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 CH4 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 CH5 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 CH6 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
		 CH7 : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comparador_adc
	PORT(dataa : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 aleb : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT pll1
	PORT(inclk0 : IN STD_LOGIC;
		 areset : IN STD_LOGIC;
		 c0 : OUT STD_LOGIC;
		 locked : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(11 DOWNTO 0);


BEGIN 



b2v_inst : adc
PORT MAP(CLOCK => SYNTHESIZED_WIRE_0,
		 ADC_DOUT => ADC_DOUT,
		 RESET => SYNTHESIZED_WIRE_5,
		 ADC_SCLK => ADC_SCLK,
		 ADC_CS_N => ADC_CS_N,
		 ADC_DIN => ADC_DIN,
		 CH0 => SYNTHESIZED_WIRE_2,
		 CH1 => SYNTHESIZED_WIRE_4);


b2v_inst1 : comparador_adc
PORT MAP(dataa => SYNTHESIZED_WIRE_2,
		 aleb => izquierda);


b2v_inst2 : pll1
PORT MAP(inclk0 => inclk0,
		 areset => SYNTHESIZED_WIRE_5,
		 c0 => SYNTHESIZED_WIRE_0);


SYNTHESIZED_WIRE_5 <= NOT(areset);



b2v_inst4 : comparador_adc
PORT MAP(dataa => SYNTHESIZED_WIRE_4,
		 aleb => derecha);


END bdf_type;