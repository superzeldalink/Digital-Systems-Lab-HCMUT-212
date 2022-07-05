LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc4 IS
	PORT (
		letter : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		LED : OUT STD_LOGIC;
		clk, btnN, rstN : IN STD_LOGIC
	);
END Exc4;

ARCHITECTURE arch OF Exc4 IS
	SIGNAL morseCode : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL morseLength : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL bitIn, btn, rst : STD_LOGIC := '0';

	SIGNAL ticks, ticksToWait : INTEGER RANGE 0 TO 50000000 := 0; -- Change 200 to 50000000 if running on DE10.

	TYPE State_type IS (idle, store, shift, setWaitInterval, waitT, waitLEDOff, checkSize);
	SIGNAL state : State_type := idle;
	COMPONENT DFFn IS
		PORT (
			Din, DClk, Den : IN STD_LOGIC;
			DQ : OUT STD_LOGIC);
	END COMPONENT;

BEGIN
	btn <= NOT(btnN);
	rst <= NOT(rstN);
	PROCESS (clk, rst) IS
	BEGIN
		IF rst = '1' THEN
			state <= idle;
		ELSE
			IF rising_edge(clk) THEN
				CASE state IS
					WHEN idle =>
						LED <= '0';
						IF btn = '1' THEN
							state <= store;
						ELSE
							state <= idle;
						END IF;

					WHEN store =>
						CASE letter IS
							WHEN "000" =>
								morseCode <= "0010";
								morseLength <= "010";
							WHEN "001" =>
								morseCode <= "0001";
								morseLength <= "100";
							WHEN "010" =>
								morseCode <= "0101";
								morseLength <= "100";
							WHEN "011" =>
								morseCode <= "0001";
								morseLength <= "011";
							WHEN "100" =>
								morseCode <= "0000";
								morseLength <= "001";
							WHEN "101" =>
								morseCode <= "0100";
								morseLength <= "100";
							WHEN "110" =>
								morseCode <= "0011";
								morseLength <= "011";
							WHEN "111" =>
								morseCode <= "0000";
								morseLength <= "100";
							WHEN OTHERS =>
								morseCode <= "0000";
								morseLength <= "000";
						END CASE;
						state <= shift;

					WHEN shift =>
						bitIn <= morseCode(0);
						morseCode <= '0' & morseCode(3 DOWNTO 1); -- Shift;
						morseLength <= STD_LOGIC_VECTOR(UNSIGNED(morseLength) - 1);
						state <= setWaitInterval;

					WHEN setWaitInterval =>
						-- clk at 200Hz
						-- ticksToWait = oldFreq / newFreq
						-- dot = 4Hz (0.25s), dash = 1Hz (1s)
						IF (bitIn = '0') THEN
							ticksToWait <= 12500000; -- On DE10: 50MHz / 4Hz = 12500000
						ELSE
							ticksToWait <= 50000000; -- On DE10: 50MHz / 1Hz = 50000000
						END IF;

						ticks <= 0; -- Reset ticks
						LED <= '1'; -- LED on
						state <= waitT;

					WHEN waitT =>
						IF ticks = ticksToWait - 1 THEN
							LED <= '0'; -- LED off
							ticks <= 0; -- Reset ticks
							state <= waitLEDOff;
							ticksToWait <= 25000000;
						ELSE
							ticks <= ticks + 1;
							state <= waitT;
						END IF;

					WHEN waitLEDOff =>
						IF ticks = ticksToWait - 1 THEN
							state <= checkSize;
							ticks <= 0; -- Reset ticks
						ELSE
							ticks <= ticks + 1;
							state <= waitLEDOff;
						END IF;

					WHEN checkSize =>
						IF morseLength = "000" THEN
							state <= idle;
						ELSE
							state <= shift;
						END IF;
				END CASE;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;
