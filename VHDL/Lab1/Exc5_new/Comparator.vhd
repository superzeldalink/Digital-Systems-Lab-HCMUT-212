library ieee;
use ieee.std_logic_1164.all;

entity Comparator is
    port(
        compIn : in std_logic_vector(3 downto 0);
        compOut : out std_logic
    );
end entity;

architecture behave of Comparator is
begin
-- Z = A(B+C)
    compOut <= compIn(3) and (compIn(2) or compIn(1));

end architecture;