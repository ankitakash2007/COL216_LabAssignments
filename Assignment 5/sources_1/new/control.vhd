----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.03.2018 22:32:11
-- Design Name: 
-- Module Name: control - Behavioral
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

entity control is
Port 
( 
    ins: in std_logic_vector(31 downto 0);
    flags: in std_logic_vector(3 downto 0);
    clk: in std_logic;
    Rsrc, MR, M2R, Asrc1, IorD, IW, DW, AW, BW, ResW, PW, MW, Fset, RW: out std_logic;
    Asrc2: out std_logic_vector(1 downto 0);
    op: out std_logic_vector(3 downto 0)
);
end control;

architecture Behavioral of control is
component bctrl is
Port 
( 
    ins : in std_logic_vector(3 downto 0);
	flags : in std_logic_vector(3 downto 0);
	s : out std_logic
);
end component;
component nextstate is
Port 
( 
    ins: in std_logic_vector(2 downto 0);
    curstate: in std_logic_vector(3 downto 0);
    nextstate: out std_logic_vector(3 downto 0)
);
end component;
component actrl is
Port 
( 
    ins: in std_logic_vector(6 downto 0);
	op: out std_logic_vector(3 downto 0)
);
end component;
component reg is
Port 
( 
    instate: in std_logic_vector(3 downto 0);
    clk: in std_logic;
    outstate: out std_logic_vector(3 downto 0)
);
end component;
component mainctrl is
Port 
( 
    state : in std_logic_vector(3 downto 0);
    p: in std_logic;
	 rsrc : out std_logic;
	 mr : out std_logic;
	 m2r :  out std_logic;
	 asrc1 :  out std_logic;
	 asrc2 :  out std_logic_vector(1 downto 0);
	 iord :  out std_logic;
	 iw :  out std_logic;
	 dw :  out std_logic;
	 aw :  out std_logic;
	 bw :  out std_logic;
	 resw :  out std_logic;
	 pw: out std_logic;
	 fset: out std_logic;
	 rw: out std_logic;
	 mw: out std_logic
	 
);
end component;
signal p: std_logic;
signal curstatesig: std_logic_vector(3 downto 0):="0000";
signal nextstatesig: std_logic_vector(3 downto 0);
begin
ibctrl : bctrl port map                        
(	ins=>ins(31 downto 28),
    flags=>flags,
    s=>p
);
inextstate : nextstate port map
(
    ins(2 downto 1)=>ins(27 downto 26),
    ins(0)=>ins(20),
    curstate=> curstatesig,
    nextstate=> nextstatesig
);
ireg : reg port map                        
(	instate=>nextstatesig,
    clk=>clk,
    outstate=>curstatesig
);
iactrl : actrl port map                        
(	ins=>ins(27 downto 21),
    op=>op
);
imainctrl : mainctrl port map
( 
    state=>curstatesig,
    p=>p,
	 rsrc=>rsrc,
	 mr=>mr,
	 m2r=>m2r,
	 asrc1=>asrc1,
	 asrc2=>asrc2,
	 iord=>iord,
	 iw=>iw,
	 dw=>dw,
	 aw=>aw,
	 bw=>bw,
	 resw=>resw,
	 pw=>pw,
	 fset=>fset,
	 rw=>rw,
	 mw=>mw
	 
);
    
    


end Behavioral;
