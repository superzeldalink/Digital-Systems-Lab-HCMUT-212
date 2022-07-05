library ieee;
use ieee.std_logic_1164.all;

entity TwoBitFour2OneMUX is
    port(
        ss : in std_logic_vector(1 downto 0);
        uu : in std_logic_vector(1 downto 0);
        vv : in std_logic_vector(1 downto 0);
        ww : in std_logic_vector(1 downto 0);
        xx : in std_logic_vector(1 downto 0);
        mm : out std_logic_vector(1 downto 0)
    );
end entity;

architecture behave of TwoBitFour2OneMUX is
    component Four2OneMUX is
        port(
			  s : in std_logic_vector(1 downto 0);
			  u : in std_logic;
			  v : in std_logic;
			  w : in std_logic;
			  x : in std_logic;
			  m : out std_logic
		 );
    end component;

begin
	
	 gen: for i in 1 downto 0 generate 
        MUX2: Four2OneMUX port map(
				s => ss,
				u => uu(i),
				v => vv(i),
				w => ww(i),
				x => xx(i),
				m => mm(i)
        );
    end generate;

end architecture;
