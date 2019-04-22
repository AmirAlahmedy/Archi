LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY data_ram IS
GENERIC (n : integer := 20; m: integer:=16);
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		address : IN  std_logic_vector(31 DOWNTO 0);
		datain  : IN  std_logic_vector(m-1 DOWNTO 0);
		dataout : OUT std_logic_vector(m-1 DOWNTO 0));
END ENTITY data_ram;

ARCHITECTURE syncrama OF data_ram IS

	TYPE ram_type IS ARRAY(31 TO 1044478) OF std_logic_vector(m-1 DOWNTO 0);
	SIGNAL ram : ram_type ;
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF rising_edge(clk) THEN  
					IF we = '1' THEN
						ram(to_integer(unsigned(address))) <= datain;
					END IF;
				END IF;
		END PROCESS;
		dataout <= ram(to_integer(unsigned(address)));
END syncrama;
