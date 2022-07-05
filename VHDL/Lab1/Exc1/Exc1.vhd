library ieee;
use ieee.std_logic_1164.all;

entity Exc1 is
    port(
        x : in std_logic_vector(3 downto 0);
        y : in std_logic_vector(3 downto 0);
        s : in std_logic;
		  sOUT : out std_logic;
        m : out std_logic_vector(3 downto 0)
    );
end entity;

architecture behave of Exc1 is
    component MUX is
        port(
            a : in std_logic;
            sel : in std_logic;
            b : in std_logic;
            z : out std_logic
        );
    end component;

begin
	 sOUT <= s;
    gen: for i in 3 downto 0 generate 
        MUX4: MUX port map(
            a => x(i),
            b => y(i),
            sel => s,
            z => m(i)
        );
    end generate;

end architecture;