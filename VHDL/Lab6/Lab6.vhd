LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Lab6 IS
    PORT (
        R0out, R1out, addrOut, dataOut, IRout : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
        sw : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        LEDout : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
        dataROM : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(0 TO 6);
        rstN, clkO, btn : IN STD_LOGIC;
        done : BUFFER STD_LOGIC;
        BusWires : BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0)
    );
END Lab6;

ARCHITECTURE Behavior OF Lab6 IS
    -- MISC
    SIGNAL addOrSub, zero : STD_LOGIC;

    -- REGISTERS, A, G, IR
    SIGNAL regin : STD_LOGIC_VECTOR(0 TO 7);
    SIGNAL A, G, Gt, dout, led, dataFromROM : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL ain, gin, IRin, addrin, doutin, LEDwrite, rst, incr, W, WE, clk : STD_LOGIC;
    SIGNAL R0, R1, R2, R3, R4, R5, R6, R7, IR, data, addr : STD_LOGIC_VECTOR(8 DOWNTO 0);

    SIGNAL sel : INTEGER RANGE 0 TO 10;

    COMPONENT myReg IS
        PORT (
            clk, rst, en : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT PCReg IS
        PORT (
            clk, rst, en, incr : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            Q : BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ctrlunitFSM IS
        PORT (
            SIGNAL rin : OUT STD_LOGIC_VECTOR(0 TO 7);
            SIGNAL ain, gin, IRin, addrin, doutin, addsub, incr : OUT STD_LOGIC;
            SIGNAL zero : IN STD_LOGIC;
            SIGNAL IR : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            SIGNAL outsel : OUT INTEGER RANGE 0 TO 10;
            SIGNAL rst, clk : IN STD_LOGIC;
            SIGNAL done : BUFFER STD_LOGIC;
            SIGNAL W : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN

    -- DEBUG!
    R0out <= R0;
    R1out <= R1;
    addrOut <= addr;
    IRout <= IR;
    dataROM <= data;
    dataOut <= dout;
    LEDout <= '0' & led(8 DOWNTO 0);

    HEX5 <= (OTHERS => '1');
    HEX4 <= (OTHERS => '1');
    HEX3 <= (OTHERS => '1');

    -- Write
    WE <= '1' WHEN addr(8 DOWNTO 7) = "00" AND W = '1' ELSE
        '0';
    LEDwrite <= '1' WHEN addr(8 DOWNTO 7) = "01" AND W = '1' ELSE
        '0';

    -- Load
    data <= dataFromROM WHEN addr(8 DOWNTO 7) = "00" AND W = '0' ELSE
        "00000000" & btn WHEN addr(8 DOWNTO 7) = "10" AND W = '0' ELSE
        SW WHEN addr(8 DOWNTO 7) = "11" AND W = '0' ELSE
        "000000000";

    -- MISC
    rst <= NOT(rstN);
	 zero <= '1' WHEN SIGNED(BusWires) = 0 ELSE '0';

    -- ADDSUB
    as : ENTITY work.AddSub PORT MAP(A, BusWires, addOrSub, Gt);

    -- REGS
    reg0 : myReg PORT MAP(clk, rst, regin(0), BusWires, R0);
    reg1 : myReg PORT MAP(clk, rst, regin(1), BusWires, R1);
    reg2 : myReg PORT MAP(clk, rst, regin(2), BusWires, R2);
    reg3 : myReg PORT MAP(clk, rst, regin(3), BusWires, R3);
    reg4 : myReg PORT MAP(clk, rst, regin(4), BusWires, R4);
    reg5 : myReg PORT MAP(clk, rst, regin(5), BusWires, R5);
    reg6 : myReg PORT MAP(clk, rst, regin(6), BusWires, R6);
    reg7 : PCReg PORT MAP(clk, rst, regin(7), incr, BusWires, R7);
    Areg : myReg PORT MAP(clk, rst, ain, BusWires, A);
    Greg : myReg PORT MAP(clk, rst, Gin, Gt, G);
    IRreg : myReg PORT MAP(clk, rst, IRin, data, IR);
    addrReg : myReg PORT MAP(clk, rst, addrin, BusWires, addr);
    doutReg : myReg PORT MAP(clk, rst, doutin, BusWires, dout);

    LEDReg : myReg PORT MAP(clk, rst, LEDwrite, dout, led);

    -- MUX
    regMUX0 : ENTITY work.RegMUX PORT MAP(R0, R1, R2, R3, R4, R5, R6, R7, G, data, sel, BusWires);

    -- FSM
    ControlUnit : ctrlUnitFSM PORT MAP(regin, ain, gin, IRin, addrin, doutin, addorsub, incr, zero, IR, sel, rst, clk, done, W);

    -- ROM 
    user_ROM : ENTITY work.myROM PORT MAP (addr(6 DOWNTO 0), dataFromROM, dout, WE, clk);

    BCD : ENTITY work.BCDDisplay PORT MAP(led(8 DOWNTO 0), HEX2, HEX1, HEX0);

    -- ClockDivider : ENTITY work.CD PORT MAP(clkO, clk, rstN);
    clk <= clkO;

END ARCHITECTURE;