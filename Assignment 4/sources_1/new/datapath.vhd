----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.03.2018 16:05:56
-- Design Name: 
-- Module Name: datapath - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is
Port 
(
    clka: in std_logic;
	 PW: in std_logic;
	 IorD: in std_logic;
	 IW : in std_logic;
	 DW : in std_logic;
	 MW : in std_logic_vector(3 downto 0);
	 MR : in std_logic;
	 M2R: in std_logic;
	 AW : in std_logic;
	 BW : in std_logic;
	 ASRC1: in std_logic;
	 ASRC2: in std_logic_vector(1 downto 0);
	 OP : in std_logic_vector(3 downto 0);
	 AorM : in std_logic;
	 AorS : in std_logic;
	 RSRC: in std_logic;
	 FSET: in std_logic;
	 ReW: in std_logic;
	 RW : in std_logic;
	 pmenable : in std_logic;
	 BorHWcontrol : in std_logic;
	 ZorScontrol : in std_logic;
	 pminput : in std_logic_vector(1 downto 0);
	 flagstatus : out std_logic_vector(3 downto 0);
	 instruct : out std_logic_vector(31 downto 0);
	 shifttype: in std_logic_vector(1 downto 0);
	 shiftamtcontrol : in std_logic

);
end datapath;

architecture Behavioral of datapath is
component ALU is 	
	port(     
		op1, op2: in std_logic_vector(31 downto 0);
	    carry: in std_logic;
	    ins: in std_logic_vector(3 downto 0);
	    s: inout std_logic_vector(31 downto 0);
	    flag: out std_logic_vector(3 downto 0)
	);
end component;

component REG is 
	port(
		control: in std_logic;
    	clk:in std_logic;
		ltdt:in std_logic_vector(31 downto 0);
		rtdt:out std_logic_vector(31 downto 0)
	);
end component;

--component MEM is
--	port(
--		clk: in std_logic;
--		ad: in std_logic_vector(31 downto 0);
--		Wen: in std_logic;
--		Ren: in std_logic;
--		wdt: in std_logic_vector(31 downto 0);
--		rdt: out std_logic_vector(31 downto 0)
--	 );
--end component;

component BRAM_wrapper is
  port (
    BRAM_PORTA_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_clk : in STD_LOGIC;
    BRAM_PORTA_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
    BRAM_PORTA_en : in STD_LOGIC;
    BRAM_PORTA_rst : in STD_LOGIC;
    BRAM_PORTA_we : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
end component;


component SE is
	port(
		cin: in std_logic_vector(11 downto 0);
	 	cout: out std_logic_vector(31 downto 0)
	 );
end component;

component S2 is
	port(
		cin: in std_logic_vector(23 downto 0);
		cout: out std_logic_vector(31 downto 0)
		);
end component;

component RF is
	port(
		clk:in std_logic;
		wen:in std_logic;
		rd1:in std_logic_vector(3 downto 0);
		rd2:in std_logic_vector(3 downto 0);
		wad:in std_logic_vector(3 downto 0);
		wdt:in std_logic_vector(31 downto 0);
		out1:out std_logic_vector(31 downto 0);
		out2:out std_logic_vector(31 downto 0)
	);
end component;

component MUX is
	port(
		in1 : in std_logic_vector(31 downto 0);
		in2 : in std_logic_vector(31 downto 0);
		output : out std_logic_vector(31 downto 0);
		control : in std_logic
		);
end component;

component BIGMUX is
	port(
		in1 : in std_logic_vector(31 downto 0);
		in2 : in std_logic_vector(31 downto 0);
		in3 : in std_logic_vector(31 downto 0);
		in4 : in std_logic_vector(31 downto 0);
		output : out std_logic_vector(31 downto 0);
		control : in std_logic_vector(1 downto 0)
		);
end component;

component FLAGS is
	port(flagin: in std_logic_vector(3 downto 0);
	 flagout: out std_logic_vector(3 downto 0);
	 fset: in std_logic
)	;
end component;

component MUL is 
	port(
	op1, op2: in std_logic_vector(31 downto 0);
    s: inout std_logic_vector(31 downto 0);
    flag: out std_logic_vector(3 downto 0)
	);
end component;
component SHIFTER is
	port(
		input: in std_logic_vector(31 downto 0);
	    s_type: in std_logic_vector(1 downto 0);
	    amount: in std_logic_vector(4 downto 0);
	    cin: in std_logic_vector(3 downto 0);
	    cout: out std_logic_vector(3 downto 0);
	    output: out std_logic_vector(31 downto 0)
		);
end component;
component PMS is 
	port(
		wordin : in std_logic_vector(31 downto 0);
		BorHW : in std_logic;
		outword : out std_logic_vector(31 downto 0)
);
end component;
component PML is 
	port(
		wordin : in std_logic_vector(31 downto 0);
		addr : in std_logic_vector(1 downto 0);
		BorHW : in std_logic;
		ZorS : in std_logic;
		outword : out std_logic_vector(31 downto 0)
);
end component;
component MUX4vala is
Port 
( 
     in1 : in std_logic_vector(3 downto 0);
    in2 : in std_logic_vector(3 downto 0);
    output : out std_logic_vector(3 downto 0);
    control : in std_logic
);
end component;
component MUX5vala is
Port 
( 
     in1 : in std_logic_vector(4 downto 0);
    in2 : in std_logic_vector(4 downto 0);
    output : out std_logic_vector(4 downto 0);
    control : in std_logic
);
end component;

signal pupdate :std_logic_vector(31 downto 0) := (others => '0');
signal pmsout :std_logic_vector(31 downto 0) := (others => '0');
signal pmlout :std_logic_vector(31 downto 0) := (others => '0');
signal presentp :std_logic_vector(31 downto 0) := (others => '0');
signal iordout :std_logic_vector(31 downto 0) := (others => '0');
signal instruction :std_logic_vector(31 downto 0) := (others => '0');
signal irout :std_logic_vector(31 downto 0) := (others => '0');
signal rdad1 :std_logic_vector(3 downto 0) := (others => '0');
signal rdad2_1 :std_logic_vector(3 downto 0) := (others => '0');
signal rdad2_2 :std_logic_vector(3 downto 0) := (others => '0');
signal wrad :std_logic_vector(3 downto 0) := (others => '0');

signal const :std_logic_vector(11 downto 0) := (others => '0');
signal branch :std_logic_vector(23 downto 0) := (others => '0');
signal sconst :std_logic_vector(31 downto 0) := (others => '0');
signal sbranch :std_logic_vector(31 downto 0) := (others => '0');

signal rdad2 :std_logic_vector(3 downto 0) := (others => '0');
signal reg1 :std_logic_vector(31 downto 0) := (others => '0');
signal reg2 :std_logic_vector(31 downto 0) := (others => '0');
signal aout :std_logic_vector(31 downto 0) := (others => '0');
signal bout :std_logic_vector(31 downto 0) := (others => '0');
signal op1 :std_logic_vector(31 downto 0) := (others => '0');
signal op2 :std_logic_vector(31 downto 0) := (others => '0');
signal four :std_logic_vector(31 downto 0) := (others => '0');
signal alures :std_logic_vector(31 downto 0) := (others => '0');
signal mulres :std_logic_vector(31 downto 0) := (others => '0');
signal res :std_logic_vector(31 downto 0) := (others => '0');
signal muxout :std_logic_vector(31 downto 0) := (others => '0');

signal aluflags :std_logic_vector(3 downto 0) := (others => '0');
signal mulflags :std_logic_vector(3 downto 0) := (others => '0');
signal tempflags :std_logic_vector(3 downto 0) := (others => '0');
signal shifterflags :std_logic_vector(3 downto 0) := (others => '0');
signal flagsout :std_logic_vector(3 downto 0) := (others => '0');
signal flagsin :std_logic_vector(3 downto 0) := (others => '0');

signal resout :std_logic_vector(31 downto 0) := (others => '0');
signal drout :std_logic_vector(31 downto 0) := (others => '0');
signal wrdt :std_logic_vector(31 downto 0) := (others => '0');
signal mrext :std_logic_vector(3 downto 0) := (others => '0');
signal ldrdt :std_logic_vector(31 downto 0) := (others => '0');
signal strdt :std_logic_vector(31 downto 0) := (others => '0');
signal shiftamt: std_logic_vector(4 downto 0) := (others=> '0');
signal samount: std_logic_vector(4 downto 0) := (others=> '0');
signal ramount: std_logic_vector(4 downto 0) := (others=> '0');
signal memenable : std_logic;
begin
rdad1 <= instruction(19 downto 16);
rdad2_1 <= instruction(3 downto 0);
rdad2_2 <= instruction(15 downto 12);
wrad <= instruction(15 downto 12);
const <= instruction(11 downto 0);
branch <= instruction(23 downto 0);
four <= "00000000000000000000000000000100";
instruct <= instruction;
samount <= instruction(11 downto 7);
ramount(3 downto 0) <= instruction(11 downto 8);
memenable <= MR OR MW(0) OR MW(1) OR MW(2) OR MW(3);
--with MR select mrext <=
--    "0000" when '0',
--    "1111" when '1';

compPC : REG port map                        
(	control => PW,
	clk => clka,
	ltdt => pupdate,
	rtdt => presentp
);

strmem : PMS port map
(
	wordin => resout,
	BorHW => BorHWcontrol,
	outword => pmsout
);


pmsmux : MUX port map
( 	in1 => pmsout,
	in2 => resout,
	output => strdt,
	control => pmenable
);

compIorD: MUX port map
(	in1 => presentp,
	in2 => strdt,
	output => IorDout,
	control => IorD);
--compMem: MEM port map
--(	clk => clka,
--	ad  => IorDout,
--	Wen => MW,
--	Ren => MR,
--	wdt => bout,
--	rdt => instruction);
compMem: BRAM_wrapper port map
(	
	BRAM_PORTA_addr=> IorDout,
        BRAM_PORTA_clk => clka,
        BRAM_PORTA_din => bout,
        BRAM_PORTA_dout => instruction,
        BRAM_PORTA_en => memenable,
        BRAM_PORTA_rst => '0',
        BRAM_PORTA_we => MW);
	
compIR : REG port map
(	control => IW,
	clk => clka,
	ltdt => instruction, 
	rtdt => irout);
DR : REG port map
(	control => DW,
	clk => clka,
	ltdt => instruction,
	rtdt => drout);
PMLs : PML port map
( 	wordin => drout,
	addr => pminput,
	BorHW =>  borhwcontrol,
	ZorS =>  zorscontrol,
	outword => ldrdt
);
pmlmux : MUX port map
( 	in1 => ldrdt,
	in2 => drout,
	output => pmlout,
	control => pmenable
);
mux4: MUX port map
(	in1 => pmlout,
	in2 => resout,
	output => wrdt,
	control => M2R);
compReg: RF port map
(	rd1 => rdad1,
	rd2 => rdad2,
	wad => wrad,
	wdt => wrdt,
	out1 => reg1,
	out2 => reg2,
	wen => RW,
	clk => clka);
mux2: MUX4vala port map
(	in1 => rdad2_1,
	in2 => rdad2_2,
	output => rdad2,
	control => Rsrc);

A : REG port map
(	control => AW,
	clk => clka,
	ltdt => reg1,
	rtdt => aout);
B : reg port map
(	control => BW,
	clk => clka,
	ltdt => reg2,
	rtdt => bout);
compmux: MUX port map
(	in1 => presentp,
	in2 => aout,
	output => op1,
	control => Asrc1);
compSE : SE port map
(	cin => const,
	cout =>sconst);
compS2 : S2 port map
(	cin => branch,
	cout =>sbranch);
mux3 : BIGMUX port map
(	in1 => bout,
	in2 => four,
	in3 => sconst,
	in4 => sbranch,
	output => muxout,
	control => Asrc2);
compShifter : SHIFTER port map
(	input  	=> muxout,
	s_type 	=> shifttype, 
	amount 	=> shiftamt,
	cin 	=> flagsin,
	cout 	=> shifterflags,
	output	=> op2);
shiftamount : MUX5vala port map
    (    in1 => samount,
        in2 => ramount,
        output => shiftamt,
        control => shiftamtcontrol);	
compALU : ALU port map
(	op1 => op1,
	op2 => op2,
	carry => flagsin(1), 
	s => alures,
	flag => aluflags,
	ins => OP);
compMultiplier : MUL port map
(	op1  => op1,
 	op2 => op2,
    s => mulres,
    flag => mulflags);
mux5 : MUX port map
(	in1 => alures,
	in2 => mulres,
	output => res,
	control => AorM);
compRes : REG port map
(	control => ReW,
	clk => clka,
	ltdt => res,
	rtdt => resout);
mux6 : MUX4vala port map
(	in1 => aluflags,
	in2 => mulflags,
	output => tempflags,
	control => AorM);
mux7 : MUX4vala port map
(	in1 => tempflags,
	in2 => shifterflags,
	output => flagsout,
	control => AorS);

compFlags : FLAGS port map
(	flagin => flagsout,
	flagout=> flagsin,
	fset => Fset);
end Behavioral;