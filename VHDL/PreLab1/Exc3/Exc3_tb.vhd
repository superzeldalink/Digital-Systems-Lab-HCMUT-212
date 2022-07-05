library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
entity Exc3_tb is
end entity;

architecture behave of Exc3_tb is
    signal SIGc : std_logic_vector(1 downto 0) := "00";
    signal SIGhex : std_logic_vector(0 to 6);

    component Exc3 is
        port (
            c : in std_logic_vector(1 downto 0);
            HEX0 : out std_logic_vector(0 to 6)
        ) ;
    end component;

begin
    Exc : Exc3
        port map (
            c => SIGc,
            HEX0 => SIGhex
        );

    process is
    begin
        SIGc <= SIGc + 1;
        wait for 10 ps;
    end process;

end behave;