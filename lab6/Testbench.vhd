library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Testbench is
end entity;
architecture Behave of Testbench is

  ----------------------------------------------------------------
  --  edit the following lines to set the number of i/o's of your
  --  DUT.
  ----------------------------------------------------------------
  constant number_of_inputs  : integer := 8;  -- # input bits to your design.
  constant number_of_outputs : integer := 8;  -- # output bits from your design.
  ----------------------------------------------------------------
  ----------------------------------------------------------------

  -- Note that you will have to wrap your design into the DUT
  -- as indicated in class.

component RLE_encoder is
	port (clk, rst: in std_logic;
			input: in std_logic_vector(7 downto 0);
			DataValid: out std_logic;
			output: out std_logic_vector(7 downto 0));
end component;


  signal input_vector  : std_logic_vector(number_of_inputs-1 downto 0);
  signal output_vector : std_logic_vector(number_of_outputs-1 downto 0);
  signal DataValid: std_logic;
  signal clk : std_logic := '0';
  signal rst : std_logic := '1';
  
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

  function to_std_logic(i : in integer) return std_logic is
	begin
		 if i = 0 then
			  return '0';
		 end if;
		 return '1';
	end function;

begin
  process 
    variable err_flag : boolean := false;
    File INFILE: text open read_mode is "/home/utkarsh/Documents/iitb/cs232/lab6_all/q1/input.txt";
    FILE OUTFILE: text  open write_mode is "/home/utkarsh/Documents/iitb/cs232/lab6_all/q1/output.txt";

    -- bit-vectors are read from the file.
    variable input_vector_var: bit_vector (number_of_inputs-1 downto 0);
    variable output_vector_var: bit_vector (number_of_outputs-1 downto 0);
    variable output_mask_var: bit_vector (number_of_outputs-1 downto 0);

    -- for comparison of output with expected-output
    variable output_comp_var: std_logic_vector (number_of_outputs-1 downto 0);
    constant ZZZZ : std_logic_vector(number_of_outputs-1 downto 0) := (others => '0');

    -- for read/write.
    variable INPUT_LINE: Line;
    variable OUTPUT_LINE: Line;
    variable LINE_COUNT: integer := 0;

	 -- for end of file detection
--	 boolean end_file := '0';
    
  begin
    while LINE_COUNT < 129 loop 
	  -- will read a new line every 5ns, apply input,
	  -- wait for 1 ns for circuit to settle.
	  -- read output.
	  
			if(clk = '1') then
				clk <= not clk;
				wait for 20 ns;
				
				next;
			end if;
			
			LINE_COUNT := LINE_COUNT + 1;
			if LINE_COUNT /= 1 then
				rst <= '0';
			end if;

	  if LINE_COUNT < 65 then 
	  -- read input at current time.
			 readLine (INFILE, INPUT_LINE);
          read (INPUT_LINE, input_vector_var);
          read (INPUT_LINE, output_vector_var);
          read (INPUT_LINE, output_mask_var);
	
	  -- apply input.
          input_vector <= to_std_logic_vector(input_vector_var);
	  else 
			 input_vector <= "UUUUUUUU";
	  end if;
		
		clk <= not clk;
	  -- wait for the circuit to settle 
	  wait for 20 ns;

	  -- check output.
			if DataValid = '1' then
				 
				 output_comp_var := (to_std_logic_vector(output_mask_var) and 
						(output_vector xor to_std_logic_vector(output_vector_var)));
				 if (output_comp_var  /= ZZZZ) then
					 write(OUTPUT_LINE,to_string("ERROR: line "));
					 write(OUTPUT_LINE, LINE_COUNT);
					 writeline(OUTFILE, OUTPUT_LINE);
					 err_flag := true;
				 end if;

				 write(OUTPUT_LINE, to_bit_vector(output_vector));
				 writeline(OUTFILE, OUTPUT_LINE);
			
			end if;
				 
		 -- advance time by 4 ns.
	  wait for 4 ns;
    end loop;
	
	 assert (err_flag) report "SUCCESS, all tests passed." severity note;
    assert (not err_flag) report "FAILURE, some tests failed." severity error;

	
    wait;
  end process;

  dut_instance: RLE_encoder
     	port map( clk => clk, rst => rst, input => input_vector, DataValid => DataValid ,output => output_vector);

end Behave;