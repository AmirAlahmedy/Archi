LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY decoder IS
	PORT(
		clk : IN std_logic;
		addressread1 : IN  std_logic_vector(2 DOWNTO 0); --Rsrc
                addressread2 : IN  std_logic_vector(2 DOWNTO 0); --Rsrc 
                addresswrite: In std_logic_vector(2 downto 0);
                regwrite: In std_logic;
                writedata:in std_logic_vector(15 downto 0);
		readreg1:out std_logic_vector(15 downto 0); --Rsrc
                readreg2:out std_logic_vector(15 downto 0)); --Rsrc
END ENTITY decoder;

ARCHITECTURE syncrama OF decoder IS

	TYPE ram_type IS ARRAY(0 TO 2**(4-1)-1) OF std_logic_vector(16-1 DOWNTO 0);
	SIGNAL ram : ram_type ;
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF (falling_edge(clk) and regwrite='1') THEN  
					ram(to_integer(unsigned(addresswrite))) <= writedata ;
				END IF;
                               if( rising_edge(clk)) then 
                                   readreg1 <= ram(to_integer(unsigned(addressread1)));
                                   readreg2 <= ram(to_integer(unsigned(addressread2)));
                                end if;
		END PROCESS;
		
END syncrama;

