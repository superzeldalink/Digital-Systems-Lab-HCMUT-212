LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY DFFn IS
	PORT (
		DClk, Din : IN STD_LOGIC;
		DQ : OUT STD_LOGIC
	);
END DFFn;

ARCHITECTURE Structural OF DFFn IS
	SIGNAL R_g, S_g, Qa, Qb, S, R : STD_LOGIC;
	ATTRIBUTE KEEP : BOOLEAN;
	ATTRIBUTE KEEP OF R_g, S_g, Qa, Qb : SIGNAL IS TRUE;

BEGIN
	S <= Din;
	R <= NOT(Din);
	R_g <= R AND DClk;
	S_g <= S AND DClk;
	Qa <= R_g NOR Qb;
	Qb <= S_g NOR Qa;
	DQ <= Qa;
END Structural;
