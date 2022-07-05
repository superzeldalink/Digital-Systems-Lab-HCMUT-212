library ieee;
use ieee.std_logic_1164.all;

entity Four2OneMUX is
    port(
        s : in std_logic_vector(1 downto 0);
        u : in std_logic;
        v : in std_logic;
        w : in std_logic;
        x : in std_logic;
        m : out std_logic
    );
end entity;

architecture behave of Four2OneMUX is
begin
    with s select
		m <= u when "00",
			  v when "01",
			  w when "10",
			  x when "11";

end architecture;