LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY Exc2 IS PORT (
    w, clk, rst : IN STD_LOGIC;
    x : OUT STD_LOGIC
);
END Exc2;

ARCHITECTURE Behavior OF Exc2 IS
    TYPE State_type IS (A, B, C, D, E, F, G, H, I);
    --ATTRIBUTE syn_encoding : STRING;
    --ATTRIBUTE syn_encoding OF State_type : TYPE IS "0000 0001 0010 0011 0100 0101 0110 0111 1000";

    SIGNAL y_Q, Y_D : State_type;
BEGIN
    PROCESS (w, y_D)
    BEGIN
        CASE y_D IS
            WHEN A =>
                IF (w = '0') THEN
                    y_Q <= B;
                ELSE
                    y_Q <= F;
                END IF;

            WHEN B =>
                IF (w = '0') THEN
                    y_Q <= C;
                ELSE
                    y_Q <= F;
                END IF;

            WHEN C =>
                IF (w = '0') THEN
                    y_Q <= D;
                ELSE
                    y_Q <= F;
                END IF;

            WHEN D =>
                IF (w = '0') THEN
                    y_Q <= E;
                ELSE
                    y_Q <= F;
                END IF;

            WHEN E =>
                IF (w = '0') THEN
                    y_Q <= E;
                ELSE
                    y_Q <= F;
                END IF;

                -------------------------
            WHEN F =>
                IF (w = '1') THEN
                    y_Q <= G;
                ELSE
                    y_Q <= B;
                END IF;

            WHEN G =>
                IF (w = '1') THEN
                    y_Q <= H;
                ELSE
                    y_Q <= B;
                END IF;

            WHEN H =>
                IF (w = '1') THEN
                    y_Q <= I;
                ELSE
                    y_Q <= B;
                END IF;

            WHEN I =>
                IF (w = '1') THEN
                    y_Q <= I;
                ELSE
                    y_Q <= B;
                END IF;
        END CASE;
    END PROCESS;
    x <= '1' WHEN y_D = E OR y_D = I ELSE '0';

    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            Y_D <= A;
        ELSE
            IF rising_edge(clk) THEN
                y_D <= y_Q;
            END IF;
        END IF;
    END PROCESS;
END Behavior;