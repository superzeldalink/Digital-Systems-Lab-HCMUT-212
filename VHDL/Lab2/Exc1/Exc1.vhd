LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc1 IS
    PORT (
        an : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        bn : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        cin : IN STD_LOGIC;
        sn : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        cout : OUT STD_LOGIC
    );
END Exc1;

ARCHITECTURE arch OF Exc1 IS
    SIGNAL cn : STD_LOGIC_VECTOR(4 DOWNTO 1);
    COMPONENT FA IS
        PORT (
            a : IN STD_LOGIC;
            b : IN STD_LOGIC;
            ci : IN STD_LOGIC;
            s : OUT STD_LOGIC;
            co : OUT STD_LOGIC
        );
    END COMPONENT;
BEGIN
	FA0 : FA PORT MAP(
            a => an(0),
            b => bn(0),
            ci => cin,
            s => sn(0),
            co => cn(1)
			);
    gen : FOR i IN 1 TO 3 GENERATE
        FAn : FA PORT MAP(
            a => an(i),
            b => bn(i),
            ci => cn(i),
            s => sn(i),
            co => cn(i + 1)
        );
    END GENERATE;

    cout <= cn(4);

END ARCHITECTURE;