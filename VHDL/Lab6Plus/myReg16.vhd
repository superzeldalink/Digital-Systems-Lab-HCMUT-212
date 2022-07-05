LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY myReg16 IS
    PORT (
        clk, rst, en : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END myReg16;

ARCHITECTURE arch OF myReg16 IS
    COMPONENT DFFn IS
        PORT (
            D, clk, rst, en : IN STD_LOGIC;
            Q : OUT STD_LOGIC);
    END COMPONENT;
BEGIN
    gen : FOR i IN 15 DOWNTO 0 GENERATE
        DFFs : DFFn PORT MAP(D(i), clk, rst, en, Q(i));
    END GENERATE;
END ARCHITECTURE;
