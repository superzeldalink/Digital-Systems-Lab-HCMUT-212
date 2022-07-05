LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY DL IS
    PORT (
        DLin, DLClk : IN STD_LOGIC;
        DLQ : OUT STD_LOGIC);
END DL;
ARCHITECTURE Behavior OF DL IS
BEGIN
    PROCESS (DLin, DLClk)
    BEGIN
        IF DLClk = '1' THEN
            DLQ <= DLin;
        END IF;
    END PROCESS;
END Behavior;
