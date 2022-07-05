LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ctrlunitFSM IS
    PORT (
        SIGNAL rin : OUT STD_LOGIC_VECTOR(0 TO 7);
        SIGNAL ain, gin, IRin, addsub : OUT STD_LOGIC;
        SIGNAL IR : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        SIGNAL outsel : OUT INTEGER RANGE 0 TO 10;
        SIGNAL run, rst, clk : IN STD_LOGIC;
        SIGNAL done : BUFFER STD_LOGIC
    );
END ctrlunitFSM;

ARCHITECTURE arch OF ctrlunitFSM IS
    TYPE State_type IS (T0, T1, T2, T3);
    SIGNAL Tstep_Q, Tstep_D : State_type;

    SIGNAL opcode : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL RX, RY : NATURAL RANGE 0 TO 7;
BEGIN
    opcode <= IR(8 DOWNTO 6);
    RX <= TO_INTEGER(UNSIGNED(IR(5 DOWNTO 3)));
    RY <= TO_INTEGER(UNSIGNED(IR(2 DOWNTO 0)));
    statetable :
    PROCESS (Tstep_D, run)
    BEGIN
        CASE Tstep_D IS
            WHEN T0 =>
                IF run = '0' THEN
                    Tstep_Q <= T0;
                ELSE
                    Tstep_Q <= T1;
                END IF;
                -- data IS loaded into IR IN this TIME step
            WHEN T1 =>
                IF done = '1' THEN
                    TStep_Q <= T0;
                ELSE
                    Tstep_Q <= T2;
                END IF;
            WHEN T2 =>
                Tstep_Q <= T3;
            WHEN T3 =>
                IF done = '1' THEN
                    TStep_Q <= T0;
                ELSE
                    -- ERROR
                END IF;
            WHEN OTHERS => NULL;
        END CASE;
    END PROCESS;

    controlsignals :
    PROCESS (Tstep_D, IR, opcode, RX, RY)
    BEGIN
        rin <= (OTHERS => '0');
		  IRin <= '0';
        ain <= '0';
        gin <= '0';
        outsel <= 10;
        addsub <= '0';
        CASE Tstep_D IS
            WHEN T0 => -- store DIN IN IR as long as Tstep_Q = 0
                IRin <= '1';
                done <= '0';
                outsel <= 9;
            WHEN T1 =>
                CASE opcode IS
                    WHEN "000" =>
                        outsel <= RY;
                        done <= '1';
                        rin(RX) <= '1';
                    WHEN "001" =>
                        outsel <= 9;
                        done <= '1';
                        rin(RX) <= '1';
                    WHEN "010" | "011" =>
                        outsel <= RX;
                        ain <= '1';
                    WHEN OTHERS => NULL;
                END CASE;
            WHEN T2 =>
                CASE opcode IS
                    WHEN "010" =>
                        outsel <= RY;
                        gin <= '1';
                    WHEN "011" =>
                        outsel <= RY;
                        gin <= '1';
                        addsub <= '1';
                    WHEN OTHERS => NULL;
                END CASE;
            WHEN T3 =>
                CASE opcode IS
                    WHEN "010" | "011" =>
                        outsel <= 8;
                        rin(RX) <= '1';
                        done <= '1';
                    WHEN OTHERS => NULL;
                END CASE;
            WHEN OTHERS => NULL;
        END CASE;
    END PROCESS;
    flipflops : PROCESS (clk, rst, Tstep_Q)
    BEGIN
        IF rst = '1' THEN
            Tstep_D <= T0;
        ELSIF rising_edge(clk) THEN
            Tstep_D <= Tstep_Q;
        END IF;
    END PROCESS;
END ARCHITECTURE;