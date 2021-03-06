

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity sub is 
  generic(n:integer:=16);
	port (
      input1:in std_logic_vector(n-1 downto 0);
      input2:in std_logic_vector(n-1 downto 0);
      output:out std_logic_vector(n-1 downto 0);
      carry: out std_logic
);
end sub;

architecture hhh of sub is 
signal input11:std_logic_vector(n downto 0);
signal input22:std_logic_vector(n downto 0 );
signal output1: std_logic_vector(n downto 0);
begin 
input11<='0'&input1;
input22<='1'&(not(input2)+1);
output1<=input11+input22;
carry<=output1(n);
output<=output1(n-1 downto 0);
end architecture; 