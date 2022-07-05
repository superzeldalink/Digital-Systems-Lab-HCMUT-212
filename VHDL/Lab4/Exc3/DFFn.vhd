LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY DFFn IS
    PORT (
        Din, DClk, DprsN, DclrN, Den : IN STD_LOGIC; -- clr and prs are active low.
        DQ : OUT STD_LOGIC);
END DFFn;
ARCHITECTURE Behavior OF DFFn IS
BEGIN
    PROCESS (DprsN, DclrN, DClk)
    BEGIN
        IF DclrN = '0' AND DprsN = '1' THEN
            DQ <= '0';
        ELSIF DclrN = '1' AND DprsN = '0' THEN
            DQ <= '1';
        ELSE
            IF rising_edge(DClk) AND Den = '1' THEN
                DQ <= Din;
            END IF;
        END IF;
    END PROCESS;
END Behavior;