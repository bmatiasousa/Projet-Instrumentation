----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2022 20:29:54
-- Design Name: 
-- Module Name: compteurClock - Behavioral
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

entity compteurClock is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           front_signal : in  STD_LOGIC;
           periode : out  STD_LOGIC_VECTOR (27 downto 0));
end compteurClock;

architecture Behavioral of compteurClock is
type etat is (init, mesure1, mesure2, validation, nouvelleMesure);
signal etatf : etat; --etat futur
signal etatp : etat; --etat present

signal compteur1  : STD_LOGIC_VECTOR (27 downto 0);
signal compteur2  : STD_LOGIC_VECTOR (27 downto 0);

begin

--Bloc F
process(etatp, rst, front_signal)
begin
	if rst='0' then etatf <=init ;
	else	
		case etatp is 
		when init => 
			if(front_signal = '0') then etatf <= init;
			else etatf <= mesure1;
			end if;
		when mesure1 => 
             if(front_signal = '1') then etatf <= mesure1;    
             else etatf <= mesure2 ;
             end if;				
		when mesure2 => 
			if(front_signal = '0') then etatf <= mesure2;	
			else etatf <= validation ;
			end if;
		
		when validation => etatf <= nouvelleMesure;
		
		when nouvelleMesure => etatf <= mesure1;
		
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
	
	when init => compteur1 <= X"0000000"; compteur2 <= X"0000000" ;
	when mesure1 => compteur1 <= compteur1 + 1;
	when mesure2 => compteur2 <= compteur2 + 1;
	when validation => periode <= compteur1 + compteur2;
	when nouvelleMesure => compteur1 <= X"0000001";  compteur2 <= X"0000001";
	when others => 
	end case;
	
end if;	

end process;

end Behavioral;