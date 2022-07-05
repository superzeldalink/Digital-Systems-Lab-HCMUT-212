LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY PCReg IS
    PORT (
        clk, rst, en, incr : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        Q : BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0)
    );
END PCReg;

ARCHITECTURE arch OF PCReg IS
BEGIN
    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            Q <= (OTHERS => '0');
        ELSE
            IF rising_edge(clk) THEN
                IF incr = '1' THEN
                    Q <= STD_LOGIC_VECTOR(UNSIGNED(Q) + 1);
                ELSIF en = '1' THEN
                    Q <= D;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;