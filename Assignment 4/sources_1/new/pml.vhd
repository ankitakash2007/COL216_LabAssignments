----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.03.2018 21:21:29
-- Design Name: 
-- Module Name: pms - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pml is
Port 
( 
    wordin : in std_logic_vector(31 downto 0);
	addr : in std_logic_vector(1 downto 0);
	BorHW : in std_logic;
	ZorS : in std_logic;
	outword : out std_logic_vector(31 downto 0)
);
end pml;

architecture Behavioral of pml is
signal byte: std_logic_vector(7 downto 0);
signal halfword: std_logic_vector(15 downto 0);
signal s : std_logic;
begin
process(wordin, addr, BorHW, ZorS, s, byte, halfword)
	begin
		if(addr="00") then
			byte <= wordin(31 downto 24);
			halfword<=wordin(31 downto 16);
		elsif(addr="01") then 
			byte <= wordin(23 downto 16);
			halfword<=wordin(31 downto 16);
		elsif(addr="10") then
			byte <= wordin(15 downto 8);
			halfword<=wordin(15 downto 0);
		else 
			byte <= wordin(7 downto 0);
			halfword<=wordin(15 downto 0);
		end if;
		if(BorHW ='1') then
			outword(15 downto 0) <= halfword;
			if (ZorS = '1') then
				s <= halfword(15);
				outword(31 downto 16) <=(others=>s);
			else
				outword(31 downto 16) <=(others=>'0');
			end if;
		else
			outword(7 downto 0) <= byte;
			if (ZorS = '1') then
				s <= byte(7);
				outword(31 downto 8) <=(others=>s);
			else
				outword(31 downto 8) <=(others=>'0');
			end if;
		end if;
	end process;

end Behavioral;
