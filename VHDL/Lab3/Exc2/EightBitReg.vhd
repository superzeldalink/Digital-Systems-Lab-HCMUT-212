LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY EightBitReg IS
    PORT (
        EBRClk, EBRrst : IN STD_LOGIC;
        EBRD : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        EBRQ : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
    );
END EightBitReg;

ARCHITECTURE arch OF EightBitReg IS
    COMPONENT DFFn IS
        PORT (
            Din, DClk, Drst : IN STD_LOGIC;
            DQ : OUT STD_LOGIC);
    END COMPONENT;
BEGIN
    gen : FOR i IN 8 DOWNTO 0 GENERATE
        DFFs : DFFn PORT MAP(Din => EBRD(i), DClk => EBRClk, Drst => EBRrst, DQ => EBRQ(i));
    END GENERATE;
END ARCHITECTURE;