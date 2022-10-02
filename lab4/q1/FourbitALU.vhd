library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.EightbitMux8_pkg.all;

entity FourbitALU is
port ( a, b: in std_logic_vector (3 downto 0);
sel: in std_logic_vector (2 downto 0);
result: out std_logic_vector (7 downto 0));
end entity;

architecture FourbitALU_arc of FourbitALU is
-- Component Declaration

component EightbitMux8 is 
port(
	I		: in byte_array;
	sel	: in std_logic_vector(2 downto 0);
	b		: out std_logic_vector(7 downto 0));
end component;

-- A
component CarryLookAheadAdd is
port (a, b: in std_logic_vector (3 downto 0);
		sel: in std_logic;
		result: out std_logic_vector (7 downto 0));
end component;

-- B
component FourbitMultiplier is
port (a, b: in std_logic_vector (3 downto 0);
		result: out std_logic_vector (7 downto 0));
end component;

-- C
component FourbitComparator is
port (a, b: in std_logic_vector (3 downto 0);
		result: out std_logic_vector (7 downto 0));
end component;

-- D
component FourbitNand_gate is
	port (a,b: in std_logic_vector(3 downto 0); c: out std_logic_vector(3 downto 0));
end component;

-- E
component FourbitNor_gate is
	port (a,b: in std_logic_vector(3 downto 0); c: out std_logic_vector(3 downto 0));
end component;

-- F
component FourbitXor_gate is
	port (a,b: in std_logic_vector(3 downto 0); c: out std_logic_vector(3 downto 0));
end component;

-- G
component FourbitXnor_gate is
	port (a,b: in std_logic_vector(3 downto 0); c: out std_logic_vector(3 downto 0));
end component;

-- Signal Declaration
	signal p: byte_array;
	
begin
-- Instantiation
	Adder: CarryLookAheadAdd port map (a=>a,b=>b,sel=>'0',result=>p(0));
	Subtracter: CarryLookAheadAdd port map (a=>a,b=>b,sel=>'1',result=>p(1));
	Multiplier: FourbitMultiplier port map (a=>a,b=>b,result=>p(2));
	Comparator: FourbitComparator port map (a=>a,b=>b,result=>p(3));
	Nand4: FourbitNand_gate port map (a=>a,b=>b,c=>p(4)(3 downto 0));
	Nor4: FourbitNor_gate port map (a=>a,b=>b,c=>p(5)(3 downto 0));
	Xor4: FourbitXor_gate port map (a=>a,b=>b,c=>p(6)(3 downto 0));
	Xnor4: FourbitXnor_gate port map (a=>a,b=>b,c=>p(7)(3 downto 0));
	
	p(4)(7 downto 4) <= (others => '-');
	p(5)(7 downto 4) <= (others => '-');
	p(6)(7 downto 4) <= (others => '-');
	p(7)(7 downto 4) <= (others => '-');
	
	Mux8: EightbitMux8 port map (I=>p,sel=>sel,b=>result);
	
end  architecture;
