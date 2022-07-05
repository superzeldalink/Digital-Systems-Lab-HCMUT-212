library ieee;
use ieee.std_logic_1164.all;

entity Exc3 is
  port (
    c : in std_logic_vector(1 downto 0);
    HEX0 : out std_logic_vector(0 to 6)
  ) ;
end Exc3;

architecture behavior of Exc3 is
SIGNAL HEX : std_logic_vector(0 to 6);
begin
HEX0 <= not(HEX);
with c select
    HEX <= "0111101" when "00",
            "1001111" when "01",
            "0110000" when "10",
            "1111110" when "11",
            "0000000" when others;
end behavior ; -- behavior