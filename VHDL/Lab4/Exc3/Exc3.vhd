LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc3 IS
    PORT (
        inp, clk, rstN : IN STD_LOGIC;
        z : OUT STD_LOGIC
    );
END Exc3;

ARCHITECTURE arch OF Exc3 IS
    SIGNAL L1 : STD_LOGIC_VECTOR(0 TO 3);
	 SIGNAL waitFourClocks : UNSIGNED(2 DOWNTO 0) := "100";
    SIGNAL en : STD_LOGIC;
    COMPONENT FourBitShiftReg IS
        PORT (
            SRegclk, SReginp, SRegrstN : IN STD_LOGIC;
            SRegL : OUT STD_LOGIC_VECTOR(0 TO 3)
        );
    END COMPONENT;
BEGIN
	PROCESS(clk)
	BEGIN
		if rstN = '0' then
			waitFourClocks <= "100";
		elsif rising_edge(clk) and waitFourClocks /= 0 then
			waitFourClocks <= waitFourClocks - 1;
		end if;
	END PROCESS;
	en <= '1' WHEN waitFourClocks = 0 ELSE '0';
    SR1 : FourBitShiftReg PORT MAP(SRegclk => clk, SReginp => inp, SRegrstN => rstN, SRegL => L1);

    z <= '1' WHEN (L1 = "1111" OR L1 = "0000") AND en = '1' ELSE '0';
END ARCHITECTURE;