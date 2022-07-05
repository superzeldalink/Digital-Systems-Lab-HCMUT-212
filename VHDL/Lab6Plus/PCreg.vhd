LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY PCReg IS
    PORT (
        clk, rst, en, incr, mode : IN STD_LOGIC;
        H, L, D : STD_LOGIC_VECTOR(7 DOWNTO 0);
        Q : BUFFER STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END PCReg;

ARCHITECTURE arch OF PCReg IS
    SIGNAL addr : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
    addr <= "00000000" & D WHEN mode = '0' ELSE
        H & L;
    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            Q <= (OTHERS => '0');
        ELSE
            IF rising_edge(clk) THEN
                IF incr = '1' THEN
                    Q <= STD_LOGIC_VECTOR(unsigned(Q) + 1);
                ELSIF en = '1' THEN
                    Q <= addr;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;