library ieee;
use ieee.std_logic_1164.all;

entity imp_gate is
	port (a,b: in std_logic; c: out std_logic);
end entity;

architecture imp_arc of imp_gate is
	
	signal p: std_logic;
	
	component not_gate
		port (a : in std_logic; b: out std_logic);
	end component;
	
	component or_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;
	
begin
	NotInst1: not_gate
		port map (a=>a, b=>p);
	
	OrInst1: or_gate
		port map (a=>p, b=>b, c=>c);
		
end architecture;