library ieee;
use ieee.std_logic_1164.all;

entity MUX is
    port(
        a : in std_logic;
        sel : in std_logic;
        b : in std_logic;
        z : out std_logic
    );
end entity;

architecture arch of MUX is
begin
    z <= (NOT(sel) AND a) OR (sel AND b);
end arch;