library IEEE;
use IEEE.std_logic_1164.all;

entity EightbitMux2 is 
port(
	a0		: in std_logic_vector(7 downto 0);
	a1		: in std_logic_vector(7 downto 0);
	sel	: in std_logic;
	b		: out std_logic_vector(7 downto 0));
end entity;

architecture rtl of EightbitMux2 is
	-- declarative part: empty
begin
	b <= a0 when (sel = '0') else
		  a1;
end architecture;

