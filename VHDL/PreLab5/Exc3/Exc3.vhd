LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc3 IS
    PORT (
        clk : IN STD_LOGIC;
        SW : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        LEDR : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
    );
END Exc3;

ARCHITECTURE arch OF Exc3 IS
    -- signal to store received data
    SIGNAL temp_data : STD_LOGIC_VECTOR (8 DOWNTO 0);
    SIGNAL temp_addr : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
    user_ROM : ENTITY work.myROM PORT MAP (addr => temp_addr, data => temp_data);

    LEDR <= temp_data; -- display on LEDs

    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            temp_addr <= SW;
        END IF;
    END PROCESS;
END arch;