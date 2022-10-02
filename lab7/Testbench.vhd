library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Testbench is
end entity;
architecture Behave of Testbench is

  ----------------------------------------------------------------
  --  edit the following lines to set the number of i/o's of your
  --  DUT.
  ----------------------------------------------------------------
  constant number_of_outputs : integer := 5;  -- # output bits from your design.
  ----------------------------------------------------------------
  ----------------------------------------------------------------

  -- Note that you will have to wrap your design into the DUT
  -- as indicated in class.

	component TrafficLightsController is
	port ( clk, rst, tr1, tr4 : in std_logic;
			r, g, y: out std_logic_vector (4 downto 0));
	end component;

  signal tr1,tr4: std_logic;
  signal output_r : std_logic_vector(number_of_outputs-1 downto 0);
  signal output_g : std_logic_vector(number_of_outputs-1 downto 0);
  signal output_y : std_logic_vector(number_of_outputs-1 downto 0);
  signal clk : std_logic := '0';
  signal rst : std_logic := '1';
  signal done: std_logic := '0';
  
  -- create a constrained string
  function to_string(x: string) return string is
      variable ret_val: string(1 to x'length);
      alias lx : string (1 to x'length) is x;
  begin  
      ret_val := lx;
      return(ret_val);
  end to_string;

  -- bit-vector to std-logic-vector and vice-versa
  function to_std_logic_vector(x: bit_vector) return std_logic_vector is
     alias lx: bit_vector(1 to x'length) is x;
     variable ret_val: std_logic_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
          ret_val(I) := '1';
        else
          ret_val(I) := '0';
        end if;
     end loop; 
     return ret_val;
  end to_std_logic_vector;

  function to_bit_vector(x: std_logic_vector) return bit_vector is
     alias lx: std_logic_vector(1 to x'length) is x;
     variable ret_val: bit_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
          ret_val(I) := '1';
        else
          ret_val(I) := '0';
        end if;
     end loop; 
     return ret_val;
  end to_bit_vector;

  function to_std_logic(i : in bit) return std_logic is
	begin
		 if i = '0' then
			  return '0';
		 end if;
		 return '1';
	end function;
	
begin
	process
	begin
		clk <= '1';
		wait for 2.5 sec;
		clk <= '0';
		wait for 2.5 sec;
		if done = '1' then
			wait;
		end if;
	end process;
 
	process
	begin
		rst <= '1';
		wait for 5 sec;
		rst <= '0';
		wait;
	end process;
 
  process 
    
  begin
	 
	 tr1 <= '0';
	 tr4 <= '1';
	 wait for 240 sec;
	 tr1 <= '1';
	 tr4 <= '1';
	 wait for 240 sec;
	 tr1 <= '1';
	 tr4 <= '0';
	 wait for 240 sec;
	 tr1 <= '0';
	 tr4 <= '0'; 
	 wait for 240 sec;
	 
	 done <= '1';
	 
    wait;
  end process;

  dut_instance: TrafficLightsController
     	port map( clk => clk, rst => rst, tr1 => tr1, tr4=> tr4, r => output_r, g => output_g, y => output_y);

end Behave;