LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY myROM IS
    GENERIC (
        addr_width : INTEGER := 8192; -- store 65536 elements
        addr_bits : INTEGER := 16; -- required bits to store 65536 elements
        data_width : INTEGER := 8 -- each element has 8-bits
    );
    PORT (
        addr : IN STD_LOGIC_VECTOR(addr_bits - 1 DOWNTO 0);
        dataOut : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
        dataIn : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
        WE, clk : IN STD_LOGIC
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
    -- ATTRIBUTE ram_init_file OF user_ROM : SIGNAL IS "rom_data.mif";
    ATTRIBUTE ram_init_file OF user_ROM : SIGNAL IS "rom/8bittest2.mif";

BEGIN
    address <= to_integer(unsigned(addr));
    dataOut <= user_ROM (address);
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) AND WE = '1' THEN
            user_ROM (address) <= dataIn;
        END IF;
    END PROCESS;
END arch;
