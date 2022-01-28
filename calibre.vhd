----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2022 21:04:14
-- Design Name: 
-- Module Name: calibre - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity trouverCalibre is
    Port ( 
		   frequence : in  STD_LOGIC_VECTOR (23 downto 0);
		   clk : in STD_LOGIC;
		   rst : in STD_LOGIC;
           puissance : out  STD_LOGIC_VECTOR (2 downto 0);
           position_point : out  STD_LOGIC_VECTOR (1 downto 0);
           calibre : out  STD_LOGIC_VECTOR (2 downto 0));
end trouverCalibre;

architecture Behavioral of trouverCalibre is

begin

--Bloc F
process(clk)
begin
	if(clk'event and clk='1') then 
		if(rst='0') then position_point<= "00"; calibre <= "000"; puissance <= "000";
		end if;
				if(frequence >= X"989680") then position_point<= "00"; calibre <= "111"; --erreur
				elsif(frequence >= X"0F4240") then position_point<= "11"; calibre <= "010"; puissance <= "110";  --KHz
				elsif(frequence >= X"0186A0") then position_point<= "01"; calibre <= "001"; puissance <= "101";--Hz
				elsif(frequence >= X"002710") then position_point<= "10"; calibre <= "001"; puissance <= "100";
				elsif(frequence >= X"0003E8") then position_point<= "11"; calibre <= "001"; puissance <= "011";
				else position_point<= "00"; calibre <= "111"; --erreur
				end if;	
	end if;
end process;

end Behavioral;