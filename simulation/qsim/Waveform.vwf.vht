-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "07/11/2018 16:46:36"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          main
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY main_vhd_vec_tst IS
END main_vhd_vec_tst;
ARCHITECTURE main_arch OF main_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clock : STD_LOGIC;
SIGNAL hex0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex4 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex5 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex6 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL hex7 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL key0 : STD_LOGIC;
SIGNAL key1 : STD_LOGIC;
SIGNAL key2 : STD_LOGIC;
SIGNAL key3 : STD_LOGIC;
SIGNAL sw0 : STD_LOGIC;
SIGNAL sw1 : STD_LOGIC;
SIGNAL sw2 : STD_LOGIC;
SIGNAL sw3 : STD_LOGIC;
SIGNAL sw4 : STD_LOGIC;
SIGNAL sw5 : STD_LOGIC;
SIGNAL sw6 : STD_LOGIC;
SIGNAL sw7 : STD_LOGIC;
SIGNAL sw8 : STD_LOGIC;
SIGNAL sw9 : STD_LOGIC;
SIGNAL sw10 : STD_LOGIC;
SIGNAL sw11 : STD_LOGIC;
SIGNAL sw12 : STD_LOGIC;
SIGNAL sw13 : STD_LOGIC;
SIGNAL sw14 : STD_LOGIC;
SIGNAL sw15 : STD_LOGIC;
SIGNAL sw16 : STD_LOGIC;
SIGNAL sw17 : STD_LOGIC;
COMPONENT main
	PORT (
	clock : IN STD_LOGIC;
	hex0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	hex7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	key0 : IN STD_LOGIC;
	key1 : IN STD_LOGIC;
	key2 : IN STD_LOGIC;
	key3 : IN STD_LOGIC;
	sw0 : IN STD_LOGIC;
	sw1 : IN STD_LOGIC;
	sw2 : IN STD_LOGIC;
	sw3 : IN STD_LOGIC;
	sw4 : IN STD_LOGIC;
	sw5 : IN STD_LOGIC;
	sw6 : IN STD_LOGIC;
	sw7 : IN STD_LOGIC;
	sw8 : IN STD_LOGIC;
	sw9 : IN STD_LOGIC;
	sw10 : IN STD_LOGIC;
	sw11 : IN STD_LOGIC;
	sw12 : IN STD_LOGIC;
	sw13 : IN STD_LOGIC;
	sw14 : IN STD_LOGIC;
	sw15 : IN STD_LOGIC;
	sw16 : IN STD_LOGIC;
	sw17 : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : main
	PORT MAP (
-- list connections between master ports and signals
	clock => clock,
	hex0 => hex0,
	hex1 => hex1,
	hex2 => hex2,
	hex3 => hex3,
	hex4 => hex4,
	hex5 => hex5,
	hex6 => hex6,
	hex7 => hex7,
	key0 => key0,
	key1 => key1,
	key2 => key2,
	key3 => key3,
	sw0 => sw0,
	sw1 => sw1,
	sw2 => sw2,
	sw3 => sw3,
	sw4 => sw4,
	sw5 => sw5,
	sw6 => sw6,
	sw7 => sw7,
	sw8 => sw8,
	sw9 => sw9,
	sw10 => sw10,
	sw11 => sw11,
	sw12 => sw12,
	sw13 => sw13,
	sw14 => sw14,
	sw15 => sw15,
	sw16 => sw16,
	sw17 => sw17
	);

-- clock
t_prcs_clock: PROCESS
BEGIN
LOOP
	clock <= '0';
	WAIT FOR 5000 ps;
	clock <= '1';
	WAIT FOR 5000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clock;

-- key0
t_prcs_key0: PROCESS
BEGIN
	key0 <= '0';
WAIT;
END PROCESS t_prcs_key0;

-- key1
t_prcs_key1: PROCESS
BEGIN
	key1 <= '0';
WAIT;
END PROCESS t_prcs_key1;

-- key2
t_prcs_key2: PROCESS
BEGIN
	key2 <= '0';
WAIT;
END PROCESS t_prcs_key2;

-- key3
t_prcs_key3: PROCESS
BEGIN
	key3 <= '0';
WAIT;
END PROCESS t_prcs_key3;

-- sw0
t_prcs_sw0: PROCESS
BEGIN
	sw0 <= '0';
WAIT;
END PROCESS t_prcs_sw0;

-- sw1
t_prcs_sw1: PROCESS
BEGIN
	sw1 <= '1';
WAIT;
END PROCESS t_prcs_sw1;

-- sw2
t_prcs_sw2: PROCESS
BEGIN
	sw2 <= '1';
WAIT;
END PROCESS t_prcs_sw2;

-- sw3
t_prcs_sw3: PROCESS
BEGIN
	sw3 <= '0';
WAIT;
END PROCESS t_prcs_sw3;

-- sw4
t_prcs_sw4: PROCESS
BEGIN
	sw4 <= '0';
WAIT;
END PROCESS t_prcs_sw4;

-- sw5
t_prcs_sw5: PROCESS
BEGIN
	sw5 <= '0';
WAIT;
END PROCESS t_prcs_sw5;

-- sw6
t_prcs_sw6: PROCESS
BEGIN
	sw6 <= '0';
WAIT;
END PROCESS t_prcs_sw6;

-- sw7
t_prcs_sw7: PROCESS
BEGIN
	sw7 <= '0';
WAIT;
END PROCESS t_prcs_sw7;

-- sw8
t_prcs_sw8: PROCESS
BEGIN
	sw8 <= '0';
WAIT;
END PROCESS t_prcs_sw8;

-- sw9
t_prcs_sw9: PROCESS
BEGIN
	sw9 <= '0';
WAIT;
END PROCESS t_prcs_sw9;

-- sw10
t_prcs_sw10: PROCESS
BEGIN
	sw10 <= '0';
WAIT;
END PROCESS t_prcs_sw10;

-- sw11
t_prcs_sw11: PROCESS
BEGIN
	sw11 <= '0';
WAIT;
END PROCESS t_prcs_sw11;

-- sw12
t_prcs_sw12: PROCESS
BEGIN
	sw12 <= '0';
WAIT;
END PROCESS t_prcs_sw12;

-- sw13
t_prcs_sw13: PROCESS
BEGIN
	sw13 <= '0';
WAIT;
END PROCESS t_prcs_sw13;

-- sw14
t_prcs_sw14: PROCESS
BEGIN
	sw14 <= '0';
WAIT;
END PROCESS t_prcs_sw14;

-- sw15
t_prcs_sw15: PROCESS
BEGIN
	sw15 <= '0';
WAIT;
END PROCESS t_prcs_sw15;

-- sw16
t_prcs_sw16: PROCESS
BEGIN
	sw16 <= '0';
WAIT;
END PROCESS t_prcs_sw16;

-- sw17
t_prcs_sw17: PROCESS
BEGIN
	sw17 <= '0';
WAIT;
END PROCESS t_prcs_sw17;
END main_arch;
