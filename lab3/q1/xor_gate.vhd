library ieee;
use ieee.std_logic_1164.all;

entity xor_gate is
	port (a,b: in std_logic; c: out std_logic);
end entity;

architecture xor_arc of xor_gate is
	
	signal p,q : std_logic;
	
	component nand_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;
	
	component or_gate
		port (a,b : in std_logic; c: out std_logic);
	end component;
	
	component and_gate
		port (a,b : in std_logic; c: out std_logic);
	end component;
	
begin
	NandInst1: nand_gate
		port map (a=>a, b=>b, c=>p);
	
	OrInst1: or_gate
		port map (a=>a, b=>b, c=>q);
		
	AndInst1: and_gate
		port map (a=>p, b=>q, c=>c);
	
end architecture;