library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity RLE_encoder is
port ( clk, rst: in std_logic;
		 input: in std_logic_vector (7 downto 0);
		 DataValid: out std_logic := '0' ;
		 output: out std_logic_vector (7 downto 0));
end entity;

architecture circuit of RLE_encoder is
	
begin

	process (clk, rst, input)
		variable state, prev_state: std_logic_vector(7 downto 0) := (others => '-');
		variable count : std_logic_vector(2 downto 0) := "001";
		
		variable ReadPointer : std_logic_vector(7 downto 0) := (others => '0');
		variable WritePointer : std_logic_vector(7 downto 0) := (others => '0');
		
		constant ESC : std_logic_vector(7 downto 0) := "00011011";
		Type Mem is array ( 127 downto 0) of std_logic_vector( 7 downto 0);
		variable Memory : Mem;	
	
		function BOOL_TO_SL(X : boolean)
            return std_ulogic is
		begin
		  if X then
			 return ('1');
		  else
			 return ('0');
		  end if;
		end BOOL_TO_SL;
	
	begin
	
		if rising_edge(clk) then
		
			if rst = '1' then
				prev_state := (others => '0');
				state := input;
				ReadPointer := (others => '0');
				WritePointer := (others => '0');
			else
			
				prev_state := state;
				state := input;
				
				--add output to memory	
				if state /= prev_state then
	
					if prev_state /= ESC  and count = "001" then				
						Memory(to_integer(unsigned(WritePointer))) := prev_state;
						WritePointer := WritePointer + 1;
					elsif prev_state /= ESC  and count = "010" then
						Memory(to_integer(unsigned(WritePointer))) := prev_state;
						Memory(to_integer(unsigned(WritePointer)) + 1) := prev_state;
						WritePointer := WritePointer + 2;
					else 
						Memory(to_integer(unsigned(WritePointer))) := ESC;
						Memory(to_integer(unsigned(WritePointer)) + 1) := "00000" & count;
						Memory(to_integer(unsigned(WritePointer)) + 2) := prev_state;
						
						WritePointer := WritePointer + 3;
					end if;
				end if;	
				
				
				-- for count update
				if state = prev_state and state /= "UUUUUUUU" then 
					count := count + 1;
				else 
					count := "001";
				end if;
				
				if state = ESC then
					if count = "111" then
						
						Memory(to_integer(unsigned(WritePointer))) := ESC;
						Memory(to_integer(unsigned(WritePointer)) + 1) := "00000110";
						Memory(to_integer(unsigned(WritePointer)) + 2) := prev_state;
						
						WritePointer := WritePointer + 3;
						
						count := "001";
					end if;
				else 
					if count = "110" then
						
						Memory(to_integer(unsigned(WritePointer))) := ESC;
						Memory(to_integer(unsigned(WritePointer)) + 1) := "00000101";
						Memory(to_integer(unsigned(WritePointer)) + 2) := prev_state;
						
						WritePointer := WritePointer + 3;
						
						count := "001";
					end if;
				end if;
				
				DataValid <= BOOL_TO_SL(ReadPointer /= WritePointer);
				
				if ReadPointer /= WritePointer then
					output <= Memory(to_integer(unsigned(ReadPointer)));
					ReadPointer := ReadPointer + 1;
				else 
					output <= "UUUUUUUU";
				end if;
			
			end if;
		
		end if;
	
	end process;

end architecture;