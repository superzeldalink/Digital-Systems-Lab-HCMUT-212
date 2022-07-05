LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ctrlunitFSM IS
    PORT (
        SIGNAL rin : OUT STD_LOGIC_VECTOR(0 TO 7);
        SIGNAL ain, gin, IRin, addrin, doutin, addsub, incr : OUT STD_LOGIC;
        SIGNAL zero : IN STD_LOGIC;
        SIGNAL IR : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        SIGNAL outsel : OUT INTEGER RANGE 0 TO 10;
        SIGNAL rst, clk : IN STD_LOGIC;
        SIGNAL done : BUFFER STD_LOGIC;
        SIGNAL W : OUT STD_LOGIC
    );
END ctrlunitFSM;

ARCHITECTURE arch OF ctrlunitFSM IS
    TYPE State_type IS (fetch, T0, T1, T2, T3, haltState);
    SIGNAL Tstep_Q, Tstep_D : State_type;

    SIGNAL opcode : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL RX, RY : NATURAL RANGE 0 TO 7;
    SIGNAL halt : STD_LOGIC;
BEGIN
    opcode <= IR(8 DOWNTO 6);
    RX <= TO_INTEGER(UNSIGNED(IR(5 DOWNTO 3)));
    RY <= TO_INTEGER(UNSIGNED(IR(2 DOWNTO 0)));
    statetable :
    PROCESS (Tstep_D)
    BEGIN
        CASE Tstep_D IS
            WHEN fetch =>
                Tstep_Q <= T0;
            WHEN T0 =>
                Tstep_Q <= T1;
                -- data IS loaded into IR IN this TIME step
            WHEN T1 =>
                IF done = '1' THEN
                    TStep_Q <= fetch;
                ELSIF halt = '1' THEN
                    TStep_Q <= haltState;
                ELSE
                    Tstep_Q <= T2;
                END IF;
            WHEN T2 =>
                IF done = '1' THEN
                    TStep_Q <= fetch;
                ELSE
                    Tstep_Q <= T3;
                END IF;
            WHEN T3 =>
                IF done = '1' THEN
                    TStep_Q <= fetch;
                ELSE
                    -- ERROR
                END IF;
            WHEN haltState =>
                TStep_Q <= haltState;
            WHEN OTHERS => NULL;
        END CASE;
    END PROCESS;

    -- 000 Rx Ry            mv Rx, Ry             Rx <- Ry
    -- 001 Rx xxx           mvi Rx, nextDIN       Rx <- nextDIN
    -- 010 Rx Ry            add Rx, Ry            Rx <- Rx + Ry
    -- 011 Rx Ry            sub Rx, Ry            Rx <- Rx - Ry
    -- 100 Rx Ry            ld Rx, Ry             Rx <- rom[Ry]
    --+Load from 10xxxxxxx: button
    --+Load from 11xxxxxxx: SW
    -- 101 Rx Ry            st Rx, Ry             rom[Ry] <- Rx
    --+Store to  10xxxxxxx: display on HEX
    -- 110 Rx Ry            mvnz Rx, Ry           Rx <- Ry if G /= 0
    -- 111 111 111          halt

    controlsignals :
    PROCESS (Tstep_D, IR, opcode, RX, RY)
    BEGIN
        rin <= (OTHERS => '0');
        IRin <= '0';
        ain <= '0';
        gin <= '0';
        addrin <= '0';
        doutin <= '0';
        W <= '0';
        incr <= '0';
        done <= '0';
        -- outsel <= 10;
        addsub <= '0';
        halt <= '0';
        CASE Tstep_D IS
            WHEN fetch =>
                addrin <= '1';
                outsel <= 7;
            WHEN T0 =>
                incr <= '1';
                IRin <= '1';
                outsel <= 9;
            WHEN T1 =>
                CASE opcode IS
                    WHEN "000" =>
                        outsel <= RY;
                        rin(RX) <= '1';
                        done <= '1';

                    WHEN "001" =>
                        incr <= '1';
                        addrin <= '1';
                        outsel <= 7;

                    WHEN "010" | "011" =>
                        outsel <= RX;
                        ain <= '1';

                    WHEN "100" | "101" =>
                        outsel <= RY;
                        addrin <= '1';

                    WHEN "110" =>
                        outsel <= 8;

                    WHEN "111" =>
                        halt <= '1';

                    WHEN OTHERS => NULL;
                END CASE;
            WHEN T2 =>
                CASE opcode IS
                    WHEN "010" =>
                        outsel <= RY;
                        gin <= '1';

                    WHEN "001" =>
                        outsel <= 9;
                        rin(RX) <= '1';
                        done <= '1';

                    WHEN "011" =>
                        outsel <= RY;
                        gin <= '1';
                        addsub <= '1';

                    WHEN "100" =>
                        outsel <= 9;
                        rin(RX) <= '1';
                        done <= '1';

                    WHEN "101" =>
                        outsel <= RX;
                        doutin <= '1';

                    WHEN "110" =>
                        done <= zero;

                    WHEN OTHERS => NULL;
                END CASE;
            WHEN T3 =>
                done <= '1';
                CASE opcode IS
                    WHEN "010" | "011" =>
                        outsel <= 8;
                        rin(RX) <= '1';
                    WHEN "101" =>
                        W <= '1';
                    WHEN "110" =>
                        outsel <= RY;
                        rin(RX) <= '1';
                    WHEN OTHERS => NULL;
                END CASE;
            WHEN OTHERS => NULL;
        END CASE;
    END PROCESS;
    flipflops : PROCESS (clk, rst, Tstep_Q)
    BEGIN
        IF rst = '1' THEN
            Tstep_D <= fetch;
        ELSIF rising_edge(clk) THEN
            Tstep_D <= Tstep_Q;
        END IF;
    END PROCESS;
END ARCHITECTURE;
