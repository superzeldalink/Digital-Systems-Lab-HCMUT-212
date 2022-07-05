library ieee;
use ieee.std_logic_1164.all;

entity CircuitA is
    port(
        dIn : in std_logic_vector(3 downto 0);
        dOut : out std_logic_vector(3 downto 0)
    );
end entity;

architecture behave of CircuitA is
begin
    -- V = 0
    dOut(3) <= '0';

    -- W = B*C
    dOut(2) <= dIn(2) and dIn(1);

    -- Y = C'
    dOut(1) <= not(dIn(1));

    -- X = D
     dOut(0) <= dIn(0);

end architecture;
