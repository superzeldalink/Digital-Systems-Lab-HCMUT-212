LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ctrlunitFSM IS
    PORT (
        SIGNAL rin : OUT STD_LOGIC_VECTOR(0 TO 7);
        SIGNAL ain, gin, IRin, IR2in, addrin, doutin, cmpin, carryin, PCin, G16in, devoutin, PCmode, incr : OUT STD_LOGIC;
        SIGNAL flags : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL IR, IR2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        SIGNAL addrsel : OUT INTEGER RANGE 0 TO 2;
        SIGNAL outsel : OUT INTEGER RANGE 0 TO 13;
        SIGNAL MUX16sel : OUT INTEGER RANGE 0 TO 1;
        SIGNAL alusel : OUT NATURAL RANGE 0 TO 8;
        SIGNAL devsel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        SIGNAL rst, clk : IN STD_LOGIC;
        SIGNAL done : BUFFER STD_LOGIC;
        SIGNAL W : OUT STD_LOGIC
    );
END ctrlunitFSM;

ARCHITECTURE arch OF ctrlunitFSM IS
    TYPE State_type IS (fetch, T0, T1, T2, T3, T4, T5, T6, haltState);
    SIGNAL Tstep_Q, Tstep_D : State_type;

    SIGNAL opcode, misc : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL mode : STD_LOGIC;
    SIGNAL RXt : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL RX, RY : NATURAL RANGE 0 TO 7;
    SIGNAL halt, brEnabled : STD_LOGIC;
BEGIN
    opcode <= IR(7 DOWNTO 4);
    mode <= IR(3);
    RXt <= IR(2 DOWNTO 0);
    RX <= TO_INTEGER(UNSIGNED(RXt));
    RY <= TO_INTEGER(UNSIGNED(IR2(2 DOWNTO 0)));
    brEnabled <= (flags(2) AND RXt(2)) OR (flags(1) AND RXt(1)) OR (flags(0) AND RXt(0)) OR (RXt(2) AND RXt(1) AND RXt(0));
    misc <= mode & RXt;

    statetable :
    PROCESS (Tstep_D)
    BEGIN
        IF done = '1' THEN
            Tstep_Q <= fetch;
        ELSIF halt = '1' THEN
            TStep_Q <= haltState;
        ELSE
            CASE Tstep_D IS
                WHEN fetch =>
                    Tstep_Q <= T0;
                WHEN T0 =>
                    Tstep_Q <= T1;
                WHEN T1 =>
                    Tstep_Q <= T2;
                WHEN T2 =>
                    Tstep_Q <= T3;
                WHEN T3 =>
                    Tstep_Q <= T4;
                WHEN T4 =>
                    Tstep_Q <= T5;
                WHEN T5 =>
                    Tstep_Q <= T6;
                WHEN haltState =>
                    TStep_Q <= haltState;
                WHEN OTHERS => NULL;
            END CASE;
        END IF;
    END PROCESS;

    controlsignals :
    PROCESS (Tstep_D, IR, opcode, RX, RY)
    BEGIN
        rin <= (OTHERS => '0');
        IRin <= '0';
        IR2in <= '0';
        ain <= '0';
        gin <= '0';
        g16in <= '0';
        addrin <= '0';
        doutin <= '0';
        cmpin <= '0';
        carryin <= '0';
        PCin <= '0';
        devoutin <= '0';
        PCmode <= '0';
        W <= '0';
        incr <= '0';
        done <= '0';
        alusel <= 0;
        halt <= '0';
        CASE Tstep_D IS
            WHEN fetch =>
                outsel <= 13;
                addrin <= '1';
                addrsel <= 2;
            WHEN T0 =>
                incr <= '1';
                IRin <= '1';
                outsel <= 9;
            WHEN T1 =>
                CASE opcode IS
                    WHEN "0000" => -- mv
                        incr <= '1';
                        addrin <= '1';
                        addrsel <= 2;

                    WHEN "0001" | "0010" | "0011" | "0110" | "1000" | "1001" | "1010" | "1100" => -- add/sub/mul/cmp/not/tcpl/and/shifts/incdec
                        outsel <= RX;
                        ain <= '1';

                    WHEN "1101" => -- incc/decc
                        IF flags(3) = '0' THEN
                            done <= '1';
                        ELSE
                            outsel <= RX;
                            ain <= '1';
                        END IF;

                    WHEN "0100" | "0101" => -- ld/st
                        IF (mode = '1') THEN -- HL
                            addrsel <= 1;
                            addrin <= '1';
                        ELSE -- r
                            incr <= '1';
                            addrin <= '1';
                            addrsel <= 2;
                        END IF;

                    WHEN "0111" => -- br
                        IF (mode = '1') THEN -- HL
                            IF brEnabled = '1' THEN
                                PCin <= '1';
                                PCmode <= '1';
                            END IF;
                            done <= '1';
                        ELSE -- r
                            incr <= '1';
                            IF brEnabled = '1' THEN
                                addrin <= '1';
                                addrsel <= 2;
                            ELSE
                                done <= '1';
                            END IF;
                        END IF;

                    WHEN "1111" =>
                        CASE misc IS
                            WHEN "0000" | "0001" | "0010" | "0011" =>
                                devsel <= misc(1 DOWNTO 0);
                                outsel <= 12;
                                rin(7) <= '1';
                                done <= '1';
                            WHEN "0100" | "0101" | "0110" | "0111" =>
                                devsel <= misc(1 DOWNTO 0);
                                devoutin <= '1';
                                done <= '1';
                            WHEN "1110" => --lda
                                MUX16sel <= 1;
                                g16in <= '1';
                            WHEN "1111" => -- halt
                                halt <= '1';
                            WHEN OTHERS => NULL;
                        END CASE;

                    WHEN OTHERS => NULL;
                END CASE;
            WHEN T2 =>
                CASE opcode IS
                    WHEN "0000" => -- mv
                        IR2in <= '1';

                    WHEN "0001" | "0010" | "0011" | "0110" | "1001" => -- add/sub/mul/cmp/and
                        incr <= '1';
                        addrin <= '1';
                        addrsel <= 2;

                    WHEN "0100" => -- ld
                        IF (mode = '1') THEN -- HL
                            outsel <= 9;
                            rin(RX) <= '1';
                            done <= '1';
                        ELSE -- r
                            IR2in <= '1';
                        END IF;

                    WHEN "0101" => -- st
                        IF (mode = '1') THEN -- HL
                            outsel <= RX;
                            doutin <= '1';
                        ELSE -- r
                            IR2in <= '1';
                        END IF;

                    WHEN "0111" => -- br r
                        IR2in <= '1';

                    WHEN "1000" => -- not/tcpl
                        IF mode = '0' THEN -- not
                            alusel <= 2;
                        ELSE -- tcpl
                            alusel <= 8;
                        END IF;
                        gin <= '1';

                    WHEN "1010" => -- shifts
                        IF mode = '0' THEN
                            alusel <= 4;
                        ELSE
                            alusel <= 5;
                        END IF;
                        gin <= '1';

                    WHEN "1100" | "1101" => -- incdec/inccdecc
                        IF mode = '0' THEN
                            alusel <= 6;
                        ELSE
                            alusel <= 7;
                        END IF;
                        carryin <= '1';
                        gin <= '1';

                    WHEN "1111" =>
                        CASE misc IS
                            WHEN "1110" => --lda
                                outsel <= 10;
                                rin(5) <= '1';
                            WHEN OTHERS => NULL;
                        END CASE;

                    WHEN OTHERS => NULL;
                END CASE;
            WHEN T3 =>
                CASE opcode IS
                    WHEN "0000" => -- mv
                        IF mode = '1' THEN
                            outsel <= 9;
                        ELSE
                            outsel <= RY;
                        END IF;
                        rin(RX) <= '1';
                        done <= '1';

                    WHEN "0001" | "0010" | "0011" | "0110" | "1001" => -- add/sub/mul/cmp/and
                        IR2in <= '1';

                    WHEN "0100" => -- ld r
                        addrsel <= 0;
                        addrin <= '1';
                        outsel <= RY;

                    WHEN "0101" => -- st 
                        IF mode = '1' THEN -- HL
                            W <= '1';
                            done <= '1';
                        ELSE
                            addrsel <= 0;
                            addrin <= '1';
                            outsel <= RY;
                        END IF;

                    WHEN "0111" => -- br r
                        outsel <= RY;
                        PCin <= '1';
                        PCmode <= '0';
                        done <= '1';

                    WHEN "1000" | "1010" => -- not/tcpl/shifts
                        outsel <= 8;
                        rin(RX) <= '1';
                        done <= '1';

                    WHEN "1100" | "1101" => -- incdec/inccdecc
                        outsel <= 8;
                        rin(RX) <= '1';
                        done <= '1';

                    WHEN "1111" =>
                        CASE misc IS
                            WHEN "1110" => --lda
                                outsel <= 11;
                                rin(6) <= '1';
                                done <= '1';
                            WHEN OTHERS => NULL;
                        END CASE;
                    WHEN OTHERS => NULL;
                END CASE;

            WHEN T4 =>
                CASE opcode IS
                    WHEN "0001" | "0010" => -- add/sub
                        IF (opcode = "0010") THEN
                            alusel <= 1;
                        END IF;
                        IF (mode = '1') THEN -- imm8
                            outsel <= 9;
                        ELSE -- r
                            outsel <= RY;
                        END IF;
                        gin <= '1';
                        carryin <= '1';

                    WHEN "0011" => -- mul
                        IF (mode = '1') THEN -- imm8
                            outsel <= 9;
                        ELSE -- r
                            outsel <= RY;
                        END IF;
                        MUX16sel <= 0;
                        g16in <= '1';

                    WHEN "0100" => -- ld r
                        outsel <= 9;
                        rin(RX) <= '1';
                        done <= '1';

                    WHEN "0101" => -- st r
                        outsel <= RX;
                        doutin <= '1';

                    WHEN "0110" => -- cmp
                        IF (mode = '1') THEN -- imm8
                            outsel <= 9;
                        ELSE -- r
                            outsel <= RY;
                        END IF;
                        cmpin <= '1';
                        done <= '1';

                    WHEN "1001" => -- and
                        IF (mode = '1') THEN -- imm8
                            outsel <= 9;
                        ELSE -- r
                            outsel <= RY;
                        END IF;
                        alusel <= 3;
                        gin <= '1';

                    WHEN OTHERS => NULL;
                END CASE;

            WHEN T5 =>
                CASE opcode IS
                    WHEN "0001" | "0010" | "1001" => -- add/sub/and
                        outsel <= 8;
                        rin(RX) <= '1';
                        done <= '1';

                    WHEN "0011" => -- mul
                        outsel <= 10;
                        rin(5) <= '1';

                    WHEN "0101" => -- st r
                        W <= '1';
                        done <= '1';
                    WHEN OTHERS => NULL;
                END CASE;

            WHEN T6 =>
                CASE opcode IS
                    WHEN "0011" => -- mul
                        outsel <= 11;
                        rin(6) <= '1';
                        done <= '1';
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