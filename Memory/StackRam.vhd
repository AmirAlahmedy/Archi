--Empty descending stack implementation in VHDL.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity stack is
port(   Clk : in std_logic;  --Clock for the stack.
        Reset : in std_logic; --active high reset.    
        Enable : in std_logic;  --Enable the stack. Otherwise neither push nor pop will happen.
        Data_In : in std_logic_vector(15 downto 0);  --Data to be pushed to stack
        Data_Out : out std_logic_vector(15 downto 0);  --Data popped from the stack.

        PUSH_barPOP : in std_logic;  --active low for POP and active high for PUSH.
	
	--if push and call high sp-2
	CALL: in std_logic;	

	--if pop and ret or rti high sp+2
	RET: in std_logic;
	RTI: in std_logic;
		
        Stack_Full : out std_logic;  --Goes high when the stack is full.
        Stack_Empty : out std_logic  --Goes high when the stack is empty.
        );
end stack;

architecture Behavioral of stack is
--stack is 4kb
type ram_type is array (1044479 to 1048575) of std_logic_vector(15 downto 0);
signal stack_mem : ram_type := (others => (others => '0'));
signal full,empty : std_logic := '0';
signal prev_PP : std_logic := '0';
signal prev_Call: std_logic := '0';
signal prev_retrti: std_logic := '0';	
signal SP : integer := 0;  --for simulation and debugging. 

begin

Stack_Full <= full; 
Stack_Empty <= empty;

--PUSH and POP process for the stack.
PUSH : process(Clk,reset)
variable stack_ptr : integer := 1048575;
begin
     if(reset = '1') then
          stack_ptr := 1048575;  --stack grows downwards.
          full <= '0';
          empty <= '0';
          Data_out <= (others => '0');
          prev_PP <= '0';
    elsif(rising_edge(Clk)) then
     --value of PUSH_barPOP with one clock cycle delay.
          if(Enable = '1') then
                prev_PP <= PUSH_barPOP;
		prev_Call <= call;
		prev_retrti <= ret or rti;	 
          else
                prev_PP <= '0';
		prev_Call <= '0';
		prev_retrti <= '0';	
          end if;   
            --POP section.
        if (Enable = '1' and PUSH_barPOP = '0' and (ret = '1' or rti = '1')and empty = '0') then
          --setting empty flag.           
                if(stack_ptr = 1048575) then
                     full <= '0';
                     empty <= '1';
                else
                     full <= '0';
                     empty <= '0';
                end if;
                --when the push becomes pop, before stack is full. 
                if((prev_PP = '1' or prev_Call = '1') and full = '0') then
			if(prev_PP =  '1' ) then
                    		stack_ptr := stack_ptr + 1;
			elsif(prev_Call = '1') then
				stack_ptr := stack_ptr + 2;
			end if;
                end if; 
        --Data has to be taken from the next highest address(empty descending type stack).              
                Data_Out <= stack_mem(stack_ptr);
            if(stack_ptr /= 1048575) then 

		if(ret = '0' and rti = '0') then 
                	stack_ptr := stack_ptr + 1;
		else
			stack_ptr := stack_ptr + 2;
		end if;

            end if;         
        end if;
      
          --PUSH section.
        if (Enable = '1' and PUSH_barPOP = '1' and full = '0') then
                --setting full flag.
                if(stack_ptr = 0) then
                     full <= '1';
                     empty <= '0';
                else
                     full <= '0';
                     empty <= '0';
                end if; 
                --when the pop becomes push, before stack is empty.
                if((prev_PP = '0' or prev_retrti = '1') and empty = '0') then
			if(prev_PP = '0') then
                    		stack_ptr := stack_ptr - 1;
			elsif(prev_retrti = '1')then
				stack_ptr := stack_ptr - 2;
			end if;
                end if;
                --Data pushed to the current address.       
                stack_mem(stack_ptr) <= Data_In; 
            if(stack_ptr /= 1044479) then

                if(call = '0') then 
                	stack_ptr := stack_ptr - 1;
		else
			stack_ptr := stack_ptr - 2;
		end if;

            end if;     
        end if;
          SP <= stack_ptr;  --for debugging/simulation.
        
    end if; 
end process;

end Behavioral;
