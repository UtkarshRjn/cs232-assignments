library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity CarryLookAheadAdd is
port (a, b: in std_logic_vector (3 downto 0);
		sel: in std_logic;
		result: out std_logic_vector (7 downto 0));
end entity;

architecture  CarryLookAheadAdd_arc of  CarryLookAheadAdd  is
-- Component Declaration
	component FourbitXor_gate is
		port (a,b: in std_logic_vector(3 downto 0); c: out std_logic_vector(3 downto 0));
	end component;

-- Signal Declaration
	signal p,g,xb : std_logic_vector(3 downto 0);
	signal sel4 : std_logic_vector(3 downto 0);
	signal c : std_logic_vector(4 downto 0);
	
begin
-- Instantiation
	
	sel4 <= (others => sel);
	XorInst1: FourbitXor_gate port map(a=>b,b=>sel4,c=>xb);
	XorInst2: FourbitXor_gate port map(a=>xb,b=>a,c=>p);
	g <= a and xb;	
	
	c(0) <= sel;
	c(1) <= g(0) or (p(0) and sel);
	c(2) <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and sel);
	c(3) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and sel);
	c(4) <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0)) or (p(3) and p(2) and p(1) and p(0) and sel);
	
	XorInst3: FourbitXor_gate port map(a=>p,b=>c(3 downto 0),c=>result(3 downto 0));
	result(4) <= c(4);
	result(7 downto 5) <= (others => '-');
	
end  CarryLookAheadAdd_arc ;