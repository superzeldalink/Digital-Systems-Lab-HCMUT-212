LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY regMUX IS
    PORT (
        SIGNAL R0, R1, R2, R3, R4, R5, R6, R7 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        SIGNAL g, DIN : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        SIGNAL sel : IN INTEGER RANGE 0 TO 10;
        SIGNAL MUXout : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
    );
END regMUX;

ARCHITECTURE arch OF regMUX IS
BEGIN
    WITH sel SELECT
        MUXout <=
        R0 WHEN 0,
        R1 WHEN 1,
        R2 WHEN 2,
        R3 WHEN 3,
        R4 WHEN 4,
        R5 WHEN 5,
        R6 WHEN 6,
        R7 WHEN 7,
        g WHEN 8,
        DIN WHEN 9,
        "000000000" WHEN 10;
END ARCHITECTURE;