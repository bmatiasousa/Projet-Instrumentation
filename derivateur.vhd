----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2021 12:31:05
-- Design Name: 
-- Module Name: Derivateur - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity derivation is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enable: in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           data_out : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           Spulse: out STD_LOGIC);
           
end derivation;

architecture Behavioral of derivation is


signal Sout1,in_aux: signed(8 DOWNTO 0);
signal S_aux1: signed (11 downto 0);
signal S_aux2: signed (8 downto 0);
signal k: signed (2 downto 0);
signal threshold: signed(19 downto 0):=to_signed(50,20);

begin

k <= "100"; -- 8
in_aux <= signed('0' & data_in);

derivateur: process(rst, clk)
begin
    if rst='1' then
        Sout1 <= (others => '0');
        S_aux1 <= (others => '0');
    elsif rising_edge(clk) then
        if enable = '1' then
            S_aux1 <= (in_aux-Sout1)*k;
            Sout1 <= in_aux;
            if (Sout1 < threshold) then
                Spulse <= '1';
            else
                Spulse <= '0';
            end if;
        end if;
    end if;
end process;

S_aux2 <= S_aux1(11 downto 3) + "010000000";
data_out <= std_logic_vector(S_aux2(7 downto 0));

end Behavioral;
