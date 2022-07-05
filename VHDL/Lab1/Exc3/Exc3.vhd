library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Exc3 is
    port(
        SW : in std_logic_vector(9 downto 0);
		  HEX0 : out std_logic_vector(0 to 6);
		  HEX1 : out std_logic_vector(0 to 6);
		  HEX2 : out std_logic_vector(0 to 6);
		  HEX3 : out std_logic_vector(0 to 6)
    );
end entity;

architecture behave of Exc3 is
SIGNAL sel3, sel2, sel1, sel0 : std_logic_vector(1 downto 0);
	 
	 component DE10 is
        port (
			 c : in std_logic_vector(1 downto 0);
			 HEXn : out std_logic_vector(0 to 6)
		  ) ;
    end component;

begin
	sel3 <= std_logic_vector(unsigned(SW(7 downto 6)) + unsigned(SW(9 downto 8)));
	sel2 <= std_logic_vector(unsigned(SW(5 downto 4)) + unsigned(SW(9 downto 8)));
	sel1 <= std_logic_vector(unsigned(SW(3 downto 2)) + unsigned(SW(9 downto 8)));
	sel0 <= std_logic_vector(unsigned(SW(1 downto 0)) + unsigned(SW(9 downto 8)));
	
    HEX03: DE10 port map(c => sel3, HEXn => HEX3);
	 HEX02: DE10 port map(c => sel2, HEXn => HEX2);
	 HEX01: DE10 port map(c => sel1, HEXn => HEX1);
	 HEX00: DE10 port map(c => sel0, HEXn => HEX0);
	

end architecture;
