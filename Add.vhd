
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity add is 
  generic(n:integer:=16);
	port (
      input1:in std_logic_vector(n-1 downto 0);
      input2:in std_logic_vector(n-1 downto 0);
      output:out std_logic_vector(n-1 downto 0);
      carry: out std_logic;
      negative:out std_logic;
      zero: out std_logic
);
end add;

architecture hhh of add is 
signal input11:std_logic_vector(n downto 0);
signal input22:std_logic_vector(n downto 0 );
signal output1: std_logic_vector(n downto 0);
begin 
input11<='0'&input1;
input22<='0'&input2;
output1<=input11+input22;
carry<=output1(n);
zero<='1'  when unsigned(output1(n-1 downto 0))=to_unsigned(0, n)
else '0';
negative<=output1(n-1); 
output<=output1(n-1 downto 0);
end architecture; 