LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Exc1 IS
	PORT (
		a : IN std_logic;
		b : IN std_logic;
		ci : IN std_logic;
		s : OUT std_logic;
		co : OUT std_logic
	);
END Exc1;

ARCHITECTURE arch OF Exc1 IS

BEGIN
	s <= a XOR b XOR ci;
	co <= (a AND b) OR (ci AND (a XOR b));
END ARCHITECTURE;