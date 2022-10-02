library ieee;
use ieee.std_logic_1164.all;

entity FourbitXor_gate is
	port (a,b: in std_logic_vector(3 downto 0); c: out std_logic_vector(3 downto 0));
end entity;

architecture FourbitXor_arc of FourbitXor_gate is
	
	signal p,q : std_logic_vector(3 downto 0);
begin	

	p <= not (a and b);
	q <= a or b;
	c <= p and q;

end architecture;