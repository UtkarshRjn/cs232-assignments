library ieee;
use ieee.std_logic_1164.all;

entity ThreebyEightDecode is
	port ( i : in std_logic_vector(2 downto 0);
	en: in std_logic;
	z : out std_logic_vector(7 downto 0));
end entity;

architecture dec_arc of ThreebyEightDecode is
-- Component Declaration
component and4_gate is 
	Port(
		a,b,c		: in std_logic;
		en : in std_logic;
		d		: out std_logic);
end component;

component nand_gate is 
	Port(
		a		: in std_logic;
		b		: in std_logic;
		c		: out std_logic);
end component;

-- Signal Declaration
	signal not_i : std_logic_vector(2 downto 0);
	
begin
-- Instantiation
	NotInst1: nand_gate port map (a=>i(2), b=>i(2), c=>not_i(2));
	NotInst2: nand_gate port map (a=>i(1), b=>i(1), c=>not_i(1));
	NotInst3: nand_gate port map (a=>i(0), b=>i(0), c=>not_i(0));	

	AndInst1: and4_gate port map (a=>not_i(2),b=>not_i(1),c=>not_i(0), en=>en ,d=>z(0)); 
	AndInst2: and4_gate port map (a=>not_i(2),b=>not_i(1),c=>i(0), en=>en ,d=>z(1)); 
	AndInst3: and4_gate port map (a=>not_i(2),b=>i(1),c=>not_i(0), en=>en ,d=>z(2));
	AndInst4: and4_gate port map (a=>not_i(2),b=>i(1),c=>i(0), en=>en ,d=>z(3));
	AndInst5: and4_gate port map (a=>i(2),b=>not_i(1),c=>not_i(0), en=>en ,d=>z(4));
	AndInst6: and4_gate port map (a=>i(2),b=>not_i(1),c=>i(0), en=>en ,d=>z(5));
	AndInst7: and4_gate port map (a=>i(2),b=>i(1),c=>not_i(0), en=>en ,d=>z(6));
	AndInst8: and4_gate port map (a=>i(2),b=>i(1),c=>i(0), en=>en ,d=>z(7));
	
end dec_arc;
	

