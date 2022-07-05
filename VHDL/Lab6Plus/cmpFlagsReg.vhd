LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY cmpFlagsReg IS
    PORT (
        clk, rst, en, carry : IN STD_LOGIC;
        legFlag : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END cmpFlagsReg;

ARCHITECTURE arch OF cmpFlagsReg IS
    SIGNAL cmpFlags : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    cmpFlags <= legFlag & carry;

    PROCESS (clk)
    BEGIN
        IF rst = '1' THEN
            Q <= "0000";
        ELSIF rising_edge(clk) AND en = '1' THEN
            Q <= cmpFlags;
        END IF;
    END PROCESS;
END ARCHITECTURE;
