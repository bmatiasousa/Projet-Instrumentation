----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2022 21:32:23
-- Design Name: 
-- Module Name: decodeur - Behavioral
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

entity decodeur is
    Port ( valeur : in  STD_LOGIC_VECTOR (3 downto 0);
		   sortie : out STD_LOGIC_VECTOR (6 downto 0));
end decodeur;

architecture Behavioral of decodeur is

begin
process (valeur)
begin
	if(valeur = X"0") then sortie <= "1000000";
	elsif(valeur = X"1") then sortie <= "1111001";
	elsif(valeur = X"2") then sortie <= "0100100";
	elsif(valeur = X"3") then sortie <= "0110000";
	elsif(valeur = X"4") then sortie <= "0011001";
	elsif(valeur = X"5") then sortie <= "0010010";
	elsif(valeur = X"6") then sortie <= "0000010";
	elsif(valeur = X"7") then sortie <= "1111000";
	elsif(valeur = X"8") then sortie <= "0000000";
	elsif(valeur = X"9") then sortie <= "0010000";
	else sortie <= "0000110";

	end if;
end process;
end Behavioral;
