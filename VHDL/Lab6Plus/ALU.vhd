LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU IS
    PORT (
        SIGNAL A, B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        SIGNAL alusel : IN NATURAL RANGE 0 TO 8;
        SIGNAL carry : OUT STD_LOGIC;
        SIGNAL C : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ALU;

ARCHITECTURE arch OF ALU IS
    SIGNAL result : STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL nota, aandb, slefta, srighta : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
    gen : FOR i IN 7 DOWNTO 0 GENERATE
        nota(i) <= NOT(a(i));
        aandb(i) <= a(i) AND b(i);
    END GENERATE;
    slefta <= a(6 DOWNTO 0) & '0';
    srighta <= '0' & a(7 DOWNTO 1);

    result <=
        STD_LOGIC_VECTOR(UNSIGNED('0' & A) + UNSIGNED('0' & B)) WHEN alusel = 0 ELSE
        STD_LOGIC_VECTOR(UNSIGNED('0' & A) - UNSIGNED('0' & B)) WHEN alusel = 1 ELSE
        '0' & nota WHEN alusel = 2 ELSE
        '0' & aandb WHEN alusel = 3 ELSE
        '0' & slefta WHEN alusel = 4 ELSE
        '0' & srighta WHEN alusel = 5 ELSE
        STD_LOGIC_VECTOR(UNSIGNED('0' & A) + 1) WHEN alusel = 6 ELSE
        STD_LOGIC_VECTOR(UNSIGNED('0' & A) - 1) WHEN alusel = 7 ELSE 
        '0' & STD_LOGIC_VECTOR(UNSIGNED(nota) + 1) WHEN alusel = 8;

    C <= result(7 DOWNTO 0);
    carry <= result(8);
END ARCHITECTURE;