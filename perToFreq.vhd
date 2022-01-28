----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2022 20:31:54
-- Design Name: 
-- Module Name: perToFreq - Behavioral
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

entity perToFreq is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           periode : in  STD_LOGIC_VECTOR (27 downto 0);
           frequence : out  STD_LOGIC_VECTOR (23 downto 0));
end perToFreq;

architecture Behavioral of perToFreq is
type etat is (init, incremente, mini, test, validation);

signal etatf : etat; --etat futur
signal etatp : etat; --etat present

signal compteur  : STD_LOGIC_VECTOR (23 downto 0);
signal temp  : STD_LOGIC_VECTOR (27 downto 0);


begin

--Bloc F
process(etatp, rst, temp, periode)
begin
	if rst='0' then etatf <= init ;
	else	
		case etatp is 
		when init => etatf <= mini;
		
		when mini =>
			if(periode >= X"00061A8") then etatf <= test; -- ne pas diviser par des nombres trop petits.
			else etatf <= init;
			end if;
			
		when test =>
			if(temp > X"5F5E100") then etatf <= validation;
			else etatf <= incremente;
			end if;

		when incremente => etatf <= test ;
		
		when validation  => etatf <= init;
			
		
		end case;	
	end if;
end process;

--Bloc M
process(clk)
begin
	if (clk'event and clk = '1') then etatp <= etatf ;
	end if;
end process;

--Bloc G
process(clk)
begin
if(clk'event and clk='1') then

	case etatp is
	when init => temp <= (others=>'0'); compteur <= X"000000" ;
	when incremente => temp <= temp + (periode); compteur <= compteur + 1;
	when validation => frequence <= compteur;
	when others => 

	end case;
	
end if;	
end process;

end Behavioral;
