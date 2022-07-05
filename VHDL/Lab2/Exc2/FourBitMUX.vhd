library ieee;
use ieee.std_logic_1164.all;

entity FourBitMUX is
    port(
        fourBitMuxIn1 : in std_logic_vector(4 downto 0);
        fourBitMuxIn2 : in std_logic_vector(4 downto 0);
        fourBitMuxSel : in std_logic;
        fourBitMuxOut : out std_logic_vector(4 downto 0)
    );
end entity;

architecture arch of FourBitMUX is
    component MUX
        port(
            muxIn1 : in std_logic;
            muxSel : in std_logic;
            muxIn2 : in std_logic;
            muxOut : out std_logic
        );
    end component;
begin
    gen: for i in 4 downto 0 generate
        MUX2: MUX port map(
            muxSel => fourBitMuxSel,
            muxIn1 => fourBitMuxIn1(i),
            muxIn2 => fourBitMuxIn2(i),
            muxOut => fourBitMuxOut(i)
        );
    end generate;
end arch;
