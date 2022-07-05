LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY myROM IS
    GENERIC (
        addr_width : INTEGER := 32; -- store 32 elements
        addr_bits : INTEGER := 5; -- required bits to store 32 elements
        data_width : INTEGER := 10 -- each element has 10-bits
    );
    PORT (
        addr : IN STD_LOGIC_VECTOR(addr_bits - 1 DOWNTO 0);
        data, nextData : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
    );
END myROM;

ARCHITECTURE arch OF myROM IS

    TYPE rom_type IS ARRAY (0 TO addr_width - 1) OF STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);

    SIGNAL user_ROM : rom_type;

    SIGNAL address : INTEGER RANGE 0 TO addr_width - 1;

    -- note that 'ram_init_file' is not the user-defined name (it is attribute name)
    ATTRIBUTE ram_init_file : STRING;
    -- "rom_data.mif" is the relative address with respect to project directory
    -- suppose ".mif" file is saved in folder "ROM", then use "ROM/rom_data.mif"
    ATTRIBUTE ram_init_file OF user_ROM : SIGNAL IS "rom_data.mif";

BEGIN
    address <= to_integer(unsigned(addr));
    data <= user_ROM (address);
    nextData <= user_ROM (address + 1);
END arch;