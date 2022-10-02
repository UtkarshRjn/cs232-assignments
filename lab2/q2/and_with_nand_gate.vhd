library ieee;
use ieee.std_logic_1164.all;

entity and_with_nand_gate is
	port (a,b: in std_logic; c: out std_logic);
end entity;

architecture and_arc of and_with_nand_gate is
	
	signal p: std_logic;
	
	component nand_gate
		port (a,b: in std_logic; c: out std_logic);
	end component;
	
begin
	NandInst1: nand_gate
		port map (a=>a, b=>b, c=>p);
	
	NotInst1: nand_gate
		port map (a=>p, b=>p, c=>c);
		
end architecture;