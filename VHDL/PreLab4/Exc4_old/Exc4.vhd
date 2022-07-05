LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc4 IS
	PORT (
		clkin, rst : IN STD_LOGIC;
		clkout : OUT STD_LOGIC
	);
END Exc4;

ARCHITECTURE arch OF Exc4 IS
	CONSTANT countMax : UNSIGNED(63 DOWNTO 0) := TO_UNSIGNED(100000000, 64);
	SIGNAL count : UNSIGNED(63 DOWNTO 0) := TO_UNSIGNED(1, 64);
	SIGNAL clkt : STD_LOGIC;
BEGIN
	PROCESS (clkin)
	BEGIN
		IF rst = '1' THEN
			count <= TO_UNSIGNED(1, 64);
		ELSIF rising_edge(clkin) THEN
			count <= count + TO_UNSIGNED(1, 64);
			IF (count = countMax*2) THEN
				clkt <= NOT(clkt);
				count <= TO_UNSIGNED(1, 64);
			END IF;
		END IF;
	END PROCESS;
	clkout <= clkt;
END ARCHITECTURE;