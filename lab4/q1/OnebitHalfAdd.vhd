library ieee;
use ieee.std_logic_1164.all;

entity OnebitHalfAdd is
port ( a, b: in std_logic;
		sum, carry: out std_logic);
end entity;

architecture half_add_arc of OnebitHalfAdd is

component xor_gate is
	port (a,b: in std_logic; c: out std_logic);
end component;

begin
-- Instantiation

	XorInst1: xor_gate port map(a=>a,b=>b,c=>sum);
	carry <= a and b;
	
end half_add_arc;