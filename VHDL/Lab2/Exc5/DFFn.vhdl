LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY DFFn IS
	PORT (
		DClk, Din : IN STD_LOGIC;
		DQ : OUT STD_LOGIC
	);
END DFFn;

ARCHITECTURE Structural OF DFFn IS
BEGIN
	PROCESS (DClk)
    BEGIN
        IF rising_edge(DClk) THEN
            DQ <= Din;
        END IF;
    END PROCESS;
END Structural;
