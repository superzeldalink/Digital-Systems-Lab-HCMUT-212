LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY FourBitShiftReg IS
    PORT (
        SRegclk, SReginp, SRegrstN : IN STD_LOGIC;
        SRegL : OUT STD_LOGIC_VECTOR(0 TO 3)
    );
END FourBitShiftReg;

ARCHITECTURE arch OF FourBitShiftReg IS
    SIGNAL q : STD_LOGIC_VECTOR(0 TO 3) := "XXXX";
    COMPONENT DFFn IS
        PORT (
            Din, DClk, DprsN, DclrN, Den : IN STD_LOGIC; -- clr and prs are active low.
            DQ : OUT STD_LOGIC);
    END COMPONENT;
BEGIN
    DFF0 : DFFn PORT MAP(Din => SReginp, DClk => SRegclk, DprsN => '1', DclrN => SRegrstN, Den => '1', DQ => q(0));
    gen : FOR i IN 1 TO 3 GENERATE
        DFFs : DFFn PORT MAP(Din => q(i-1), DClk => SRegclk, DprsN => '1', DclrN => SRegrstN, Den => '1', DQ => q(i));
    END GENERATE;
    SRegL <= q;
END ARCHITECTURE;