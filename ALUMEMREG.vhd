
Library IEEE;
USE IEEE.std_logic_1164.all;
Entity ALUMEMREG is

  Port(clk,rst: in std_logic; 
RdstaDDRESS :in std_logic_vector(2 downto 0);
Rdstaddressout :out std_logic_vector(2 downto 0);
 Rdstdatain: in std_logic_vector(15 downto 0);
RdstDataout: out std_logic_vector(15 downto 0);
Regwrite:in std_logic;
regwriteout:out std_logic
);
  end ALUMEMREG;
  
  architecture a_FetDecReg of ALUMEMREG is 
  begin
    process(clk)
      begin
        if(rst='1') then
regwriteout<='0';
   Rdstaddressout<= (others=>'0');
  RdstDataout<= (others=>'0');
      elsif rising_edge(clk) then
regwriteout<=Regwrite;
   Rdstaddressout<=RdstaDDRESS ;
  RdstDataout<= Rdstdatain ;
      end if;
    end process;
     end a_FetDecReg;