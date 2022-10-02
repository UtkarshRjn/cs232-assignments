library ieee;
use ieee.std_logic_1164.all;

entity and4_gate is
	port (
	a,b,c: in std_logic;
	en: in std_logic; 
	d: out std_logic);
end entity;

architecture and4_arc of and4_gate is
	
	signal p,s: std_logic;
	
	component and_with_nand_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;
	
begin
	AndInst1: and_with_nand_gate
		port map (a=>a, b=>b, c=>p);
	
	AndInst2: and_with_nand_gate
		port map (a=>p, b=>c, c=>s);
		
	AndInst3: and_with_nand_gate
		port map (a=>s, b=>en, c=>d);
end architecture;