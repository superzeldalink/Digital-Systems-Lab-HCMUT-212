LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY addrReg IS
    PORT (
        clk, rst, en : IN STD_LOGIC;
        addrsel : IN INTEGER RANGE 0 TO 2;
        PC : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        H, L, D : STD_LOGIC_VECTOR(7 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END addrReg;

ARCHITECTURE arch OF addrReg IS
    SIGNAL addr : STD_LOGIC_VECTOR(15 DOWNTO 0);
    COMPONENT myReg IS
        PORT (
            clk, rst, en : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    addr <= "00000000" & D WHEN addrsel = 0 ELSE
        H & L WHEN addrsel = 1 ELSE
        PC;
    myReg1 : myReg PORT MAP(clk, rst, en, addr(15 DOWNTO 8), Q(15 DOWNTO 8));
    myReg0 : myReg PORT MAP(clk, rst, en, addr(7 DOWNTO 0), Q(7 DOWNTO 0));
END ARCHITECTURE;