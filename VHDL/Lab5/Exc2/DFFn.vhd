LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY DFFn IS
    PORT (
        D, clk, rst, en : IN STD_LOGIC;
        Q : OUT STD_LOGIC);
END DFFn;
ARCHITECTURE Behavior OF DFFn IS
BEGIN
    PROCESS (rst, clk, en)
    BEGIN
        IF rising_edge(clk) AND en = '1' THEN
            Q <= D;
        END IF;
        IF rst = '1' THEN
            Q <= '0';
        END IF;
    END PROCESS;
END Behavior;