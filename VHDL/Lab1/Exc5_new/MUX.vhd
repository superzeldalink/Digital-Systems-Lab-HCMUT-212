library ieee;
use ieee.std_logic_1164.all;

entity MUX is
    port(
        muxIn1 : in std_logic;
        muxSel : in std_logic;
        muxIn2 : in std_logic;
        muxOut : out std_logic
    );
end entity;

architecture arch of MUX is
begin
    muxOut <= (NOT(muxSel) AND muxIn1) OR (muxSel AND muxIn2);
end arch;
