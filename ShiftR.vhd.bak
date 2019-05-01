LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity shiftr is 
  generic(n:integer:=16);
	port (
      input1:in std_logic_vector(n-1 downto 0);
        shamt: in std_logic_vector(3 downto 0);
      output:out std_logic_vector(n-1 downto 0);
      carry: out std_logic

);
end shiftr;

architecture ggg of shiftr is 
begin 
output<=(to_integer(unsigned(shamt)) downto 1 => '0')& input1(n-1 downto to_integer(unsigned(shamt)));
carry<=input1(to_integer(unsigned(shamt))-1);
end architecture;
