LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY CD IS
    GENERIC (rate : INTEGER := 781250); -- rate = oldFreq / newFreq
    PORT (
        Clk : IN STD_LOGIC;
        clkout : OUT STD_LOGIC;
        nRst : IN STD_LOGIC -- Negative reset
    );
END ENTITY;

ARCHITECTURE rtl OF CD IS
    -- Signal for counting clock periods
    SIGNAL Ticks : INTEGER := 0;
    SIGNAL clkt : STD_LOGIC := '0';

BEGIN
    clkout <= clkt;
    PROCESS (Clk) IS
    BEGIN
        IF rising_edge(Clk) THEN
            -- If the negative reset signal is active
            IF nRst = '0' THEN
                Ticks <= 0;
            ELSE
                IF Ticks = (rate / 2) - 1 THEN
                    Ticks <= 0;
                    clkt <= NOT (clkt);
                ELSE
                    Ticks <= Ticks + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE;