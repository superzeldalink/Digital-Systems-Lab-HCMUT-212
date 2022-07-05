library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Exc1 is
	port(
		SW   : in STD_LOGIC_VECTOR(9 downto 0);
		LEDR : out STD_LOGIC_VECTOR(9 downto 0)
	);
end entity;

architecture behavior of Exc1 is
begin
	LEDR <= SW;
end architecture;