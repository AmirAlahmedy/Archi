LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is 
  generic(n:integer:=16);
	port (
      input1:in std_logic_vector(n-1 downto 0); --Rsrc
      input2:in std_logic_vector(n-1 downto 0); --Rdest
      shamt:in std_logic_vector(3 downto 0);
      enable: in std_logic;
      clk: in std_logic;
      sel : in std_logic_vector(3 downto 0);
      output:out std_logic_vector(n-1 downto 0); -- fl multiplication bta3 Rdst
      upperbyte:out std_logic_vector(n-1 downto 0); --bta3 el multiplication of Rsrc
      carry: out std_logic;
      zero:out std_logic;
      negative:out std_logic
);
end ALU;

architecture aluu of Alu is 

component add is 
  generic(n:integer:=16);
	port (
      input1:in std_logic_vector(n-1 downto 0);
      input2:in std_logic_vector(n-1 downto 0);
      output:out std_logic_vector(n-1 downto 0);
      carry: out std_logic); 
end component;
component shiftl is 
  generic(n:integer:=16);
	port (
      input1:in std_logic_vector(n-1 downto 0);
      shamt: in std_logic_vector(3 downto 0);
      output:out std_logic_vector(n-1 downto 0);
      carry: out std_logic);
end component;

component shiftr is 
  generic(n:integer:=16);
	port (
      input1:in std_logic_vector(n-1 downto 0);
        shamt: in std_logic_vector(3 downto 0);
      output:out std_logic_vector(n-1 downto 0);
      carry: out std_logic

);
end component;

component sub is 
  generic(n:integer:=16);
	port (
      input1:in std_logic_vector(n-1 downto 0);
      input2:in std_logic_vector(n-1 downto 0);
      output:out std_logic_vector(n-1 downto 0);
      carry: out std_logic
);
end component;

signal mul: std_logic_vector(n+n-1 downto 0);
signal output1:std_logic_Vector(n-1 downto 0);
signal output_add1:std_logic_vector(n-1 downto 0);
signal carry_add1:std_logic;
signal output_add2:std_logic_vector(n-1 downto 0);
signal carry_add2:std_logic;
signal output_sub1:std_logic_vector(n-1 downto 0);
signal carry_sub1:std_logic;
signal output_sub2:std_logic_vector(n-1 downto 0);
signal carry_sub2:std_logic;
signal output_shl:std_logic_vector(n-1 downto 0);
signal carry_shl:std_logic;
signal output_shr:std_logic_vector(n-1 downto 0);
signal carry_shr:std_logic;
signal zero1:std_logic;
signal output_and:std_logic_vector(n-1 downto 0);
signal output_not:std_logic_vector(n-1 downto 0);
signal output_or:std_logic_vector(n-1 downto 0);
begin 
add1:add generic map(n) port map(input1,input2,output_add1,carry_add1);
sub1:sub generic map(n) port map(input1,input2,output_sub1,carry_sub1);
sub2:sub generic map(n) port map(input2,std_logic_vector(to_unsigned(1, n)),output_sub2,carry_sub2);
add2:add generic map (n) port map (input2,std_logic_vector(to_unsigned(1, n)),output_add2,carry_add2);
shl:shiftl generic map(n) port map(input2,shamt,output_shl,carry_shl);
shr:shiftr generic map(n) port map(input2,shamt,output_shr,carry_shr);

 
process(enable,clk)
begin
if(enable='0'  ) then 
output<=(others=>'Z');
upperbyte<=(others=>'Z');
elsif (enable='1' and rising_edge(clk)) then 
   if(sel="0000") then -- move
output<=input1; --Rsrc
elsif(sel ="0001") then --addition
output<=output_add1;
carry<=carry_add1;
if(unsigned(output_add1(n-1 downto 0))=to_unsigned(0,n)) then 
zero<='1';
else 
zero<='0';
end if;
negative<=output_add1(n-1);
elsif(sel="0010") then  --multiplication
mul <= std_logic_vector(unsigned(input1) * unsigned(input2));
output<=mul(15 downto 0);
upperbyte<=mul(31 downto 16);
carry<='0';
if(unsigned(mul(15 downto 0))=to_unsigned(0,n)) then 
zero<='1';
else 
zero<='0';
end if;
negative<=mul(15);
elsif (sel="0011") then -- subtraction
output<=output_sub1;
carry<=carry_sub1;
if(unsigned(output_sub1(n-1 downto 0))=to_unsigned(0,n)) then 
zero<='1';
else 
zero<='0';
end if;
negative<=output_sub1(n-1);
elsif (sel="0100") then --And 
output_and<=input1 and input2;
output<=output_and;
carry<='0';
if(unsigned(output_and(n-1 downto 0))=to_unsigned(0,n)) then 
zero<='1';
else 
zero<='0';
end if;
negative<=output_and(n-1);
elsif(sel ="0101") then 
output_or<=input1 or input2;
output<=output_or;
carry<='0';
if(unsigned(output_or(n-1 downto 0))=to_unsigned(0,n)) then 
zero<='1';
else 
zero<='0';
end if;
negative<=output_or(n-1);
elsif (sel="0110") then 
output<=output_shl;
carry<=carry_shl;
if(unsigned(output_shl(n-1 downto 0))=to_unsigned(0,n)) then 
zero<='1';
else 
zero<='0';
end if;
negative<=output_shl(n-1);
elsif (sel="0111") then 
output<=output_shr;
carry<=carry_shr;
if(unsigned(output_shr(n-1 downto 0))=to_unsigned(0,n)) then 
zero<='1';
else 
zero<='0';
end if;
negative<=output_shr(n-1);
elsif(sel="1000") then 
output<=output_add2;
carry<=carry_add2;
if(unsigned(output_add2(n-1 downto 0))=to_unsigned(0,n)) then 
zero<='1';
else 
zero<='0';
end if;
negative<=output_add2(n-1);
elsif(sel="1001") then 
output<=output_sub2;
carry<=carry_sub2;
if(unsigned(output_add2(n-1 downto 0))=to_unsigned(0,n)) then 
zero<='1';
else 
zero<='0';
end if;
negative<=output_add2(n-1);
elsif (sel="1010") then 
output_not<= not(input2);
output<=output_not;
carry<='0';  
if(unsigned(output_not(n-1 downto 0))=to_unsigned(0,n)) then 
zero<='1';
else 
zero<='0';
end if;
negative<=output_not(n-1);
end if;
end if;


end process;


end architecture;



