library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package EightbitMux8_pkg is
   type byte_array is array(0 to 7) of std_logic_vector(7 downto 0);
	type byte_arr1 is array (0 to 3) of std_logic_vector(7 downto 0);
	type byte_arr2 is array (0 to 1) of std_logic_vector(7 downto 0);
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.EightbitMux8_pkg.all;

entity EightbitMux8 is 
port(
	I		: in byte_array;
	sel	: in std_logic_vector(2 downto 0);
	b		: out std_logic_vector(7 downto 0));
end entity;

architecture mux8_arc of EightbitMux8 is
-- Component Declaration
component EightbitMux2 is 
port(
	a0		: in std_logic_vector(7 downto 0);
	a1		: in std_logic_vector(7 downto 0);
	sel	: in std_logic;
	b		: out std_logic_vector(7 downto 0));
end component;

-- Signal Declaration
signal p1 : byte_arr1;	
signal p2 : byte_arr2;	

begin
-- Instantiation

	Mux2Inst1: EightbitMux2 port map (a0 => I(0), a1 => I(1), sel => sel(0),b => p1(0));
	Mux2Inst2: EightbitMux2 port map (a0 => I(2), a1 => I(3), sel => sel(0),b => p1(1));
	Mux2Inst3: EightbitMux2 port map (a0 => I(4), a1 => I(5), sel => sel(0),b => p1(2));
	Mux2Inst4: EightbitMux2 port map (a0 => I(6), a1 => I(7), sel => sel(0),b => p1(3));
	Mux2Inst5: EightbitMux2 port map (a0 => p1(0), a1 => p1(1), sel => sel(1),b => p2(0));
	Mux2Inst6: EightbitMux2 port map (a0 => p1(2), a1 => p1(3), sel => sel(1),b => p2(1));
	Mux2Inst7: EightbitMux2 port map (a0 => p2(0), a1 => p2(1), sel => sel(2),b => b);

end architecture;