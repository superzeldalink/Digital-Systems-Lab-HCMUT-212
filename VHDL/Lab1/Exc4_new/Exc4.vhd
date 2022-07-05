library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Exc4 is
    port(
        SW : in std_logic_vector(2 downto 0);
		  HEX0 : out std_logic_vector(0 to 6);
		  HEX1 : out std_logic_vector(0 to 6);
		  HEX2 : out std_logic_vector(0 to 6);
		  HEX3 : out std_logic_vector(0 to 6);
		  HEX4 : out std_logic_vector(0 to 6);
		  HEX5 : out std_logic_vector(0 to 6)
    );
end entity;

architecture behave of Exc4 is
SIGNAL sel5, sel4, sel3, sel2, sel1, sel0, selct : std_logic_vector(2 downto 0);
SIGNAL outHEX5, outHEX4, outHEX3, outHEX2, outHEX1, outHEX0 : std_logic_vector(2 downto 0);
	 
	 component HELLO is
        port (
			c : in std_logic_vector(2 downto 0);
			HEXn : out std_logic_vector(0 to 6)
		) ;
    end component;
	 
	 component ThreeBitSix2OneMUX is
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
	end component;

begin
	selct <= SW(2 downto 0);

	-- HELLO
	sel5 <= "000";
	sel4 <= "001";
	sel3 <= "010";
	sel2 <= "010";
	sel1 <= "011";
	sel0 <= "100";

	MUX5: ThreeBitSix2OneMUX port map(
		uu => sel5, vv => sel0, ww => sel1, xx => sel2, yy => sel3, zz => sel4, ss => selct, mm => outHEX5
	);
	MUX4: ThreeBitSix2OneMUX port map(
		uu => sel4, vv => sel5, ww => sel0, xx => sel1, yy => sel2, zz => sel3, ss => selct, mm => outHEX4
	);
	MUX3: ThreeBitSix2OneMUX port map(
		uu => sel3, vv => sel4, ww => sel5, xx => sel0, yy => sel1, zz => sel2, ss => selct, mm => outHEX3
	);
	MUX2: ThreeBitSix2OneMUX port map(
		uu => sel2, vv => sel3, ww => sel4, xx => sel5, yy => sel0, zz => sel1, ss => selct, mm => outHEX2
	);
	MUX1: ThreeBitSix2OneMUX port map(
		uu => sel1, vv => sel2, ww => sel3, xx => sel4, yy => sel5, zz => sel0, ss => selct, mm => outHEX1
	);
	MUX0: ThreeBitSix2OneMUX port map(
		uu => sel0, vv => sel1, ww => sel2, xx => sel3, yy => sel4, zz => sel5, ss => selct, mm => outHEX0
	);

	
    HEX05: HELLO port map(c => outHEX5, HEXn => HEX5);
    HEX04: HELLO port map(c => outHEX4, HEXn => HEX4);
    HEX03: HELLO port map(c => outHEX3, HEXn => HEX3);
	 HEX02: HELLO port map(c => outHEX2, HEXn => HEX2);
	 HEX01: HELLO port map(c => outHEX1, HEXn => HEX1);
	 HEX00: HELLO port map(c => outHEX0, HEXn => HEX0);
	

end architecture;
