library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity TrafficLightsController is
port ( clk, rst, tr1, tr4 : in std_logic;
		r, g, y: out std_logic_vector (4 downto 0));
end entity;

architecture controller of TrafficLightsController is
begin

	process (clk, rst)
		variable state, prev_state: integer := -1;
		variable time_count: integer := 0;
		constant clock_freq: integer := 5;
	begin
		
		if rst = '1' then
			r <= "11011";
			g <= "00100";
			y <= "00000";
			state := 2;
			time_count := 1;
		else
		
			if rising_edge(clk) then
			
				time_count := time_count + 1;
				
				if time_count = 30/clock_freq and (state = 4 or state = 1) then
					g(state) <= '0';
					y(state) <= '1';
				elsif time_count = 35/clock_freq and (state = 4 or state = 1) then
					time_count := 0; 
					prev_state := state;
					state := (state + 1) mod 5;
					
					r(prev_state) <= '1';
					r(state) <= '0';
					y(prev_state) <= '0';
					g(state) <= '1';					

				elsif time_count = 60/clock_freq then			
					g(state) <= '0';
					y(state) <= '1';
				elsif time_count = 65/clock_freq then
					time_count := 0; 
					prev_state := state;
					state := (state + 1) mod 5;
			
					if tr1 /= '1' and state = 1 then
						state := (state + 1) mod 5;
					elsif  tr4 /= '1' and state = 4 then
						state := (state + 1) mod 5;
					end if;
					
					r(prev_state) <= '1';
					r(state) <= '0';
					y(prev_state) <= '0';
					g(state) <= '1';			
				end if;
			
			end if;
		
		end if;
	
	end process;

end architecture;