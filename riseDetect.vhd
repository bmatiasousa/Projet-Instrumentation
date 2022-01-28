----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2022 20:25:20
-- Design Name: 
-- Module Name: riseDetect - Behavioral
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

entity riseDetect is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
	       entree : in STD_LOGIC;
           front : out  STD_LOGIC);
end riseDetect;

architecture Behavioral of riseDetect is

type etat is (init,passage0,passage1);
signal etatf : etat; --etat futur
signal etatp : etat; --etat present

begin
	process(rst, etatp,entree)
	begin
		if(rst='0') then etatf <= init;
		else
			case etatp is
			 when init => if(entree = '0') then etatf <= passage0;
				else etatf <= init;
				end if;
			 when passage0 => if(entree = '1') then etatf <= passage1;
				else etatf <= passage0;
				end if;
			 when passage1 => etatf <= init	;
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
	when init => front <= '0';
	when passage0 => front <= '0';
	when passage1 => front <= '1'; 
	end case;
end if;	
end process;
    
end Behavioral;