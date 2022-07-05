LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY cmp IS
    PORT (
        clk, rst, en : IN STD_LOGIC;
        A, B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END cmp;

ARCHITECTURE arch OF cmp IS
    SIGNAL flags : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
    flags <=
        "010" WHEN signed(A) = signed(B) ELSE
        "001" WHEN signed(A) > signed(B) ELSE
        "100" WHEN signed(A) < signed(B);

    PROCESS (clk)
    BEGIN
        IF rst = '1' THEN
            Q <= "000";
        ELSIF rising_edge(clk) AND en = '1' THEN
            Q <= flags;
        END IF;
    END PROCESS;
END ARCHITECTURE;