library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
entity Exc2_tb is
end entity;

architecture behave of Exc2_tb is
    signal SIGs : std_logic := '0';
    signal SIGx : std_logic := '0';
    signal SIGy : std_logic := '0';
    signal SIGm : std_logic;

    signal count : std_logic_vector(2 downto 0) := "000";

    component Exc2 is
        port(
            s : in std_logic;
            x : in std_logic;
            y : in std_logic;
            m : out std_logic
        );
    end component;

begin
    Exc : Exc2
        port map (
            x => SIGx,
            s => SIGs,
            y => SIGy,
            m => SIGm
        );

    
    SIGs <= count(2);
    SIGx <= count(1);
    SIGy <= count(0);

    process is
    begin
        count <= count + 1;
        wait for 10 ps;
    end process;

end behave;