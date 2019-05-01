LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
--****************************************eb2a eb3at regwrite w regaddress lel alu ya 5awal*******************

entity INT is
GENERIC (n : integer := 20; m: integer:=16);
port (
ResetFetDec: in std_logic;
PC : in std_logic_vector (31 downto 0 );
Clk : in std_logic ;
ResetDecAlu:in std_logic;
resetALUMEM:IN STD_LOGIC;
resetMEMWB: std_logic;
resetPC: in std_logic); 
end INT;

architecture ARC of INT is 

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

COMPONENT ALU is 
  generic(n:integer:=16);
	port (
      input1:in std_logic_vector(n-1 downto 0); --Rsrc
      input2:in std_logic_vector(n-1 downto 0); --Rdest
      shamt:in std_logic_vector(4 downto 0);
      enable: in std_logic;
      clk: in std_logic;
Atype:in std_logic;
      sel : in std_logic_vector(2 downto 0);
      output:out std_logic_vector(n-1 downto 0); -- fl multiplication bta3 Rdst
      upperbyte:out std_logic_vector(n-1 downto 0); --bta3 el multiplication of Rsrc
      carry: out std_logic;
      zero:out std_logic;
      negative:out std_logic
);
end COMPONENT;
Component my_reg is
  Port(clk,rst: in std_logic; q :out std_logic_vector(31 downto 0); d:in std_logic_vector(31 downto 0));
  end component;
  
component decoder IS
	PORT(
		clk : IN std_logic;
		addressread1 : IN  std_logic_vector(2 DOWNTO 0); --Rsrc
                addressread2 : IN  std_logic_vector(2 DOWNTO 0); --Rsrc 
                addresswrite: In std_logic_vector(2 downto 0);
                regwrite: In std_logic;
                writedata:in std_logic_vector(15 downto 0);
		readreg1:out std_logic_vector(15 downto 0); --Rsrc
                readreg2:out std_logic_vector(15 downto 0)); --Rsrc
END component;


component ConrtolUnit is 

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
end component;

COMPONENT FetDecReg is

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
END COMPONENT;
COMPONENT DecALUREG is

  Port(clk,rst: in std_logic; 
Rdst :in std_logic_vector(15 downto 0);
 Rsrc: in std_logic_vector(15 downto 0);
Rdstout :out std_logic_vector(15 downto 0);
 Rsrcout: out std_logic_vector(15 downto 0);
Atype:in std_logic;
Aluop:in std_logic;
RegWrite:in std_logic;
Atypeout:out std_logic;
Aluopout:out std_logic;
RegWriteout:out std_logic;
RdstAddress : out std_logic_vector (2 downto 0);
RdstAddressIn : in std_logic_vector (2 downto 0);
shamtin:in std_logic_vector(4 downto 0);
shamtout:out std_logic_vector(4 downto 0);
Funcin:in std_logic_vector(2 downto 0);
funcout:out std_logic_vector(2 downto 0)
);
  end COMPONENT;

--**************************************************************ALUMEMREG*****************************************
COMPONENT ALUMEMREG is

  Port(clk,rst: in std_logic; 
RdstaDDRESS :in std_logic_vector(2 downto 0);
Rdstaddressout :out std_logic_vector(2 downto 0);
 Rdstdatain: in std_logic_vector(15 downto 0);
RdstDataout: out std_logic_vector(15 downto 0);
Regwrite:in std_logic;
regwriteout:out std_logic
);
  end COMPONENT;
--**********************************************************************************************************************
Component Pc_Adder is
  generic ( n: integer:=32);
  Port(
rst:in std_logic;
Clk : in std_logic;
PC : IN std_logic_vector (31 downto 0 );
AddAmount : in Std_logic_vector (1 downto 0);
PCOut : out std_logic_vector (31 downto 0)
);
  end Component;

Component MEMWBREG is

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
  end Component;
  
signal RdstFet,RsrcFet : std_logic_vector (2 downto 0);
signal ShamtFet : std_logic_vector ( 4 downto 0 ) ;
signal EAFet : std_logic_vector ( 19 downto 0);
signal ImmFet : std_logic_vector (15 downto 0 );
signal RegFetDecRdOut : std_logic_vector (2 downto 0 );
signal RegFetDecRsOut : std_logic_vector (2 downto 0 );
signal AluOut : std_logic_vector (15 downto 0 );
signal Regwrite_dECODER : std_logic;
signal DecAluRsrc,DecAluRdst : std_logic_vector ( 15 downto 0);
signal PCout : std_logic_vector (31 downto 0 );
signal newPC : std_logic_vector (31 downto 0 );
signal OP_Func_FetchRam : std_logic_vector (4 downto 0 );
SIGNAL Atype_Decoder:std_logic;
signal AluOp_Decoder:std_logic;
signal CALL: std_logic;
signal RTI: std_logic;
signal RET: std_logic;
signal INT: std_logic;
signal CARRY: std_logic;
signal PUSH: std_logic;
signal POP: std_logic;
signal STORE: std_logic;
signal LDM: std_logic;
signal LDD: std_logic;
signal MULT: std_logic;
signal INPUT: std_logic;
signal OUTPUT: std_logic;
signal JN: std_logic;
signal JZ: std_logic;
signal JC: std_logic;
signal JMP: std_logic;
signal RESTOREFLAG: std_logic;
signal ATYPE: std_logic;
signal RTYPE: std_logic;
signal RegWrite: std_logic;
SIGNAL RSRC_ALu:std_logic_vector(15 downto 0);
SIGNAL RDest_ALu:std_logic_vector(15 downto 0);
signal ResdtAddress_ALU:std_logic_vector(2 downto 0); --Rdst given from buffer of dec-alu to Alu
signal Atype_DEC_ALU:STd_logic; --atype signal sent to Alu from decAlu buffer
signal ALuop_DEC_ALU:STd_logic; --atype signal sent to Alu from decAlu buffer
signal RegWrite_DEC_ALU:STd_logic; --atype signal sent to Alu from decAlu buffer
signal RdstAdress_DEC_ALU:STD_LOGIC_VECTOR(2 DOWNTO 0); --register address sent fron dec-alu buffer to alu-mem buffer
signal RdstValue_DEC_ALU:STD_LOGIC_VECTOR(2 DOWNTO 0); --register value sent fron dec-alu buffer to alu-mem buffer
signal shamt_fet_dec:std_logic_vector(4 downto 0); --shift amount sent from fetch to fetch-decode register
signal shamt_dec_alu:std_logic_vector(4 downto 0); --shift amount sent from decode to decode-alu register
signal func_fet_dec:std_logic_vector(2 downto 0); --function from fetch to fetch-decode register
signal func_dec_alu:std_logic_vector(2 downto 0); --fucnttion alu from decoder to dec-alu register
signal writeback_alu:std_logic_vector(15 downto 0); --write back data sent from alu to decoder
signal upperbyte:std_logic_vector(15 downto 0); --upper byte multiplication 
signal carryflag:std_logic; --CARRY FLAG
signal negative:std_logic; --NEGATIVE FLAG
signal zero:std_logic; --ZERO FLAG
SIGNAL regWrite_alu_mem:std_logic; -- register write signal sent to memeory but for now directly to decode 
signal writeback_alu_mem:std_logic_vector(15 downto 0);
signal RdstAddress_dec_alu:std_logic_vector(2 downto 0);
signal rdstAdress_alu_mem:std_logic_vector(2 downto 0); -- final address sent to decode from alu mem register
signal ImmValueIn,ImmValueOut,Higher2bytesOut,Lower2bytesOut,ReadDataOut :std_logic_vector(15 downto 0);
SIGNAL Mult2SigLast:std_logic;
SIGNAL rdstAddress_mem_wb:STD_LOGIC_VECTOR (2 DOWNTO 0) ;--- RDST ADD ROM LAST REGISTER
SIGNAL regWrite_mem_wb:STD_LOGIC;---WRITE BACK SIGNAL FROM LAST REGISTER
begin 
PC_count:my_reg port map (Clk,resetPC,PCout,newPC);
FETCH: fetch_ram port map(clk, PC, OP_Func_FetchRam, RdstFet, RsrcFet, ShamtFet, EAFet, ImmFet);
RegFetDec: FetDecReg port map(clk, ResetFetDec, RdstFet, RsrcFet,RegFetDecRdOut,RegFetDecRsOut,atype,RTYPE,REGWRITE,Atype_Decoder,Aluop_Decoder,ShamtFet,shamt_fet_dec,Regwrite_decoder,op_func_fetchram(2 downto 0),func_fet_dec);
REGDECALU: DecALUREG port map(clk,ResetDecALU,DecAluRdst,DecAluRsrc,RSRC_ALu,RDest_ALu,Atype_Decoder,Aluop_Decoder,Regwrite_decoder,Atype_DEC_ALU,ALuop_DEC_ALU,RegWrite_DEC_ALU,RdstAddress_dec_alu,RegFetDecRdOut,shamt_fet_dec,shamt_dec_alu,func_fet_dec,func_dec_alu);
ALU1:ALU PORT MAP(RSRC_ALu,RDest_ALu,"00000",ALuop_DEC_ALU,clk,Atype_DEC_ALU,func_dec_alu,writeback_alu_mem,upperbyte,carryflag,zero,negative);
Decode: decoder port map(clk, RegFetDecRsOut, RegFetDecRdOut,rdstAddress_mem_wb ,regWrite_mem_wb,Lower2bytesOut,DecAluRsrc,DecAluRdst );
PCAdder:Pc_Adder port map (resetPC,Clk,PCout,"01",newPC);
ContUnit:ConrtolUnit port map (Clk,OP_Func_FetchRam(4 downto 3),OP_Func_FetchRam(2 downto 0),CALL,RTI,RET,INT,CARRY,PUSH,POP,STORE,LDM,LDD,MULT,INPUT,OUTPUT,JN,JZ,JC,JMP,RESTOREFLAG,ATYPE,RTYPE,RegWrite);
REGALUMEM: ALUMEMREG port map(clk,resetALUMEM,RdstAddress_dec_alu,rdstAdress_alu_mem,writeback_alu_mem,writeback_alu,RegWrite_DEC_ALU,regWrite_alu_mem);
REGMEMWB : MEMWBREG port map(clk,resetMEMWB,UPPERBYTE,writeback_alu,"0000000000000000",'0',ImmValueIn,rdstAdress_alu_mem,rdstAddress_mem_wb,regWrite_alu_mem,regWrite_mem_wb,ImmValueOut,Higher2bytesOut,Lower2bytesOut,ReadDataOut,Mult2SigLast);

END ARCHITECTURE;