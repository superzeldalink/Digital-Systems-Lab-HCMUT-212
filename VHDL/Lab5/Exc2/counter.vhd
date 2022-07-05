LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY counter IS
    PORT (
        clk, rstN, en : IN STD_LOGIC;
        cout : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        run, done : BUFFER STD_LOGIC
    );
END counter;

ARCHITECTURE arch OF counter IS
    SIGNAL rst : STD_LOGIC;
    SIGNAL Q, Qb : STD_LOGIC_VECTOR(4 DOWNTO 0);

    COMPONENT DFFn IS
        PORT (
            D, clk, rst, en : IN STD_LOGIC;
            Q : OUT STD_LOGIC);
    END COMPONENT;
BEGIN
    Qb <= NOT(Q);
    rst <= NOT(rstN);
    cout <= Q;
    DFF0 : DFFn PORT MAP(Qb(0), clk, rst, Q(0));
    gen : FOR i IN 1 TO 4 GENERATE
        DFFs : DFFn PORT MAP(Qb(i), Qb(i - 1), rst, en, Q(i));
    END GENERATE;

END ARCHITECTURE;