----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2021 14:47:05
-- Design Name: 
-- Module Name: temp1u - Behavioral
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

entity temp1u is
    Port ( clkIn : in STD_LOGIC;
           clkOut : out STD_LOGIC);
end temp1u;

architecture Behavioral of temp1u is

signal count : integer:= 0;  
constant value_1kHZ_c : natural := 100; --internal clock 100MHz to 1MHz

begin
-- process for increment 1u sec clock
process(clkIn)
	begin
	   if rising_edge(clkIn) then
	       if count = value_1kHZ_c - 1 then
	           count <= 0;
	           clkOut <= '1';  
		   else 
		      count <= count + 1;
		      clkOut <= '0';
		   end if;
		end if;
	end process;
end Behavioral;
