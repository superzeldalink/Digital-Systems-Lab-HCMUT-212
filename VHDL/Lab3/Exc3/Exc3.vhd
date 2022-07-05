LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc3 IS
    PORT (
        inp : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  HEX3, HEX2, HEX1, HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
        enAB, clkN, rstN : IN STD_LOGIC
    );
END Exc3;

ARCHITECTURE arch OF Exc3 IS
    SIGNAL a, b : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL p : STD_LOGIC_VECTOR(15 DOWNTO 0);
	 SIGNAL clk, rst : STD_LOGIC;
    COMPONENT EightBitReg IS
        PORT (
            EBRClk, EBRrst, EBRen : IN STD_LOGIC;
            EBRD : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            EBRQ : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Mul IS
        PORT (
            mulA, mulB : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            mulP : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;
	 
	 COMPONENT HEXDisplay is
	  port (
		 c : in std_logic_vector(3 downto 0);
		 HEXn : out std_logic_vector(0 to 6)
	  ) ;
	end COMPONENT;
BEGIN
	 rst <= NOT(rstN);
	 clk <= NOT(clkN);
    EBRA : EightBitReg PORT MAP(EBRClk => clk, EBRrst => rst, EBRen => enAB, EBRD => inp, EBRQ => a);
    EBRB : EightBitReg PORT MAP(EBRClk => clk, EBRrst => rst, EBRen => NOT(enAB), EBRD => inp, EBRQ => b);

    multiplier : Mul PORT MAP(mulA => a, mulB => b, mulP => p);
 
	 HEX03 : HEXDisplay PORT MAP(c => p(15 DOWNTO 12), HEXn => HEX3);
	 HEX02 : HEXDisplay PORT MAP(c => p(11 DOWNTO 8), HEXn => HEX2);
	 HEX01 : HEXDisplay PORT MAP(c => p(7 DOWNTO 4), HEXn => HEX1);
	 HEX00 : HEXDisplay PORT MAP(c => p(3 DOWNTO 0), HEXn => HEX0);
END ARCHITECTURE;