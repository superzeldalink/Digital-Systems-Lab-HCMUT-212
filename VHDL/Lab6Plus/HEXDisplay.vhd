LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY HEXDisplay IS
  PORT (
    c : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    HEXn : OUT STD_LOGIC_VECTOR(0 TO 6)
  );
END HEXDisplay;

ARCHITECTURE behavior OF HEXDisplay IS
  SIGNAL HEX : STD_LOGIC_VECTOR(0 TO 6);
BEGIN
  HEXn <= NOT(HEX);
  WITH c SELECT
    HEX <= "1111110" WHEN "0000",
    "0110000" WHEN "0001",
    "1101101" WHEN "0010",
    "1111001" WHEN "0011",
    "0110011" WHEN "0100",
    "1011011" WHEN "0101",
    "1011111" WHEN "0110",
    "1110000" WHEN "0111",
    "1111111" WHEN "1000",
    "1111011" WHEN "1001",
    "1110111" WHEN "1010",
    "0011111" WHEN "1011",
    "1001110" WHEN "1100",
    "0111101" WHEN "1101",
    "1001111" WHEN "1110",
    "1000111" WHEN "1111",
    "0000000" WHEN OTHERS;
END behavior; -- behavior