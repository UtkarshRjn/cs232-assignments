library ieee;
use ieee.std_logic_1164.all;

entity OnebitFullAdd is
port ( a, b, cin : in std_logic;
		sum, cout: out std_logic);
end entity;


architecture one_bit_full_arc of OnebitFullAdd is
-- Component Declaration

component OnebitHalfAdd is 
port(
	a,b	: in std_logic;
	sum,carry	: out std_logic);
end component;

-- Signal Declaration
	signal p,carry1,carry2: std_logic;

begin
-- Instantiation
	HalfAddInst1: OnebitHalfAdd port map(a=>a, b=>b, sum=>p, carry=>carry1); 
	HalfAddInst2: OnebitHalfAdd port map(a=>p, b=>cin, sum=>sum, carry=>carry2);
	
	cout <= carry1 or carry2;

end one_bit_full_arc;