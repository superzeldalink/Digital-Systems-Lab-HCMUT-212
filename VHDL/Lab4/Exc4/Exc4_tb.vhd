LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc4_tb IS
END ENTITY;

ARCHITECTURE sim OF Exc4_tb IS

	-- We're slowing down the clock to speed up simulation time
	CONSTANT ClockFrequencyHz : INTEGER := 200; -- 200 Hz
	CONSTANT ClockPeriod : TIME := 1000 ms / ClockFrequencyHz;

	SIGNAL letter : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
	SIGNAL LED : STD_LOGIC;
	SIGNAL clk : STD_LOGIC := '1';
	SIGNAL btnN : STD_LOGIC := '0';
	SIGNAL rstN : STD_LOGIC := '1';
BEGIN

	-- The Device Under Test (DUT)
	morse : ENTITY work.Exc4(arch)
		PORT MAP(
			letter => letter,
			LED => LED,
			clk => clk,
			btnN => btnN,
			rstN => rstN
		);

	-- Process for generating the clock
	Clk <= NOT Clk AFTER ClockPeriod / 2;

	PROCESS IS
	BEGIN
		WAIT UNTIL rising_edge(clk);
		btnN <= '0';
		WAIT UNTIL rising_edge(clk);
		btnN <= '1';
		WAIT FOR 5000 ms;
		letter <= STD_LOGIC_VECTOR(UNSIGNED(letter) + 1);
	END PROCESS;
END ARCHITECTURE;
