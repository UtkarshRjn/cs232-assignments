library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity FourbitComparator is
port (a, b: in std_logic_vector (3 downto 0);
		result: out std_logic_vector (7 downto 0));
end entity;

architecture FourbitComparator_arc of FourbitComparator is
-- Component Declaration
	component FourbitXnor_gate is
		port (a,b: in std_logic_vector(3 downto 0); c: out std_logic_vector(3 downto 0));
	end component;

-- Signal Declaration
	signal p : std_logic_vector(3 downto 0);
	
begin
-- Instantiation
	XnorInst1: FourbitXnor_gate port map (a=>a,b=>b,c=>p);
	
	result(2) <= (a(3) and (not b(3))) or (p(3) and a(2) and (not b(2))) or (p(3) and p(2) and a(1) and (not b(1))) or (p(3) and p(2) and p(1) and a(0) and (not b(0)));
	result(1) <= p(0) and p(1) and p(2) and p(3);
 	result(0) <= (b(3) and (not a(3))) or (p(3) and b(2) and (not a(2))) or (p(3) and p(2) and b(1) and (not a(1))) or (p(3) and p(2) and p(1) and b(0) and (not a(0)));
	
	result(7 downto 3) <= (others => '-');
end architecture;