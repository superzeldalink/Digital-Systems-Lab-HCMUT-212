LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc4_tb IS
END ENTITY;

ARCHITECTURE sim OF Exc4_tb IS

    -- We're slowing down the clock to speed up simulation time
    CONSTANT ClockFrequencyHz : INTEGER := 10; -- 10 Hz
    CONSTANT ClockPeriod : TIME := 1000 ms / ClockFrequencyHz;

    SIGNAL Clk : STD_LOGIC := '1';
    SIGNAL nRst : STD_LOGIC := '1';
    SIGNAL clkout : STD_LOGIC;

BEGIN

    -- The Device Under Test (DUT)
    i_Timer : ENTITY work.Exc4(rtl)
        GENERIC MAP(rate => 10) 
        PORT MAP(
            Clk => Clk,
            nRst => nRst,
            clkout => clkout);

    -- Process for generating the clock
    Clk <= NOT Clk AFTER ClockPeriod / 2;

END ARCHITECTURE;