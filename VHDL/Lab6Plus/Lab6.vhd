LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Lab6 IS
    PORT (
        addrOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        dataROM : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        R0out, R1out, IRout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        SW : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        LED : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(0 TO 6);
        rstN, clkO : IN STD_LOGIC;
        BusWires : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
        flagsOut : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END Lab6;

ARCHITECTURE Behavior OF Lab6 IS
    -- MISC
    SIGNAL carry, carryFlag, done : STD_LOGIC;

    -- REGISTERS, A, G, IR
    SIGNAL regin : STD_LOGIC_VECTOR(0 TO 7);
    SIGNAL A, G, Gt, dout, devout : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ain, gin, IRin, IR2in, addrin, doutin, cmpin, carryin, PCin, G16in, PCmode, devoutin, rst, incr, W, clk : STD_LOGIC := '0';
    SIGNAL R0, R1, R2, R3, R4, R5, R6, R7, IR, IR2, data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL addr, PC, prod, G16, G16t : STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL devsel : STD_LOGIC_VECTOR(1 DOWNTO 0);

    SIGNAL legFlag : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL flags : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";

    SIGNAL sel : INTEGER RANGE 0 TO 13;
    SIGNAL addrsel : INTEGER RANGE 0 TO 2;
    SIGNAL MUX16sel : INTEGER RANGE 0 TO 1;
    SIGNAL alusel : NATURAL RANGE 0 TO 8;

    COMPONENT myReg IS
        PORT (
            clk, rst, en : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT PCReg IS
        PORT (
            clk, rst, en, incr, mode : IN STD_LOGIC;
            H, L, D : STD_LOGIC_VECTOR(7 DOWNTO 0);
            Q : BUFFER STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ctrlunitFSM IS
        PORT (
            SIGNAL rin : OUT STD_LOGIC_VECTOR(0 TO 7);
            SIGNAL ain, gin, IRin, IR2in, addrin, doutin, cmpin, carryin, PCin, G16in, devoutin, PCmode, incr : OUT STD_LOGIC;
            SIGNAL flags : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            SIGNAL IR, IR2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            SIGNAL addrsel : OUT INTEGER RANGE 0 TO 2;
            SIGNAL outsel : OUT INTEGER RANGE 0 TO 13;
            SIGNAL MUX16sel : OUT INTEGER RANGE 0 TO 1;
            SIGNAL alusel : OUT NATURAL RANGE 0 TO 8;
            SIGNAL devsel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            SIGNAL rst, clk : IN STD_LOGIC;
            SIGNAL done : BUFFER STD_LOGIC;
            SIGNAL W : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN

    -- DEBUG!
    R0out <= R0;
    R1out <= R1;
    IRout <= IR;
    flagsOut <= flags;
    addrOut <= addr;
    dataROM <= data;
	 
	 LED(9 DOWNTO 8) <= "00";

    
    -- MISC
    rst <= NOT(rstN);
    flags <= carryFlag & legFlag;

    -- ALU
    aluu : ENTITY work.ALU PORT MAP(A, BusWires, alusel, carry, Gt);

    -- MULTIPLIER
    mult : ENTITY work.mul PORT MAP(A, BusWires, prod);

    -- COMPARE
    compare : ENTITY work.cmp PORT MAP(clk, rst, cmpin, A, BusWires, legFlag);
    -- CARRY
    carrry : ENTITY work.DFFn PORT MAP(carry, clk, rst, carryin, carryFlag);

    -- REGS
    reg0 : myReg PORT MAP(clk, rst, regin(0), BusWires, R0);
    reg1 : myReg PORT MAP(clk, rst, regin(1), BusWires, R1);
    reg2 : myReg PORT MAP(clk, rst, regin(2), BusWires, R2);
    reg3 : myReg PORT MAP(clk, rst, regin(3), BusWires, R3);
    reg4 : myReg PORT MAP(clk, rst, regin(4), BusWires, R4);
    reg5 : myReg PORT MAP(clk, rst, regin(5), BusWires, R5);
    reg6 : myReg PORT MAP(clk, rst, regin(6), BusWires, R6);
    reg7 : myReg PORT MAP(clk, rst, regin(7), BusWires, R7);
    PCr : PCReg PORT MAP(clk, rst, PCin, incr, PCmode, R5, R6, BusWires, PC);
    Areg : myReg PORT MAP(clk, rst, ain, BusWires, A);
    Greg : myReg PORT MAP(clk, rst, Gin, Gt, G);
    IRreg : myReg PORT MAP(clk, rst, IRin, data, IR);
    IR2reg : myReg PORT MAP(clk, rst, IR2in, data, IR2);
    addrReg : ENTITY work.addrReg PORT MAP(clk, rst, addrin, addrsel, PC, R5, R6, BusWires, addr);
    doutReg : myReg PORT MAP(clk, rst, doutin, BusWires, dout);

    Greg16 : ENTITY work.myReg16 PORT MAP(clk, rst, G16in, G16t, G16);
	 
    -- devices
    dev : ENTITY work.devices PORT MAP(clk, rst, devoutin, SW, KEY, LED(7 DOWNTO 0), HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, R7, R5, R6, devout, devsel);

    -- MUX
    regMUX0 : ENTITY work.RegMUX PORT MAP(R0, R1, R2, R3, R4, R5, R6, R7, G, data, devout, G16, sel, BusWires);
    -- MUX16
    regMUX16 : ENTITY work.MUX16 PORT MAP(prod, PC, MUX16sel, G16t);

    -- FSM
    ControlUnit : ctrlUnitFSM PORT MAP(regin, ain, gin, IRin, IR2in, addrin, doutin, cmpin, carryin, PCin, G16in, devoutin, PCmode, incr, flags, IR, IR2, addrsel, sel, MUX16sel, alusel, devsel, rst, clk, done, W);

    -- ROM 
    user_ROM : ENTITY work.myROM PORT MAP (addr, data, dout, W, clk);

    --    ClockDivider : ENTITY work.CD PORT MAP(clkO, clk, rstN);
    clk <= clkO;

END ARCHITECTURE;