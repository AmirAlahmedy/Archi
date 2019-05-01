
Library IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;
 use ieee.std_logic_unsigned.all;
Entity Pc_Adder is
  generic ( n: integer:=32);
  Port(
rst:in std_logic;
Clk : in std_logic;
PC : IN std_logic_vector (31 downto 0 );
AddAmount : in Std_logic_vector (1 downto 0);
PCOut : out std_logic_vector (31 downto 0)
);
  end Pc_Adder;

architecture pc_add of Pc_Adder is

begin

process(clk)
variable love:std_logic_vector(31 downto 0);
begin 
if(rising_edge(clk) and rst='1') then 
pcout<=(others=>'0');
elsif(falling_edge(clk)) then 
love:=PC;
love := (love)+(AddAmount);
end if;
PCout <= love;
end process;
end architecture;