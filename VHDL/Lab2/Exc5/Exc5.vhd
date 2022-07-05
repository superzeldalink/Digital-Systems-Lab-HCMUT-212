LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc5 IS
    PORT (
        D, Clk : IN STD_LOGIC;
        Qa, Qb, Qc : OUT STD_LOGIC
    );
END Exc5;

ARCHITECTURE arch OF Exc5 IS
    COMPONENT DL IS
		 PORT (
			  DLin, DLClk : IN STD_LOGIC;
			  DLQ : OUT STD_LOGIC);
	END COMPONENT;
	 
	 COMPONENT DFFn IS
        PORT (
            Din, DClk : IN STD_LOGIC;
            DQ : OUT STD_LOGIC);
    END COMPONENT;
BEGIN
    DFF2 : DL PORT MAP(DLin => D, DLClk => Clk, DLQ => Qa);
    DFF1 : DFFn PORT MAP(Din => D, DClk => Clk, DQ => Qb);
    DFF0 : DFFn PORT MAP(Din => D, DClk => NOT(Clk), DQ => Qc);
END ARCHITECTURE;