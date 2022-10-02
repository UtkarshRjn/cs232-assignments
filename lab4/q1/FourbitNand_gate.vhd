library ieee;
use ieee.std_logic_1164.all;

entity FourbitNand_gate is
	port (a,b: in std_logic_vector(3 downto 0); c: out std_logic_vector(3 downto 0));
end entity;

architecture FourbitNand_arc of FourbitNand_gate is
begin
	c <= not (a and b);
	
end architecture;