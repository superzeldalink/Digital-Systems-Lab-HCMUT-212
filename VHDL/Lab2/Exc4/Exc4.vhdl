LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Exc4 IS
    PORT (
        D, Clk : IN STD_LOGIC;
        Q : OUT STD_LOGIC
    );
END Exc4;

ARCHITECTURE arch OF Exc4 IS
    SIGNAL Qm : STD_LOGIC;
    COMPONENT DFFn IS
        PORT (
            DClk, Din : IN STD_LOGIC;
            DQ : OUT STD_LOGIC
        );
    END COMPONENT;
BEGIN
    DFF1 : DFFn PORT MAP(DClk => NOT(Clk), Din => D, DQ => Qm);
    DFF0 : DFFn PORT MAP(DClk => Clk, Din => Qm, DQ => Q);
END ARCHITECTURE;