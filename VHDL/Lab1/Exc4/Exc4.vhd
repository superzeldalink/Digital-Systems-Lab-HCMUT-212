library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Exc4 is
    port(
        SW : in std_logic_vector(9 downto 7);
		  HEX0 : out std_logic_vector(0 to 6);
		  HEX1 : out std_logic_vector(0 to 6);
		  HEX2 : out std_logic_vector(0 to 6);
		  HEX3 : out std_logic_vector(0 to 6);
		  HEX4 : out std_logic_vector(0 to 6);
		  HEX5 : out std_logic_vector(0 to 6)
    );
end entity;

architecture behave of Exc4 is
SIGNAL mm : std_logic_vector(1 downto 0);
SIGNAL sel5, sel4, sel3, sel2, sel1, sel0 : std_logic_vector(2 downto 0);

SIGNAL sel : std_logic_vector(2 downto 0);
	 
	 component HELLO is
        port (
			 c : in std_logic_vector(2 downto 0);
			 HEXn : out std_logic_vector(0 to 6)
		  ) ;
    end component;

begin
	sel5 <= std_logic_vector("000" - unsigned(SW(9 downto 7)));
	sel4 <= std_logic_vector("001" - unsigned(SW(9 downto 7)));
	sel3 <= std_logic_vector("010" - unsigned(SW(9 downto 7)));
	sel2 <= std_logic_vector("011" - unsigned(SW(9 downto 7)));
	sel1 <= std_logic_vector("100" - unsigned(SW(9 downto 7)));
	sel0 <= std_logic_vector("101" - unsigned(SW(9 downto 7)));
	
    HEX05: HELLO port map(c => sel5, HEXn => HEX5);
	 HEX04: HELLO port map(c => sel4, HEXn => HEX4);
	 HEX03: HELLO port map(c => sel3, HEXn => HEX3);
	 HEX02: HELLO port map(c => sel2, HEXn => HEX2);
	 HEX01: HELLO port map(c => sel1, HEXn => HEX1);
	 HEX00: HELLO port map(c => sel0, HEXn => HEX0);
	

end architecture;
