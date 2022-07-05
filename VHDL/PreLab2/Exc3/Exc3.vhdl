LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Exc3 IS
	PORT (
		Clk, D : IN STD_LOGIC;
		Q : OUT STD_LOGIC
	);
END Exc3;

ARCHITECTURE Structural OF Exc3 IS
	SIGNAL R_g, S_g, Qa, Qb, S, R : STD_LOGIC;
	ATTRIBUTE KEEP : BOOLEAN;
	ATTRIBUTE KEEP OF R_g, S_g, Qa, Qb : SIGNAL IS TRUE;

BEGIN
	S <= D;
	R <= NOT(D);
	R_g <= R AND Clk;
	S_g <= S AND Clk;
	Qa <= R_g NOR Qb;
	Qb <= S_g NOR Qa;
	Q <= Qa;
END Structural;
