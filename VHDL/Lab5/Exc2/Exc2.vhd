LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc2 IS
	PORT (
		clk, rstN : IN STD_LOGIC;
		run, done : BUFFER STD_LOGIC;
		addrout : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		dataOut : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		R0out, R1out, Aout, Gout, IRout : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		busWires : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
	);
END Exc2;

ARCHITECTURE arch OF Exc2 IS
	-- signal to store received data
	SIGNAL data, nextData : STD_LOGIC_VECTOR (9 DOWNTO 0);
	SIGNAL IR : STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL addr : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	SIGNAL mclk, isIR : STD_LOGIC;

	TYPE states IS (T0, T1);
	SIGNAL state : states;

	COMPONENT Exc1 IS
		PORT (
			R0out, R1out, Aout, Gout, IRout : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
			DIN : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
			rstN, clk, run : IN STD_LOGIC;
			done : BUFFER STD_LOGIC;
			BusWires : BUFFER STD_LOGIC_VECTOR(8 DOWNTO 0)
		);
	END COMPONENT;
BEGIN
	user_ROM : ENTITY work.myROM PORT MAP (addr, data, nextData);

	processor : Exc1 PORT MAP(R0out, R1out, Aout, Gout, IRout, IR, rstN, clk, run, done, busWires);

	run <= data(9);
	IR <= data(8 DOWNTO 0);

	addrout <= addr;
	dataOut <= data;

	PROCESS (clk, rstN, done)
	BEGIN
		IF rstN = '0' THEN
			state <= T0;
			addr <= "00000";
		ELSIF falling_edge(clk) THEN
			CASE state IS
				WHEN T0 =>
					addr <= STD_LOGIC_VECTOR(UNSIGNED(addr) + 1);
					state <= T1;
				WHEN T1 =>
					IF done = '1' THEN
						IF nextData(9) = '0' THEN
							addr <= STD_LOGIC_VECTOR(UNSIGNED(addr) + 1);
						END IF;
						state <= T0;
					ELSE
						state <= T1;
					END IF;
			END CASE;
		END IF;
	END PROCESS;
END arch;