library IEEE;
use IEEE.std_logic_1164.all;

entity mux2 is 
port(
	a0		: in std_logic;
	a1		: in std_logic;
	sel	: in std_logic;
	b		: out std_logic);
end mux2;

architecture rtl of mux2 is
	-- declarative part: empty
begin
	b <= a0 when (sel = '0') else
		  a1;
end rtl;