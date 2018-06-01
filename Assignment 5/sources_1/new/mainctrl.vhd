----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.03.2018 22:39:35
-- Design Name: 
-- Module Name: mainctrl - Behavioral
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

entity mainctrl is
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
end mainctrl;

architecture Behavioral of mainctrl is
signal pval : std_logic;
begin
pval <= p;
process(state, pval, p)
	begin
		if(state="0000") then
			pw <='1';
			iw <='1';
			mr <='1';
			iord <='0';
			asrc1 <='0';
			asrc2 <="01";
		elsif(state="0001") then
			aw <='1';
			bw <='1';
			rsrc <='0';
		elsif(state="0010") then
			resw <='1';
			fset <=pval;
			asrc1 <='1';
			asrc2 <="00";
		elsif(state="0011") then
			rw <=pval;
			m2r<='0';
		elsif(state="0100") then
			resw <='1';
			asrc1<='1';
			asrc2<="10";
			rsrc<='1';
		elsif(state="0101") then
			mw <=pval;
			iord<='1';
		elsif(state="0110") then
			mr <='1';
			dw <='1';
			iord<='1';
		elsif(state="0111") then
			mr <=pval;
			m2r<='1';
		else 
			pw <=pval;
			asrc1<='0';
			asrc2<="11";
		end if;
	end process;


end Behavioral;
