
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity shiftl is 
  generic(n:integer:=16);
	port (
      input1:in std_logic_vector(n-1 downto 0);
      shamt: in std_logic_vector(4 downto 0);
      output:out std_logic_vector(n-1 downto 0);
      carry: out std_logic

);
end shiftl;

architecture ggg of shiftl is 
begin 
output<=(input1(n-1-to_integer(unsigned(shamt)) downto 0)& (to_integer(unsigned(shamt)) downto 1 => '0'));
carry<=input1(n-to_integer(unsigned(shamt)));
end architecture;