library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity FourbitMultiplier is
port (a, b: in std_logic_vector (3 downto 0);
		result: out std_logic_vector (7 downto 0));
end entity;

architecture FourbitMultiplier_arc of FourbitMultiplier is
-- Component Declaration
component FourbitRipCarAdd is
		port ( a, b : in std_logic_vector (3 downto 0);
		cin: in std_logic;
		sum : out std_logic_vector (3 downto 0);
		cout: out std_logic);
end component;

-- Signal Declaration
	signal b0s,b1s,b2s,b3s : std_logic_vector(3 downto 0);
	signal p0,p1,p2,p3: std_logic_vector(3 downto 0);
	signal q1,q2,q3,q4,q5: std_logic_vector(3 downto 0);
	signal c1,c2: std_logic;
	
begin
-- Instantiation
	b0s <= (others => b(0));
	b1s <= (others => b(1));
	b2s <= (others => b(2));
	b3s <= (others => b(3));
	
	p0 <= a and b0s;
	p1 <= a and b1s;
	p2 <= a and b2s;
	p3 <= a and b3s;
	
	result(0) <= p0(0);
	q1(0) <= p0(1);
	q1(1) <= p0(2);
	q1(2) <= p0(3);
	q1(3) <= '0';
	
	FourbitAddInst1 : FourbitRipCarAdd port map (a=> p1, b=> q1, cin=>'0',sum=>q2,cout=>c1);
	
	result(1) <= q2(0);
	q3(0) <= q2(1);
	q3(1) <= q2(2);
	q3(2) <= q2(3);
	q3(3) <= c1;
	
	FourbitAddInst2 : FourbitRipCarAdd port map (a=> p2, b=> q3, cin=>'0',sum=>q4,cout=>c2);
	
	result(2) <= q4(0);
	q5(0) <= q4(1);
	q5(1) <= q4(2);
	q5(2) <= q4(3);
	q5(3) <= c2;
	
	FourbitAddInst3 : FourbitRipCarAdd port map (a=> p3, b=> q5, cin=>'0',sum=>result(6 downto 3),cout=>result(7));
	
end architecture;