library ieee;
use ieee.std_logic_1164.all;

entity CircuitA is
    port(
        dIn : in std_logic_vector(4 downto 0);
        dOut : out std_logic_vector(4 downto 0)
    );
end entity;

architecture behave of CircuitA is
begin
    -- V = 0
    dOut(4) <= '0';

    -- W = B'*D
    dOut(3) <= not(dIn(3)) and dIn(1);

    -- Y = C'D' + CD
    dOut(2) <= dIn(2) xnor dIn(1);

    -- X = D'
    dOut(1) <= not(dIn(1));

    -- Z = E
    dOut(0) <= dIn(0);

end architecture;
