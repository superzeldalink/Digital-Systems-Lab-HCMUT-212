library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Exc5 is
    port(
        V : in std_logic_vector(3 downto 0);
		  HEX0 : out std_logic_vector(0 to 6);
		  HEX1 : out std_logic_vector(0 to 6)
    );
end entity;

architecture behave of Exc5 is

SIGNAL digit1, digit0 : std_logic_vector(3 downto 0);
	 
	 component BCD is
        port (
			 c : in std_logic_vector(3 downto 0);
			 HEXn : out std_logic_vector(0 to 6)
		  ) ;
    end component;
	 

begin
	digit1 <= "0000" when unsigned(V) < 10 else "0001";
	digit0 <= std_logic_vector(unsigned(V) - 10) when unsigned(V) >= 10 else std_logic_vector(unsigned(V));

	 HEX01: BCD port map(c => digit1, HEXn => HEX1);
	 HEX00: BCD port map(c => digit0, HEXn => HEX0);
	

end architecture;
