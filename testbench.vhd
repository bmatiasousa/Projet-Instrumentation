----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2021 16:35:48
-- Design Name: 
-- Module Name: tb_filtre - Behavioral
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

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is


component filter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enable: in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR(11 DOWNTO 0);
           data_out : out STD_LOGIC_VECTOR(7 DOWNTO 0));
end component;

component temp1u is
    Port ( clkIn : in STD_LOGIC;
           clkOut : out STD_LOGIC);
end component;

signal din: STD_LOGIC_VECTOR(11 downto 0);
signal clock: STD_LOGIC:='0';
signal reset: STD_LOGIC;
signal output_filtre: STD_LOGIC_VECTOR(7 downto 0);
signal output_temp : STD_LOGIC;
  
constant clk_period : time := 20 ns;
constant x_period : time := 1 ms;

begin

filtre:filter PORT MAP(

    clk  => clock,
    rst => reset,
    enable => output_temp,
    data_in => din,
    data_out  => output_filtre
);

temp: temp1u PORT MAP(
    clkIn => clock,
    clkOut => output_temp
);

clk_process: process
begin
    clock <= '0';
    wait for clk_period/2;
    clock <= '1';
    wait for clk_period/2;
end process;


reset <= '1' , '0' after 50ns;

x_k_process :process
   begin
		din <= "000000000000";
		wait for x_period/2;
		din <= "111111111111";
		--wait for x_period/2;
		wait;
   end process;
end Behavioral;



