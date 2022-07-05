LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc1 IS
    PORT (
        R0out, R1out, Aout, Gout, IRout : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
        DIN : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        rstN, clk, run : IN STD_LOGIC;
        done : BUFFER STD_LOGIC;
        BusWires : BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0)
    );
END Exc1;

ARCHITECTURE Behavior OF Exc1 IS
    -- MISC
    SIGNAL addOrSub : STD_LOGIC;

    -- REGISTERS, A, G, IR
    SIGNAL regin : STD_LOGIC_VECTOR(0 TO 7);
    SIGNAL A, G, Gt : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL ain, gin, IRin, rst : STD_LOGIC;
    SIGNAL R0, R1, R2, R3, R4, R5, R6, R7, IR : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL sel : INTEGER RANGE 0 TO 10;

    COMPONENT myReg IS
        PORT (
            clk, rst, en : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT AddSub IS
        PORT (
            SIGNAL A, B : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            SIGNAL sel : IN STD_LOGIC;
            SIGNAL C : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    R0out <= R0;
    R1out <= R1;
	 Aout <= A;
	 Gout <= G;
	 IRout <= IR;

    rst <= NOT(rstN);
    -- ADDSUB
    as : AddSub PORT MAP(A, BusWires, addOrSub, Gt);

    -- REGS
    reg0 : myReg PORT MAP(clk, rst, regin(0), BusWires, R0);
    reg1 : myReg PORT MAP(clk, rst, regin(1), BusWires, R1);
    reg2 : myReg PORT MAP(clk, rst, regin(2), BusWires, R2);
    reg3 : myReg PORT MAP(clk, rst, regin(3), BusWires, R3);
    reg4 : myReg PORT MAP(clk, rst, regin(4), BusWires, R4);
    reg5 : myReg PORT MAP(clk, rst, regin(5), BusWires, R5);
    reg6 : myReg PORT MAP(clk, rst, regin(6), BusWires, R6);
    reg7 : myReg PORT MAP(clk, rst, regin(7), BusWires, R7);
    Areg : myReg PORT MAP(clk, rst, ain, BusWires, A);
    Greg : myReg PORT MAP(clk, rst, Gin, Gt, G);
    IRreg : myReg PORT MAP(clk, rst, IRin, DIN, IR);

    -- MUX
	 regMUX0 : ENTITY work.RegMUX PORT MAP(R0, R1, R2, R3, R4, R5, R6, R7, G, DIN, sel, BusWires);

    -- FSM
	 ControlUnit : ENTITY work.ctrlUnitFSM PORT MAP(regin, ain, gin, IRin, addorsub, IR, sel, run, rst, clk, done);

END ARCHITECTURE;