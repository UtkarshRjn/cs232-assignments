library ieee;
use ieee.std_logic_1164.all;

entity xor_gate is
	port (a,b: in std_logic; c: out std_logic);
end entity;

architecture xor_arc of xor_gate is
	signal p,q: std_logic;
begin
	p <= not (a and b);
	q <= a or b;
	c <= p and q;
	
end architecture;