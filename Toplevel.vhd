----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2021 14:28:21
-- Design Name: 
-- Module Name: ADC - Behavioral
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

entity Toplevel is
    Port ( Sortie: out std_logic_vector(6 downto 0);
           AN: out std_logic_vector(3 downto 0);
           dp: out std_logic;
           --pulse:out std_logic; 
           rst: in std_logic;
           clk: in std_logic;
           vauxp3 : in  STD_LOGIC;
           vauxn3 : in  STD_LOGIC);
end Toplevel;

architecture Behavioral of TopLevel is

component temp1u is
    Port ( clkIn : in STD_LOGIC;
           clkOut : out STD_LOGIC);
end component;

component xadc_wiz_0 is
   port
   (
    daddr_in        : in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
    den_in          : in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
    di_in           : in  STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
    dwe_in          : in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
    do_out          : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
    drdy_out        : out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
    dclk_in         : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
    reset_in        : in  STD_LOGIC;                         -- Reset signal for the System Monitor control logic
    convst_in       : in  STD_LOGIC;                         -- Convert Start Input
    vauxp3          : in  STD_LOGIC;                         -- Auxiliary Channel 3
    vauxn3          : in  STD_LOGIC;
    busy_out        : out  STD_LOGIC;                        -- ADC Busy signal
    channel_out     : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
    eoc_out         : out  STD_LOGIC;                        -- End of Conversion Signal
    eos_out         : out  STD_LOGIC;                        -- End of Sequence Signal
    ot_out          : out  STD_LOGIC;                        -- Over-Temperature alarm output
    vccaux_alarm_out : out  STD_LOGIC;                        -- VCCAUX-sensor alarm output
    vccint_alarm_out : out  STD_LOGIC;                        -- VCCINT-sensor alarm output
    user_temp_alarm_out : out  STD_LOGIC;                        -- Temperature-sensor alarm output
    alarm_out       : out STD_LOGIC;                         -- OR'ed output of all the Alarms
    vp_in           : in  STD_LOGIC;                         -- Dedicated Analog Input Pair
    vn_in           : in  STD_LOGIC
);
end component;


component filter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enable: in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR(11 DOWNTO 0);
           data_out : out STD_LOGIC_VECTOR(7 DOWNTO 0));
end component;

component derivation is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enable: in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           data_out : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           Spulse: out STD_LOGIC);
end component;

component frequencymeter is
    Port ( clk : in  STD_LOGIC;
           rst : in STD_LOGIC;
           Data_in: in STD_LOGIC;  
           Data_out : out STD_LOGIC_VECTOR(23 DOWNTO 0));
end component;

component afficheur is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           frequence: in STD_LOGIC_VECTOR(23 downto 0);
           point: out STD_LOGIC;
           calibre: out STD_LOGIC_VECTOR(2 downto 0);
           selecteur: out STD_LOGIC_VECTOR(3 downto 0);
           segments: out STD_LOGIC_VECTOR(6 downto 0));
end component;


signal outTemp: STD_LOGIC;
signal inputE : STD_LOGIC_VECTOR (15 DOWNTO 0);
signal sortieFiltre : STD_LOGIC_VECTOR (7 DOWNTO 0);
signal sortieDerivateur : STD_LOGIC_VECTOR (7 DOWNTO 0);
signal derivateurPulse : STD_LOGIC;
signal sortieFreq : STD_LOGIC_VECTOR (23 DOWNTO 0);
--signal outXADC : STD_LOGIC_VECTOR (15 DOWNTO 0);




begin



-- Port Map    
Tempo1u: temp1u PORT MAP(
    clkIn => clk,
    clkOut => outTemp);
    
    
    
XADC : xadc_wiz_0 PORT MAP(
    daddr_in => "0010011",              -- Address bus for the dynamic reconfiguration port
    den_in  => '1',                         -- Enable Signal for the dynamic reconfiguration port
    di_in  => X"0000",    -- Input data bus for the dynamic reconfiguration port
    dwe_in  => '0',                         -- Write Enable for the dynamic reconfiguration port
    do_out => inputE,   -- Output data bus for dynamic reconfiguration port
    drdy_out => open,
    dclk_in => clk,                         -- Clock input for the dynamic reconfiguration port
    reset_in => rst,                      -- Reset signal for the System Monitor control logic
    convst_in => outTemp,                         -- Convert Start Input
    vauxp3 => vauxp3,                         -- Auxiliary Channel 3
    vauxn3 => vauxn3,
    busy_out => open,
    channel_out => open,
    eoc_out => open, 
    eos_out => open,
    ot_out => open,
    vccaux_alarm_out => open,
    vccint_alarm_out => open,
    user_temp_alarm_out => open,
    alarm_out => open,
    vp_in => '0',                         -- Dedicated Analog Input Pair
    vn_in => '0'
);

filtre : filter PORT MAP(
    clk => clk,
    rst => rst,
    enable => outTemp,
    data_in => inputE(15 downto 4),
    data_out => sortieFiltre);

derivateur : derivation PORT MAP(
    clk => clk,
    rst => rst,
    enable => outTemp,
    data_in => sortieFiltre,
    data_out => sortieDerivateur,
    Spulse => derivateurPulse);

frequencymeter1  : frequencymeter  PORT MAP(
    clk => clk,
    rst => rst,
    Data_in => derivateurPulse,
    Data_out => sortieFreq);


afficheur1  : afficheur  PORT MAP(
    clk => clk,
    rst => rst,
    frequence => sortieFreq,
    point => dp,
    selecteur => AN,
    segments => Sortie);

--Sortie <= sortieFiltre; 
--Sortie <= sortieDerivateur;



end Behavioral;
