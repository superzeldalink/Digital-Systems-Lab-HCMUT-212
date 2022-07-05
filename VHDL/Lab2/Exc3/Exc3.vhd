LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc3 IS
	PORT (
		an : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		bn : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		cin : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		HEXo0 : OUT STD_LOGIC_VECTOR(0 TO 6);
		HEXo1 : OUT STD_LOGIC_VECTOR(0 TO 6);
		HEXo3 : OUT STD_LOGIC_VECTOR(0 TO 6);
		HEXo5 : OUT STD_LOGIC_VECTOR(0 TO 6);
		sum : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		error : OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE arch OF Exc3 IS
	SIGNAL sn : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL digit1, digit0 : STD_LOGIC_VECTOR(4 DOWNTO 0);

	COMPONENT BCD IS
		PORT (
			c : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			HEXn : OUT STD_LOGIC_VECTOR(0 TO 6)
		);
	END COMPONENT;
BEGIN
	HEX5 : BCD PORT MAP(c => '0' & an, HEXn => HEXo5);
	HEX3 : BCD PORT MAP(c => '0' & bn, HEXn => HEXo3);

	sn <= STD_LOGIC_VECTOR(unsigned('0' & an) + unsigned('0' & bn) + unsigned(cin));
	digit1 <= STD_LOGIC_VECTOR(unsigned(sn) / 10);
	digit0 <= STD_LOGIC_VECTOR(unsigned(sn) MOD 10);

	HEX01 : BCD PORT MAP(c => digit1, HEXn => HEXo1);
	HEX00 : BCD PORT MAP(c => digit0, HEXn => HEXo0);
	
	sum <= sn;

	error <= '1' WHEN (unsigned(an) > 9 or unsigned(bn) > 9) ELSE '0';
END ARCHITECTURE;