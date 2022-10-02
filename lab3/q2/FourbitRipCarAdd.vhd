library ieee;
use ieee.std_logic_1164.all;

entity FourbitRipCarAdd is
		port ( a, b : in std_logic_vector (3 downto 0);
		cin: in std_logic;
		sum : out std_logic_vector (3 downto 0);
		cout: out std_logic);
end entity;

architecture FourbitRipCarAdd_arc of FourbitRipCarAdd is
-- Component Declaration
component OnebitFullAdd is 
	Port(a, b, cin : in std_logic;
		 sum, cout: out std_logic);
end component;

-- Signal Declaration
	signal c : std_logic_vector(2 downto 0);
	
begin
-- Instantiation
	FullAddInst1: OnebitFullAdd port map (a=>a(0),b=>b(0),cin=>cin,sum=>sum(0),cout=>c(0));
	FullAddInst2: OnebitFullAdd port map (a=>a(1),b=>b(1),cin=>c(0),sum=>sum(1),cout=>c(1));
	FullAddInst3: OnebitFullAdd port map (a=>a(2),b=>b(2),cin=>c(1),sum=>sum(2),cout=>c(2));
	FullAddInst4: OnebitFullAdd port map (a=>a(3),b=>b(3),cin=>c(2),sum=>sum(3),cout=>cout);
	
end FourbitRipCarAdd_arc;