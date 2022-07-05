LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc1 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        HEX3, HEX2, HEX1, HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
		  LEDs : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        clkN, rstN : IN STD_LOGIC;
        carry : OUT STD_LOGIC
    );
END Exc1;

ARCHITECTURE arch OF Exc1 IS
	 SIGNAL rst, clk, ofl, crr : STD_LOGIC;
    SIGNAL Qa, Qb, Qc : STD_LOGIC_VECTOR(8 DOWNTO 0);
	 ATTRIBUTE KEEP : BOOLEAN;
	 ATTRIBUTE KEEP OF Qc : SIGNAL IS TRUE;
	 
    COMPONENT DFFn IS
        PORT (
            Din, DClk, Drst : IN STD_LOGIC;
            DQ : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT EightBitReg IS
        PORT (
            EBRClk, EBRrst : IN STD_LOGIC;
            EBRD : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            EBRQ : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
        );
    END COMPONENT;
	 
	COMPONENT HEXDisplay is
	  port ( 
		 c : in std_logic_vector(3 downto 0);
		 HEXn : out std_logic_vector(0 to 6)
	  ) ;
	end COMPONENT;
BEGIN
    clk <= NOT(clkN);
    rst <= NOT(rstN);
	 
    Qb <= STD_LOGIC_VECTOR(unsigned(Qc) + unsigned(Qa));
    EBR0 : EightBitReg PORT MAP(EBRrst => rst, EBRClk => clk, EBRD => '0'&A, EBRQ => Qa);
    EBR1 : EightBitReg PORT MAP(EBRrst => rst, EBRClk => clk, EBRD => Qb, EBRQ => Qc);
    DFF0 : DFFn PORT MAP(Drst => rst, DClk => clk, Din => crr, DQ => carry);
	 
	 LEDs <= Qc(7 DOWNTO 0);
	 crr <= Qb(8);
	 HEX03 : HEXDisplay PORT MAP(c => A(7 DOWNTO 4), HEXn => HEX3);
	 HEX02 : HEXDisplay PORT MAP(c => A(3 DOWNTO 0), HEXn => HEX2);
	 HEX01 : HEXDisplay PORT MAP(c => Qc(7 DOWNTO 4), HEXn => HEX1);
	 HEX00 : HEXDisplay PORT MAP(c => Qc(3 DOWNTO 0), HEXn => HEX0);
	 
	 
END ARCHITECTURE;