library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;	
use ieee.std_logic_unsigned.all;

entity BoothMultiplier is
port ( clk, rst : in std_logic;
		 a, b : in std_logic_vector (3 downto 0);
		 result : out std_logic_vector (7 downto 0) );
end entity;

architecture boothMult_arc of BoothMultiplier is

	signal p1,p2 : std_logic_vector(7 downto 0);
	signal state, next_state : std_logic;
	
begin 

	process (clk, next_state)
	begin
		if rising_edge(clk) then
			if rst = '1' then
				state <= '0';
			else
				state <= next_state;
			end if;
		end if;
	end process;
		
	process (A,state)
	begin
		if state = '0' then
			next_state <= '1';
		else 
			next_state <= '0';
		end if;
		
		if b(0) = '0' and b(1) = '0' then
			p1 <= (others => '0');
		elsif b(0) = '1' and b(1) = '0' then
			p1 <= "0000" & A;
		elsif b(0) = '0' and b(1) = '1' then
			p1 <= "000" & A(3 downto 0) & "0";
		elsif b(0) = '1' and b(1) = '1' then
			p1 <= ("00" & A(3 downto 0) & "00") -("0000" & A(3 downto 0));
		end if;
		
		if b(2) = '0' and b(3) = '0' then
			p2 <= (others => '0');
		elsif b(2) = '1' and b(3) = '0' then
			p2 <= "00" & A & "00";
		elsif b(2) = '0' and b(3) = '1' then
			p2 <= "0" & A(3 downto 0) & "000";
		elsif b(2) = '1' and b(3) = '1' then
			p2 <= (A(3 downto 0) & "0000") - ("00" & A(3 downto 0) & "00");
		end if;
	end process;
	
	process (state)
	begin
		if state = '0' then
			result <= (others => '0');
		else 
			result <= p1 + p2;
		end if;
	end process;
	
	
end architecture;