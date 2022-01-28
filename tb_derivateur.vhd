----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2021 17:05:24
-- Design Name: 
-- Module Name: tb_deriv - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_derivation is
--  Port ( );
end tb_derivation;

architecture Behavioral of tb_derivation is

signal in_deriv: STD_LOGIC_VECTOR(7 downto 0);
signal clock: STD_LOGIC:='0';
signal clockS: STD_LOGIC:='0';
signal reset: STD_LOGIC;
signal out_deriv: STD_LOGIC_VECTOR(7 downto 0);
signal output_temp: STD_LOGIC;
signal  count: UNSIGNED (7 downto 0);
constant clk_period : time := 10 ns;
constant clk_periodsinal : time := 1 us;

component derivation is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enable: in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           data_out : out STD_LOGIC_VECTOR(7 DOWNTO 0));
end component;

component temp1u is
    Port ( clkIn : in STD_LOGIC;
           clkOut : out STD_LOGIC);
end component;

begin

temp: temp1u PORT MAP(
    clkIn => clock,
    clkOut => output_temp
);

deriv: derivation PORT MAP (
    clk => clock,
    rst => reset,
    enable => output_temp,
    data_in => in_deriv,
    data_out => out_deriv
);

clk_process: process
begin
    clock <= '0';
    wait for clk_period/2;
    clock <= '1';
    wait for clk_period/2;
end process;

clksinal_process: process
begin
    clockS <= '0';
    wait for clk_periodsinal/2;
    clockS <= '1';
    wait for clk_periodsinal/2;
end process;

reset <= '1' , '0' after 50ns;

input_process: process(reset, clockS, output_temp)
    begin
        if reset='1' then
            count <= (others=>'0');
        elsif (clockS'event and clockS='1') then
                if count = "11111111" then 
                    count <= (others=>'0');                    
                else
                    count <= count + 1 ;                    
                end if;
        end if;
    in_deriv <= STD_LOGIC_VECTOR(count);
    end process;
end Behavioral;
