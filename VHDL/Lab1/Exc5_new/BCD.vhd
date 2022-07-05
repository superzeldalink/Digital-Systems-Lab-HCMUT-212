library ieee;
use ieee.std_logic_1164.all;

entity BCD is
  port (
    c : in std_logic_vector(3 downto 0);
    HEXn : out std_logic_vector(0 to 6)
  ) ;
end BCD;

architecture behavior of BCD is
SIGNAL HEX : std_logic_vector(0 to 6);
begin
HEXn <= not(HEX);
with c select
    HEX <=  "1111110" when "0000",
            "0110000" when "0001",
            "1101101" when "0010",
            "1111001" when "0011",
            "0110011" when "0100",
            "1011011" when "0101",
            "1011111" when "0110",
            "1110000" when "0111",
            "1111111" when "1000",
            "1111011" when "1001",
            "0000000" when others;
end behavior ; -- behavior
