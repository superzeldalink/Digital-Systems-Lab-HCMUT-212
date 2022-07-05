LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Exc1 IS
	PORT (
		clk, w, rstN : IN STD_LOGIC;
		LED : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		z : OUT STD_LOGIC
	);
END Exc1;

ARCHITECTURE arch OF Exc1 IS
	SIGNAL D, Q, prsV, clrV : STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL rst : STD_LOGIC;
	COMPONENT NineDFF IS
		PORT (
			NClk, Nen : IN STD_LOGIC;
			ND, Nprs, Nclr : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
			NQ : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
		);
	END COMPONENT;
BEGIN
	rst <= NOT(rstN);

	D(8) <= w AND (Q(7) OR Q(8));
	D(7) <= Q(6) AND w;
	D(6) <= Q(5) AND w;
	D(5) <= w AND NOT(Q(5) OR Q(6) OR Q(7) OR Q(8));
	D(4) <= NOT(w) AND (Q(3) OR Q(4));
	D(3) <= Q(2) AND NOT(w);
	D(2) <= Q(1) AND NOT(w);
	D(1) <= NOT(Q(1) OR Q(2) OR Q(3) OR Q(4) OR w);
	D(0) <= '0';
	z <= Q(4) OR Q(8);

	-- FOR MODIFIED ONE-HOT
	--	D(8) <= w AND (Q(7) OR Q(8));
	--	D(7) <= Q(6) AND w;
	--	D(6) <= Q(5) AND w;
	--	D(5) <= w AND (NOT(Q(5) OR Q(6) OR Q(7) OR Q(8)));
	--	D(4) <= NOT(w) AND (Q(3) OR Q(4));
	--	D(3) <= Q(2) AND NOT(w);
	--	D(2) <= Q(1) AND NOT(w);
	--	D(1) <= NOT(Q(1) OR Q(2) OR Q(3) OR Q(4) OR w);
	--	D(0) <= '1';
	--	z <= Q(4) OR Q(8);

	LED <= Q;

	prsV <= "000000001" WHEN rst = '1' ELSE "000000000";
	clrV <= "111111110" WHEN rst = '1' ELSE "000000000";

	-- FOR MODIFIED ONE-HOT
	--	prsV <= "000000000" WHEN rst = '1' ELSE "000000000";
	--	clrV <= "111111111" WHEN rst = '1' ELSE "000000000";

	NDFF : NineDFF PORT MAP(
		NClk => clk, Nprs => prsV, Nclr => clrV,
		Nen => '1', ND => D, NQ => Q
	);
END ARCHITECTURE;