library ieee;
use ieee.std_logic_1164.all;

entity or4_gate is 
port(
	a, b, c, d: in std_logic;
	e	: out std_logic);
end or4_gate;

architecture or4_arc of or4_gate is

-- declarative part: empty
component mux2 is 
	Port(
		a0		: in std_logic;
		a1		: in std_logic;
		sel	: in std_logic;
		b		: out std_logic);
end component;

-- Signal Declaration
	signal p1,p2 : std_logic;
	
begin
	OrInst1: mux2  port map (a0=>a, a1=>b, sel=>b, b=>p1);
	OrInst2: mux2  port map (a0=>p1, a1=>c, sel=>c, b=>p2);
	OrInst3: mux2  port map (a0=>p2, a1=>d, sel=>d, b=>e);
end or4_arc;