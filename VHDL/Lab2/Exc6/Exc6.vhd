LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc6 IS
    PORT (
        ClkN, rstN : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  cout : OUT STD_LOGIC;
        HEX5 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX4 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);
        HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6)
    );
END Exc6;

ARCHITECTURE arch OF Exc6 IS
    SIGNAL sum: STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL Q: STD_LOGIC_VECTOR(7 DOWNTO 0);
	 SIGNAL Clk, rst : STD_LOGIC;
    COMPONENT EightBitReg IS
        PORT (
            EBRClk, EBRrst : IN STD_LOGIC;
            EBRD : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            EBRQ : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
	 
	 COMPONENT HEXDisplay IS
		PORT (
			c : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			HEXn : OUT STD_LOGIC_VECTOR(0 TO 6)
		);
	END COMPONENT;
	 
BEGIN
	 Clk <= NOT(ClkN);
	 rst <= NOT(rstN);
    sum <= STD_LOGIC_VECTOR(unsigned('0'&Q) + unsigned('0'&D));
    EBR : EightBitReg PORT MAP(EBRClk => Clk, EBRrst => rst, EBRD => D, EBRQ => Q);
    HEX05 : HEXDisplay PORT MAP(c => sum(7 DOWNTO 4), HEXn => HEX5);
    HEX04 : HEXDisplay PORT MAP(c => sum(3 DOWNTO 0), HEXn => HEX4);
    HEX03 : HEXDisplay PORT MAP(c => D(7 DOWNTO 4), HEXn => HEX3);
    HEX02 : HEXDisplay PORT MAP(c => D(3 DOWNTO 0), HEXn => HEX2);
    HEX01 : HEXDisplay PORT MAP(c => Q(7 DOWNTO 4), HEXn => HEX1);
    HEX00 : HEXDisplay PORT MAP(c => Q(3 DOWNTO 0), HEXn => HEX0);
	 cout <= sum(8);
END ARCHITECTURE;