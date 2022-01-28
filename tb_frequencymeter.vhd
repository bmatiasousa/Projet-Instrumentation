----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2022 22:19:54
-- Design Name: 
-- Module Name: tb_frequencymeter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_frequencymeter is
--  Port ( );
end tb_frequencymeter;

architecture Behavioral of tb_frequencymeter is

component frequencymeter is
    Port ( clk : in  STD_LOGIC;
           rst : in STD_LOGIC;
           Data_in: in STD_LOGIC;  
           Data_out : out STD_LOGIC_VECTOR(23 DOWNTO 0));
end component;

component afficheur is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           frequence: in STD_LOGIC_VECTOR(23 downto 0);
           point: out STD_LOGIC;
           calibre: out STD_LOGIC_VECTOR(2 downto 0);
           selecteur: out STD_LOGIC_VECTOR(3 downto 0);
           segments: out STD_LOGIC_VECTOR(6 downto 0));
end component;

   SIGNAL entree	:	STD_LOGIC;
   SIGNAL clk	:	STD_LOGIC;
   SIGNAL rst	:	STD_LOGIC;
   SIGNAL freq	:	STD_LOGIC_VECTOR (23 DOWNTO 0);
   SIGNAL dp	:	STD_LOGIC;
   SIGNAL cali	:	STD_LOGIC_VECTOR (2 DOWNTO 0);
   SIGNAL AN	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL BCD	:	STD_LOGIC_VECTOR (6 DOWNTO 0);

BEGIN

   UUT: frequencymeter PORT MAP(
		Data_in => entree, 
		clk => clk, 
		rst => rst, 
		Data_out => freq
   );
   
   UUT1: afficheur PORT MAP( 
           clk => clk, 
           rst => rst, 
           frequence => freq,
           point => dp,
           calibre => cali,
           selecteur => AN,
           segments => BCD
      );

-- *** Test Bench - User Defined Section ***
   clock_process : PROCESS
   BEGIN
	
	clk <= '0' ;
	wait for 5 ns ;
	clk <= '1' ;
	wait for 5 ns;

   END PROCESS;
	
	
	init_process : PROCESS
   BEGIN
	
	rst <= '0';
	wait for 30 ns;
	rst <= '1';
	wait ;
	
   END PROCESS;
	
	gene_process : PROCESS
   BEGIN
	
	entree <= '0' ;
	wait for 0.3 ms ;
	entree <= '1' ;
	wait for 0.2 ms;

   END PROCESS;
-- *** End Test Bench - User Defined Section ***


end Behavioral;
