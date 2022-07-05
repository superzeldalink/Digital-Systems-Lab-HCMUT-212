LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY DFFn IS
    PORT (
        Din, DClk, Drst : IN STD_LOGIC;
        DQ : OUT STD_LOGIC);
END DFFn;
ARCHITECTURE Behavior OF DFFn IS
BEGIN
    PROCESS (Drst, DClk)
    BEGIN
        IF rising_edge(DClk) THEN
            DQ <= Din;
        END IF;
		  IF Drst = '1' THEN
				DQ <= '0';
		  END IF;
    END PROCESS;
END Behavior;