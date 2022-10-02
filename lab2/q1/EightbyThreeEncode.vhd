library ieee;
use ieee.std_logic_1164.all;

entity EightbyThreeEncode is
port ( i : in std_logic_vector(7 downto 0);
en: in std_logic;
z : out std_logic_vector(2 downto 0));
end entity;

architecture enc_arc of EightbyThreeEncode is
-- Component Declaration
component or4_gate is 
	Port(
		a,b,c,d	: in std_logic;
		e		: out std_logic);
end component;

component mux2 is 
port(
	a0		: in std_logic;
	a1		: in std_logic;
	sel	: in std_logic;
	b		: out std_logic);
end component;

-- Signal Declaration
	signal s: std_logic_vector(2 downto 0);

begin
-- Instantiation

	OrInst1: or4_gate port map (a=>i(5), b=>i(4), c=>i(6),d=>i(7), e=>s(0));
	OrInst2: or4_gate port map (a=>i(2), b=>i(3), c=>i(6),d=>i(7), e=>s(1));
	OrInst3: or4_gate port map (a=>i(1), b=>i(3), c=>i(5),d=>i(7), e=>s(2));
	
	AndInst1: mux2 port map (a0=>s(0), a1=>en, sel=>s(0), b=>z(2));
	AndInst2: mux2 port map (a0=>s(1), a1=>en, sel=>s(1), b=>z(1));
	AndInst3: mux2 port map (a0=>s(2), a1=>en, sel=>s(2), b=>z(0));
end enc_arc;