LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY NineDFF IS
	PORT (
		NClk, Nen : IN STD_LOGIC;
		ND, Nprs, Nclr : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		NQ : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END NineDFF;

ARCHITECTURE arch OF NineDFF IS
	COMPONENT DFFn IS
		PORT (
			Din, DClk, Dprs, Dclr, Den : IN STD_LOGIC;
			DQ : OUT STD_LOGIC);
	END COMPONENT;
BEGIN
	gen : FOR i IN 8 DOWNTO 0 GENERATE
		DFFs : DFFn PORT MAP(
			Din => ND(i), DClk => NClk, Dprs => Nprs(i),
			Dclr => Nclr(i), Den => Nen, DQ => NQ(i));
	END GENERATE;
END ARCHITECTURE;