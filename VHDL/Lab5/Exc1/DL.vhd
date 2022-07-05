LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY DL IS
    PORT (
        D, clk, rst, en : IN STD_LOGIC;
        Q : OUT STD_LOGIC);
END DL;
ARCHITECTURE Behavior OF DL IS
BEGIN
    PROCESS (rst, clk, en)
    BEGIN
        IF rst = '1' THEN
            Q <= '0';
        ELSIF clk = '1' AND en = '1' THEN
            Q <= D;
        END IF;
    END PROCESS;
END Behavior;