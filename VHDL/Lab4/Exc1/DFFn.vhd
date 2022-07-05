LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY DFFn IS
    PORT (
        Din, DClk, Dprs, Dclr, Den : IN STD_LOGIC;
        DQ : OUT STD_LOGIC);
END DFFn;
ARCHITECTURE Behavior OF DFFn IS
BEGIN
    PROCESS (Dprs, Dclr, DClk, Den)
    BEGIN
		  IF Dclr = '1' AND Dprs = '0' THEN
            DQ <= '0';
        ELSIF Dclr = '0' AND Dprs = '1' THEN
				DQ <= '1';
		  ELSE
        IF rising_edge(DClk) and Den = '1' THEN
            DQ <= Din;
        END IF;
		  END IF;
    END PROCESS;
END Behavior;