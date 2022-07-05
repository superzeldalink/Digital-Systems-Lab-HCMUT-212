LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY Exc2 IS
PORT(
	X,Y,Z : IN STD_LOGIC;
	F : OUT STD_LOGIC);
END Exc2;
ARCHITECTURE Logic OF Exc2 IS
	SIGNAL input : std_logic_vector(2 DOWNTO 0);
BEGIN
	input(2) <= X;
	input(1) <= Y;
	input(0) <= Z;
	WITH input SELECT
		F <=  '1' WHEN "001",
				'1' WHEN "110",
				'1' WHEN "111",
				'0' WHEN others;
END Logic;