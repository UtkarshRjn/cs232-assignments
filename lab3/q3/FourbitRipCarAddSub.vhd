library ieee;
use ieee.std_logic_1164.all;

entity FourbitRipCarAddSub is
port ( a, b : in std_logic_vector (3 downto 0);
		cin: in std_logic;
		sum : out std_logic_vector (3 downto 0);
		cout: out std_logic);
end entity;

architecture FourbitRipCarAddSub_arc of FourbitRipCarAddSub is

component FourbitRipCarAdd is
		port ( a, b : in std_logic_vector (3 downto 0);
		cin: in std_logic;
		sum : out std_logic_vector (3 downto 0);
		cout: out std_logic);
end component;

component xor_gate is
	port (a,b: in std_logic; c: out std_logic);
end component;

-- Signal Declaration
	signal p: std_logic_vector(3 downto 0);
	
begin
-- Instantiation

	XorInst1: xor_gate port map(a=>b(0),b=>cin,c=>p(0));
	XorInst2: xor_gate port map(a=>b(1),b=>cin,c=>p(1));
	XorInst3: xor_gate port map(a=>b(2),b=>cin,c=>p(2));
	XorInst4: xor_gate port map(a=>b(3),b=>cin,c=>p(3));
	
	RippleAddInst1: FourbitRipCarAdd port map(a=>a , b=>p, cin=>cin,sum=>sum, cout=>cout);
	
end FourbitRipCarAddSub_arc;