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
SIGNAL sel3, sel2, sel1, sel0, selct : std_logic_vector(1 downto 0);
SIGNAL outHEX3, outHEX2, outHEX1, outHEX0 : std_logic_vector(1 downto 0);
	 
	 component DE10 is
        port (
			 c : in std_logic_vector(1 downto 0);
			 HEXn : out std_logic_vector(0 to 6)
		  ) ;
    end component;
	 
	 component TwoBitFour2OneMUX is
		 port(
			  ss : in std_logic_vector(1 downto 0);
			  uu : in std_logic_vector(1 downto 0);
			  vv : in std_logic_vector(1 downto 0);
			  ww : in std_logic_vector(1 downto 0);
			  xx : in std_logic_vector(1 downto 0);
			  mm : out std_logic_vector(1 downto 0)
		 );
	end component;

begin
	selct <= SW(9 downto 8);
	sel3 <= SW(7 downto 6);
	sel2 <= SW(5 downto 4);
	sel1 <= SW(3 downto 2);
	sel0 <= SW(1 downto 0);
	MUX3: TwoBitFour2OneMUX port map(
		uu => sel3, vv => sel2, ww => sel1, xx => sel0, ss => selct, mm => outHEX3
	);
	MUX2: TwoBitFour2OneMUX port map(
		uu => sel2, vv => sel1, ww => sel0, xx => sel3, ss => selct, mm => outHEX2
	);
	MUX1: TwoBitFour2OneMUX port map(
		uu => sel1, vv => sel0, ww => sel3, xx => sel2, ss => selct, mm => outHEX1
	);
	MUX0: TwoBitFour2OneMUX port map(
		uu => sel0, vv => sel3, ww => sel2, xx => sel1, ss => selct, mm => outHEX0
	);
	
    HEX03: DE10 port map(c => outHEX3, HEXn => HEX3);
	 HEX02: DE10 port map(c => outHEX2, HEXn => HEX2);
	 HEX01: DE10 port map(c => outHEX1, HEXn => HEX1);
	 HEX00: DE10 port map(c => outHEX0, HEXn => HEX0);
	

end architecture;
