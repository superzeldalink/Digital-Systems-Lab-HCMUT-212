LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY devices IS
    PORT (
        clk, rst, en : IN STD_LOGIC;
        SW : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        LED : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
        R7, H, L : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        devout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END devices;

ARCHITECTURE arch OF devices IS
    SIGNAL hd16_5, hd16_4, hd16_3, hd16_2, hd16_1, hd16_0 : STD_LOGIC_VECTOR(0 TO 6);
    SIGNAL hh5, hh4, hh3, hh2, hh1, hh0 : STD_LOGIC_VECTOR(0 TO 6);
    SIGNAL hd5, hd4, hd3, hd2, hd1, hd0 : STD_LOGIC_VECTOR(0 TO 6);
    SIGNAL HL : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');

    COMPONENT BCDDisplay IS
        PORT (
            V : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6)
        );
    END COMPONENT;

    COMPONENT HEXDisplay IS
        PORT (
            c : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            HEXn : OUT STD_LOGIC_VECTOR(0 TO 6)
        );
    END COMPONENT;

BEGIN
    HL <= H & L;
    bcd : BCDDisplay PORT MAP("00000000" & R7, hd5, hd4, hd3, hd2, hd1, hd0);
    bcd16 : BCDDisplay PORT MAP(HL, hd16_5, hd16_4, hd16_3, hd16_2, hd16_1, hd16_0);

    hh5 <= "1111111";
    hh4 <= "1111111";
    hexh3 : HEXDisplay PORT MAP(HL(15 DOWNTO 12), hh3);
    hexh2 : HEXDisplay PORT MAP(HL(11 DOWNTO 8), hh2);
    hexh1 : HEXDisplay PORT MAP(HL(7 DOWNTO 4), hh1);
    hexh0 : HEXDisplay PORT MAP(HL(3 DOWNTO 0), hh0);

    devout <=
        "0000" & KEY WHEN sel = "00" ELSE
        SW WHEN sel = "01" ELSE
        "00000000";

    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            HEX5 <= (OTHERS => '1');
            HEX4 <= (OTHERS => '1');
            HEX3 <= (OTHERS => '1');
            HEX2 <= (OTHERS => '1');
            HEX1 <= (OTHERS => '1');
            HEX0 <= (OTHERS => '1');
				LED <= "00000000";
        ELSE
            IF rising_edge(clk) AND en = '1' THEN
                CASE sel IS
                    WHEN "00" =>
                        LED <= R7;
                    WHEN "01" =>
                        HEX5 <= hd5;
                        HEX4 <= hd4;
                        HEX3 <= hd3;
                        HEX2 <= hd2;
                        HEX1 <= hd1;
                        HEX0 <= hd0;
                    WHEN "10" =>
                        HEX5 <= hd16_5;
                        HEX4 <= hd16_4;
                        HEX3 <= hd16_3;
                        HEX2 <= hd16_2;
                        HEX1 <= hd16_1;
                        HEX0 <= hd16_0;
                    WHEN "11" =>
                        HEX5 <= hh5;
                        HEX4 <= hh4;
                        HEX3 <= hh3;
                        HEX2 <= hh2;
                        HEX1 <= hh1;
                        HEX0 <= hh0;
                    WHEN OTHERS => NULL;
                END CASE;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;