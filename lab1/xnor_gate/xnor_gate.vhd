library ieee;
use ieee.std_logic_1164.all;

entity xnor_gate is
	port (a,b: in std_logic; c: out std_logic);
end entity;

architecture xnor_arc of xnor_gate is
	
	signal p,q : std_logic;
	
	component nor_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;
	
	component and_gate
		port (a,b : in std_logic; c: out std_logic);
	end component;
	
	component or_gate
		port (a,b : in std_logic; c: out std_logic);
	end component;
	
begin
	NorInst1: nor_gate
		port map (a=>a, b=>b, c=>p);
	
	AndInst1: and_gate
		port map (a=>a, b=>b, c=>q);
		
	OrInst1: or_gate
		port map (a=>p, b=>q, c=>c);
	
end architecture;