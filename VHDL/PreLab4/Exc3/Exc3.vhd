LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc3 IS
    PORT (
        clk, inp, rst : IN STD_LOGIC;
        L : OUT STD_LOGIC_VECTOR(0 TO 3)
    );
END Exc3;

ARCHITECTURE arch OF Exc3 IS
    SIGNAL q : STD_LOGIC_VECTOR(0 TO 3);
    COMPONENT DFFn IS
        PORT (
            Din, DClk, DprsN, DclrN, Den : IN STD_LOGIC; -- clr and prs are active low.
            DQ : OUT STD_LOGIC);
    END COMPONENT;
BEGIN
    DFF0 : DFFn PORT MAP(Din => inp, DClk => clk, DprsN => '1', DclrN => rst, Den => '1', DQ => q(0));
    gen : FOR i IN 1 TO 3 GENERATE
        DFFs : DFFn PORT MAP(Din => q(i-1), DClk => clk, DprsN => '1', DclrN => rst, Den => '1', DQ => q(i));
    END GENERATE;
    L <= q;
END ARCHITECTURE;