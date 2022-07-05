library ieee;
use ieee.std_logic_1164.all;

entity ThreeBitSix2OneMUX is
    port(
        ss : in std_logic_vector(2 downto 0);
        uu : in std_logic_vector(2 downto 0);
        vv : in std_logic_vector(2 downto 0);
        ww : in std_logic_vector(2 downto 0);
        xx : in std_logic_vector(2 downto 0);
        yy : in std_logic_vector(2 downto 0);
        zz : in std_logic_vector(2 downto 0);
        mm : out std_logic_vector(2 downto 0)
    );
end entity;

architecture behave of ThreeBitSix2OneMUX is
    component Six2OneMUX is
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
    end component;

begin
	
	 gen: for i in 2 downto 0 generate
        MUX2: Six2OneMUX port map(
				s => ss,
				u => uu(i),
				v => vv(i),
				w => ww(i),
				x => xx(i),
				y => yy(i),
				z => zz(i),
				m => mm(i)
        );
    end generate;

end architecture;
