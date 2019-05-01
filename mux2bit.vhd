library IEEE;
use IEEE.std_logic_1164.all;
entity mux2 is
port(
  a1      : in  std_logic;
  a2      : in  std_logic;
  sel     : in  std_logic;
  b       : out std_logic);
end mux2;
architecture arc of mux2 is
  
begin
 b <= a1 when (SEL = '0') else a2;
end arc;
