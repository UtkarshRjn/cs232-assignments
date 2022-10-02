library ieee;
use ieee.std_logic_1164.all;

entity FourbitNor_gate is
	port (a,b: in std_logic_vector(3 downto 0); c: out std_logic_vector(3 downto 0));
end entity;

architecture FourbitNor_arc of FourbitNor_gate is
begin
	c <= not (a or b);
	
end architecture;