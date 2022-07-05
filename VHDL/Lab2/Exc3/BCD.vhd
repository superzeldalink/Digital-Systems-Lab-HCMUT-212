library ieee;
use ieee.std_logic_1164.all;

entity BCD is
  port (
    c : in std_logic_vector(4 downto 0);
    HEXn : out std_logic_vector(0 to 6)
  ) ;
end BCD;

architecture behavior of BCD is
SIGNAL HEX : std_logic_vector(0 to 6);
begin
HEXn <= not(HEX);
with c select
    HEX <=  "1111110" when "00000",
            "0110000" when "00001",
            "1101101" when "00010",
            "1111001" when "00011",
            "0110011" when "00100",
            "1011011" when "00101",
            "1011111" when "00110",
            "1110000" when "00111",
            "1111111" when "01000",
            "1111011" when "01001",
            "0000000" when others;
end behavior ; -- behavior
