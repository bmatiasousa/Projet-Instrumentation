----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2022 14:08:27
-- Design Name: 
-- Module Name: frequencymeter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- USE ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;

entity frequencymeter is
    Port ( clk : in  STD_LOGIC;
           rst : in STD_LOGIC;
           Data_in: in STD_LOGIC;  
           Data_out : out STD_LOGIC_VECTOR(23 DOWNTO 0));
end frequencymeter;

architecture Behavioral of frequencymeter is
    
component riseDetect is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
	       entree : in STD_LOGIC;
           front : out  STD_LOGIC);
end component;

component compteurClock is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           front_signal : in  STD_LOGIC;
           periode : out  STD_LOGIC_VECTOR (27 downto 0));
end component;

component perToFreq is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           periode : in  STD_LOGIC_VECTOR (27 downto 0);
           frequence : out  STD_LOGIC_VECTOR (23 downto 0));
end component;
    
signal frontsignal: STD_LOGIC;
signal T: STD_LOGIC_VECTOR(27 DOWNTO 0);
    
    
begin
    
-- Port Map    
rise_detect: riseDetect PORT MAP(
    rst => rst,
    clk => clk,
    entree => Data_in,
    front => frontsignal); 
    
compteur_clock: compteurClock PORT MAP(
     clk => clk,
     rst => rst,
     front_signal => frontsignal,
     periode => T);
     
converseur: perToFreq PORT MAP(
     clk => clk,
     rst => rst,
     periode => T,
     frequence => Data_out); 
    
end Behavioral;




    

