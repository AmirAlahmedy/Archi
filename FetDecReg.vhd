Library IEEE;
USE IEEE.std_logic_1164.all;
Entity FetDecReg is

  Port(clk,rst: in std_logic; 
Rdst :in std_logic_vector(2 downto 0);
 Rsrc: in std_logic_vector(2 downto 0);
Rdstout :out std_logic_vector(2 downto 0);
 Rsrcout: out std_logic_vector(2 downto 0);
Atype:in std_logic;
Aluop:in std_logic;
RegWrite:in std_logic;
Atypeout:out std_logic;
Aluopout:out std_logic;
SHAMTiN:IN STD_LOGIC_VECTOR(4 DOWNTO 0);
SHAMTOUT:OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
RegWriteout:out std_logic;
Funcin:in std_logic_vector(2 downto 0);
funcout:out std_logic_vector(2 downto 0)
);
  end FetDecReg;
  
  architecture a_FetDecReg of FetDecReg is 
  begin
    process(clk)
      begin
        if(rst='1') then
funcout<="000";
SHAMTOUT<="00000";
Atypeout<='0';
Aluopout<='0';
RegWriteout<='0';
      Rdstout<= (others=>'0');
 Rsrcout<= (others=>'0');
      elsif FALLING_edge(clk) then
funcout<=funcin;
SHAMTOUT<=shamtin;
Atypeout<=Atype;
Aluopout<=Aluop;
RegWriteout<=rEGwRITE;
    Rdstout<= Rdst;
 Rsrcout<= Rsrc;
      end if;
    end process;
     end a_FetDecReg;
