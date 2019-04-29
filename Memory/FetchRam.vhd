LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY fetch_ram IS
GENERIC (n : integer := 20; m: integer:=16);
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
		

END ENTITY fetch_ram;

ARCHITECTURE syncrama OF fetch_ram IS

	TYPE ram_type IS ARRAY(0 TO 30) OF std_logic_vector(m-1 DOWNTO 0);
	SIGNAL ram : ram_type ;
	SIGNAL dataout : std_logic_vector(31 DOWNTO 0);
	alias upper: std_logic_vector(15 DOWNTO 0) is dataout(31 DOWNTO 16);
	alias lower: std_logic_vector(15 DOWNTO 0) is dataout(15 DOWNTO 0);
	BEGIN

		
		upper <= ram(to_integer(unsigned(address)));
		lower <= ram(to_integer(unsigned(address))+1);
		OP <= dataout(31 DOWNTO 27);
		Rdst <= dataout(26 DOWNTO 24);
		Rsrc <= dataout(23 DOWNTO 21);
		Shamt <= dataout(20 DOWNTO 16);
		EA <= dataout(23 DOWNTO 4);
		Imm <= dataout(23 DOWNTO 8);
		
END syncrama;
