LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Branch is 
	port (
zeroin,negin,carryin,jzin,jnin,jmpin,setc: in std_logic;
branch: out std_logic
      
);
end Branch;

architecture a_branch of Branch is 
component mux2 is
port(
  a1      : in  std_logic;
  a2      : in  std_logic;
  sel     : in  std_logic;
  b       : out std_logic);
end component;
signal n1out,z1out,c1out,c2out,selc1: std_logic;
signal andn1,andz1,andc1: std_logic:= '0';
begin
selc1<=setc or carryin;
c1: mux2 port map(carryin,'1',selc1,c1out);
c2: mux2 port map('0',c1out,andc1,c2out);
andc1<=jzin and c2out;

n1: mux2 port map('0',negin,andn1,n1out);
andn1<=jnin and n1out;

z1:mux2 port map('0',zeroin,andz1,z1out);
andz1<=jzin and z1out;

branch<=andn1 or andc1 or andz1 or jmpin;

end architecture;
