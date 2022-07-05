library ieee;
use ieee.std_logic_1164.all;

entity Exc5 is
    port(
        V : in std_logic_vector(3 downto 0);
		  HEX0 : out std_logic_vector(0 to 6);
		  HEX1 : out std_logic_vector(0 to 6)
    );
end entity;

architecture behave of Exc5 is

SIGNAL z : std_logic;
SIGNAL A, m : std_logic_vector(3 downto 0);

	component FourBitMUX is
		port(
			fourBitMuxIn1 : in std_logic_vector(3 downto 0);
			fourBitMuxIn2 : in std_logic_vector(3 downto 0);
			fourBitMuxSel : in std_logic;
			fourBitMuxOut : out std_logic_vector(3 downto 0)
		);
	end component;
	 
	 component Comparator is
        port(
			compIn : in std_logic_vector(3 downto 0);
			compOut : out std_logic
		);
    end component;

    component CircuitA is
        port(
			dIn : in std_logic_vector(3 downto 0);
			dOut : out std_logic_vector(3 downto 0)
		);
    end component;

    component BCD is
        port (
			 c : in std_logic_vector(3 downto 0);
			 HEXn : out std_logic_vector(0 to 6)
		  ) ;
    end component;
	 

begin
	 comp : Comparator port map(
		compIn => V,
		compOut => z
	 );

	 cirA: CircuitA port map(
		dIn => V,
		dOut => A
	 );

	 mux: FourBitMUX port map(
		fourBitMuxIn1 => V,
		fourBitMuxIn2 => A,
		fourBitMuxSel => z,
		fourBitMuxOut => m
	 );

	 HEX01: BCD port map(c => "000"&z, HEXn => HEX1);
	 HEX00: BCD port map(c => m, HEXn => HEX0);

end architecture;
