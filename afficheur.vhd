----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2022 21:33:50
-- Design Name: 
-- Module Name: afficheur - Behavioral
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

entity afficheur is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           frequence: in STD_LOGIC_VECTOR(23 downto 0);
           point: out STD_LOGIC;
           calibre: out STD_LOGIC_VECTOR(2 downto 0);
           selecteur: out STD_LOGIC_VECTOR(3 downto 0);
           segments: out STD_LOGIC_VECTOR(6 downto 0));
end afficheur;

architecture Behavioral of afficheur is

component trouverCalibre is
    Port ( frequence : in  STD_LOGIC_VECTOR (23 downto 0);
		   clk : in STD_LOGIC;
		   rst : in STD_LOGIC;
           puissance : out  STD_LOGIC_VECTOR (2 downto 0);
           position_point : out  STD_LOGIC_VECTOR (1 downto 0);
           calibre : out  STD_LOGIC_VECTOR (2 downto 0));
end component;

component trouverDigits is
    Port ( frequence : in  STD_LOGIC_VECTOR (23 downto 0);
           puissance : in  STD_LOGIC_VECTOR (2 downto 0);
           position_point : in  STD_LOGIC_VECTOR (1 downto 0);
           digit : out  STD_LOGIC_VECTOR (3 downto 0);
		   point_on : out STD_LOGIC;
		   clk : in STD_LOGIC;
		   rst : in STD_LOGIC;
           selecteur : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component decodeur is
    Port ( valeur : in  STD_LOGIC_VECTOR (3 downto 0);
		   sortie : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal puiss : STD_LOGIC_VECTOR (2 downto 0);
signal positionPt: STD_LOGIC_VECTOR (1 downto 0);
signal abcd: STD_LOGIC_VECTOR (3 downto 0);

begin

-- Port Map    
Calibre1: trouverCalibre PORT MAP(
    frequence => frequence,
    clk => clk,
    rst => rst,
    puissance => puiss,
    position_point => positionPt,
    calibre => calibre);
    
    
Tdigits: trouverDigits PORT MAP(
        frequence => frequence,
        puissance => puiss,
        position_point => positionPt,
        digit => abcd,
        point_on => point,
        clk => clk,
        rst => rst,
        selecteur => selecteur);
        
BCD: decodeur PORT MAP(
          valeur => abcd,
          sortie => segments);

end Behavioral;
