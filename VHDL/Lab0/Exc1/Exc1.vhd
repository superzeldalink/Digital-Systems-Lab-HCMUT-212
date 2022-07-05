LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY Exc1 IS
PORT(
	Y3,Y2,Y1,Y0 : IN STD_LOGIC;
	A1,A0,V : OUT STD_LOGIC);
END Exc1;
ARCHITECTURE Logic OF Exc1 IS
BEGIN
	A1 <= Y3 OR Y2;
	A0 <= Y3 OR (not(Y2) AND Y1);
	V <= Y0 OR Y1 OR Y2 OR Y3;
END Logic;
