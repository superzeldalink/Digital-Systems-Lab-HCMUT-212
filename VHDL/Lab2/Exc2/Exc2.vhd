LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc2 IS
    PORT (
        an : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        bn : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        cin : IN STD_LOGIC;
		  HEXo0 : out std_logic_vector(0 to 6);
		  HEXo1 : out std_logic_vector(0 to 6);
		  HEXo3 : out std_logic_vector(0 to 6);
		  HEXo5 : out std_logic_vector(0 to 6);
		  error : out std_logic;
		  sum : out std_logic_vector(4 downto 0)
    );
END ENTITY;

ARCHITECTURE arch OF Exc2 IS
    SIGNAL cn : STD_LOGIC_VECTOR(4 DOWNTO 1);
	 SIGNAL sn : STD_LOGIC_VECTOR(4 DOWNTO 0);
	 SIGNAL errorA, errorB : std_logic;
    COMPONENT FA IS
        PORT (
            a : IN STD_LOGIC;
            b : IN STD_LOGIC;
            ci : IN STD_LOGIC;
            s : OUT STD_LOGIC;
            co : OUT STD_LOGIC
        );
    END COMPONENT;
	 
	 COMPONENT BCDDisplay is
		 port(
			  V : in std_logic_vector(4 downto 0);
			  HEX0 : out std_logic_vector(0 to 6);
			  HEX1 : out std_logic_vector(0 to 6)
		 );
	end COMPONENT;
	
	component BCD is
	  port (
		 c : in std_logic_vector(4 downto 0);
		 HEXn : out std_logic_vector(0 to 6)
	  ) ;
	end component;
	
	component Comparator is
        port(
			compIn : in std_logic_vector(4 downto 0);
			compOut : out std_logic
		);
    end component;
BEGIN
	HEX5: BCD port map(c => '0' & an, HEXn => HEXo5);
	HEX3: BCD port map(c => '0' & bn, HEXn => HEXo3);

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

    sn(4) <= cn(4);
	 sum <= sn;
	 
	 BCDHEX : BCDDisplay port map (V => sn, HEX0 => HEXo0, HEX1 => HEXo1);
	 errorLED0 : Comparator port map (compIn => '0' & an, compOut => errorA);
	 errorLED1 : Comparator port map (compIn => '0' & bn, compOut => errorB);
	 
	 error <= errorA or errorB;
END ARCHITECTURE;
