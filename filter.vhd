----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2021 11:39:59
-- Design Name: 
-- Module Name: filtre - Behavioral
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

entity filter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enable: in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR(11 DOWNTO 0);
           data_out : out STD_LOGIC_VECTOR(7 DOWNTO 0));
end filter;

architecture Behavioral of filter is

signal S_out1, S_out2, x_aux: signed(25 DOWNTO 0);
signal k: signed(25 downto 0);
signal S_aux1:  signed(51 downto 0);
signal S_aux2:  signed(12 downto 0);


begin


x_aux <= (signed('0' & data_in)&"0000000000000");
k <= "0000000000000"&"1111000011100"; -- 0.94091796875
S_out2 <= S_aux1(38 downto 13);

data_out <=std_logic_vector(S_aux2(11 downto 4));
S_aux2 <= "0100000000000" + S_aux1(38 downto 26);


process(rst, clk)
begin
    if rst='1' then
        S_out1 <= (others => '0');
        S_aux1 <= (others => '0');
    elsif rising_edge (clk) then
        if enable='1' then
            S_out1 <= x_aux;
            S_aux1 <= k*(x_aux + S_out2 - S_out1);
        end if;
    end if;
end process;




end Behavioral;
