library ieee;
use ieee.std_logic_1164.all;
entity Exc2 is
    port(
        x : in std_logic;
        s : in std_logic;
        y : in std_logic;
        m : out std_logic
    );
end entity;

architecture arch of Exc2 is
begin
    m <= (NOT(s) AND x) OR (s AND y);
end arch; -- arch