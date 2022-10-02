library ieee;
use ieee.std_logic_1164.all;

entity FourbitXnor_gate is
	port (a,b: in std_logic_vector(3 downto 0); c: out std_logic_vector(3 downto 0));
end entity;

architecture FourbitXnor_arc of FourbitXnor_gate is
	signal p,q: std_logic_vector(3 downto 0);
begin
	p <= not (a or b);
	q <= a and b;
	c <= p or q;
	
end architecture;