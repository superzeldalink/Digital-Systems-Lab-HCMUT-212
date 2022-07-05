LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Exc2 IS
	PORT (
		Clk, R, S : IN STD_LOGIC;
		Q : OUT STD_LOGIC
	);
END Exc2;

ARCHITECTURE Structural OF Exc2 IS
	SIGNAL R_g, S_g, Qa, Qb : STD_LOGIC;
	ATTRIBUTE KEEP : BOOLEAN;
	ATTRIBUTE KEEP OF R_g, S_g, Qa, Qb : SIGNAL IS TRUE;
BEGIN
	R_g <= R AND Clk;
	S_g <= S AND Clk;
	Qa <= R_g NOR Qb;
	Qb <= S_g NOR Qa;
	Q <= Qa;
END Structural;
