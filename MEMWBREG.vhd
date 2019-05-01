Library IEEE;
USE IEEE.std_logic_1164.all;
Entity MEMWBREG is

  Port(clk,rst: in std_logic; 
higher2bytes: in std_logic_vector(15 downto 0);
lower2bytes: in std_logic_vector(15 downto 0);
ReadDataIn :in std_logic_vector(15 downto 0);
MULT2signal: in std_logic;
ImmValue: in std_logic_vector(15 downto 0);
WriteAddIn: in std_logic_vector(2 downto 0);

WriteAddOut: out std_logic_vector(2 downto 0);
REGwriteSignalIn :in std_logic;
REGwriteSignalOut :out std_logic;
ImmValueOut:out std_logic_vector(15 downto 0);
higher2bytesOut:out std_logic_vector(15 downto 0);
lower2bytesOut:out std_logic_vector(15 downto 0);
ReadDataOut:out std_logic_vector(15 downto 0);
MULT2signalout:out std_logic
);
  end MEMWBREG;
  
  architecture a_MEMWBREG of MEMWBREG is 
  begin
    process(clk)
      begin
        if(rst='1') then
ImmValueOut<=(others=>'0');
higher2bytesOut<=(others=>'0');
lower2bytesOut<=(others=>'0');
MULT2signalout<='0';
ReadDataOut<=(others=>'0');
WriteAddOut<=(others=>'0');
REGwriteSignalOut <='0';

      elsif FALLING_edge(clk) then
ImmValueOut<=ImmValue;
higher2bytesOut<=higher2bytes ;
lower2bytesOut<=lower2bytes ;
MULT2signalout<=MULT2signal;
ReadDataOut<=ReadDataIn;
WriteAddOut<=WriteAddIn;
REGwriteSignalOut <=REGwriteSignalIn;
      end if;
    end process;
     end a_MEMWBREG;