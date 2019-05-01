LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ConrtolUnit is 

	port (
      clk: in std_logic;
      optype:in std_logic_vector(1 downto 0);
      func:in std_logic_vector(2 downto 0);
CALL:out std_logic;
RTI:out std_logic;
RET:out std_logic;
INT:out std_logic;
CARRY:out std_logic;
PUSH:out std_logic;
POP:out std_logic;
STORE:out std_logic;
LDM:out std_logic;
LDD:out std_logic;
MULT:out std_logic;
INPUT:out std_logic;
OUTPUT:out std_logic;
JN:out std_logic;
JZ:out std_logic;
JC:out std_logic;
JMP:out std_logic;
RESTOREFLAG:out std_logic;
ATYPE:out std_logic;
RTYPE:out std_logic;
RegWrite:out std_logic
);
end ConrtolUnit;

architecture CU of ConrtolUnit is

begin 
process(clk)
begin
if (falling_edge(clk)) then
CALL<='0';
RTI<='0';
RET<='0';
INT<='0';
CARRY<='0';
PUSH<='0';
POP<='0';
STORE<='0';
LDM<='0';
LDD<='0';
MULT<='0';
INPUT<='0';
OUTPUT<='0';
JN<='0';
JZ<='0';
JC<='0';
JMP<='0';
RESTOREFLAG<='0';
ATYPE<='0';
RTYPE<='0';
RegWrite<='0';

if(optype="00")then

RTYPE<='1';
regWrite<='1';

if(func="000")then
MULT<='1';
else
MULT<='0';
end if;

elsif(optype="01") then

if(func="000")then
PUSH<='1';
elsif(func="001")then
POP<='1';
elsif(func="010")then
LDM<='1';
elsif(func="011")then
LDD<='1';
elsif(func="100")then
STORE<='1';
elsif(func="101")then
INT<='1';
elsif(func="110")then
CARRY<='1';
else
PUSH<='0';
POP<='0';
LDM<='0';
LDD<='0';
STORE<='0';
end if;

elsif(optype="10")then

if(func="000" or func="001" or func="010") then 
ATYPE<='1';
Rtype<='1';
regWrite<='1';
elsif(func="011")then
INPUT<='1';
elsif(func="100")then
OUTPUT<='1';
end if;

elsif(optype="11")then

if(func="000")then
JZ<='1';
elsif(func="001")then
JN<='1';
elsif(func="010")then
JC<='1';
elsif(func="011")then
JMP<='1';
elsif(func="100")then
CALL<='1';
elsif(func="101")then
RET<='1';
elsif(func="110")then
RTI<='1';
elsif(func="111")then
RESTOREFLAG<='1';
end if;

end if;



end if;
end process;
end CU;  
