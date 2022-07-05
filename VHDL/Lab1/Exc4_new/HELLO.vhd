library ieee;
use ieee.std_logic_1164.all;

entity HELLO is
  port (
    c : in std_logic_vector(2 downto 0);
    HEXn : out std_logic_vector(0 to 6)
  ) ;
end HELLO;

architecture behavior of HELLO is
SIGNAL HEX : std_logic_vector(0 to 6);
begin
HEXn <= not(HEX);
with c select
    HEX <= "0110111" when "000",
            "1001111" when "001",
            "0001110" when "010",
            "1111110" when "011",
            "0000000" when others;
end behavior ; -- behavior
