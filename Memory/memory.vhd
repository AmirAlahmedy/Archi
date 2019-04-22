LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY memory IS
GENERIC (n : integer := 20; m: integer:=16);
	PORT(
		clk : IN std_logic;
		EnableSatck  : IN std_logic; --high for the stack to function
		MemW  : IN std_logic; --Write to memo if high
		address : IN  std_logic_vector(31 DOWNTO 0);
		WriteData  : IN  std_logic_vector(m-1 DOWNTO 0);
		ReadData : OUT std_logic_vector(m-1 DOWNTO 0);
		
		--Outputs of the IF memory
		OP : OUT std_logic_vector(4 DOWNTO 0);
		Rdst : OUT std_logic_vector(2 DOWNTO 0);
		Rsrc : OUT std_logic_vector(2 DOWNTO 0);
		Shamt : OUT std_logic_vector(4 DOWNTO 0);
		EA : OUT std_logic_vector(n-1 DOWNTO 0);
		Imm : OUT std_logic_vector(m-1 DOWNTO 0));
END ENTITY memory;

ARCHITECTURE memory_unit OF memory IS

COMPONENT fetch_ram IS
	PORT(
		clk : IN std_logic;
		address : IN  std_logic_vector(31 DOWNTO 0);
		

		--Outputs of the IF memory
		OP : OUT std_logic_vector(4 DOWNTO 0);
		Rdst : OUT std_logic_vector(2 DOWNTO 0);
		Rsrc : OUT std_logic_vector(2 DOWNTO 0);
		Shamt : OUT std_logic_vector(4 DOWNTO 0);
		EA : OUT std_logic_vector(n-1 DOWNTO 0);
		Imm : OUT std_logic_vector(m-1 DOWNTO 0));
		

END COMPONENT;
COMPONENT data_ram IS
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		address : IN  std_logic_vector(31 DOWNTO 0);
		datain  : IN  std_logic_vector(m-1 DOWNTO 0);
		dataout : OUT std_logic_vector(m-1 DOWNTO 0));
END COMPONENT;
COMPONENT stack is
port(   Clk : in std_logic;  
        Reset : in std_logic; 
        Enable : in std_logic;  
        Data_In : in std_logic_vector(15 downto 0);  
        Data_Out : out std_logic_vector(15 downto 0);  
        PUSH_barPOP : in std_logic;  
        Stack_Full : out std_logic;  
        Stack_Empty : out std_logic  
        );
end COMPONENT;


	--TYPE ram_type IS ARRAY(0 TO 1048575) OF std_logic_vector(m-1 DOWNTO 0);
	--SIGNAL memory : ram_type ;
	SIGNAL fullStack : std_logic;
	SIGNAL emptyStack : std_logic;
	SIGNAL resetStack : std_logic := '0';
	
	BEGIN

	FETCH: fetch_ram port map(clk, address, OP, Rdst, Rsrc, Shamt, EA, Imm);
	DATA:  data_ram port map(clk, MemW, address, WriteData, ReadData);
	STCK: stack port map(Clk=>clk, Reset=>resetStack, Enable=>EnableSatck, PUSH_barPOP=>MemW, Data_In=>WriteData, Data_Out=>ReadData, Stack_Full=>fullStack, Stack_Empty=>emptyStack);
		
END memory_unit;