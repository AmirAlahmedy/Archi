Library IEEE;
USE IEEE.std_logic_1164.all;
Entity pc_reg is
  generic ( n: integer:=32);
  Port(clk,rst: in std_logic; q :out std_logic_vector(n-1 downto 0); d:in std_logic_vector(n-1 downto 0));
  end pc_reg;
  
  architecture a_my_reg of pc_reg is 
  begin
    process(clk)
      begin
        if(rst='1') then
      q<=(OTHERS=>'0');
      elsif rising_edge(clk) then        q<=d;
      end if;
    end process;
     end a_my_reg;