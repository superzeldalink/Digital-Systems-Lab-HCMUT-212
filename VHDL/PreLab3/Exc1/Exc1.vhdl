LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY Exc1 IS
    PORT (
        a, b: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  c : IN STD_LOGIC;
        s : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        cout : OUT STD_LOGIC
    );
END Exc1;

ARCHITECTURE arch OF Exc1 IS
    SIGNAL sum : STD_LOGIC_VECTOR(8 DOWNTO 0);
BEGIN
    sum <= ('0' & a) + ('0' & b) + ("0000000" & c);
    s <= sum(7 DOWNTO 0);
    cout <= sum(8);
END ARCHITECTURE;