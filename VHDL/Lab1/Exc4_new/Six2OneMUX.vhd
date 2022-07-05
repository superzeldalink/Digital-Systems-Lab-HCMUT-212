library ieee;
use ieee.std_logic_1164.all;

entity Six2OneMUX is
    port(
        s : in std_logic_vector(2 downto 0);
        u : in std_logic;
        v : in std_logic;
        w : in std_logic;
        x : in std_logic;
        y : in std_logic;
        z : in std_logic;
        m : out std_logic
    );
end entity;

architecture behave of Six2OneMUX is
begin
    with s select
		m <= u when "000",
			  v when "001",
			  w when "010",
			  x when "011",
			  y when "100",
			  z when "101",
			  '1' when others;

end architecture;
