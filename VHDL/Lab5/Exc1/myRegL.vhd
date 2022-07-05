LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY myRegL IS
    PORT (
        clk, rst, en : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
    );
END myRegL;

ARCHITECTURE arch OF myRegL IS
    COMPONENT DL IS
        PORT (
            D, clk, rst, en : IN STD_LOGIC;
            Q : OUT STD_LOGIC);
    END COMPONENT;
BEGIN
    gen : FOR i IN 8 DOWNTO 0 GENERATE
        DLs : DL PORT MAP(D(i), clk, rst, en, Q(i));
    END GENERATE;
END ARCHITECTURE;