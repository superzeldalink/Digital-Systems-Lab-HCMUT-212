LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mul IS
	PORT (
		a, b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		p : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END mul;

ARCHITECTURE arch OF mul IS
	SIGNAL a_padded, zero : STD_LOGIC_VECTOR(15 DOWNTO 0);
	TYPE ab_t IS ARRAY(0 TO 7) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL ab : ab_t;
BEGIN

	zero <= "0000000000000000";
	a_padded <= "00000000" & a;

	ab(0) <= a_padded WHEN b(0) = '1' ELSE zero;
	sum : FOR i IN 1 TO 7 GENERATE
		ab(i) <= a_padded(15 - i DOWNTO 0) & zero(i - 1 DOWNTO 0) WHEN b(i) = '1' ELSE zero;
	END GENERATE;

	p <= ab(0) + ab(1) + ab(2) + ab(3) + ab(4) + ab(5) + ab(6) + ab(7);
END ARCHITECTURE;
