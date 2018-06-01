----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2018 12:43:16
-- Design Name: 
-- Module Name: RF - Behavioral
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

entity RF is
Port 
( 
    clk:in std_logic;
	wen:in std_logic;
	rd1:in std_logic_vector(3 downto 0);
	rd2:in std_logic_vector(3 downto 0);
	wad:in std_logic_vector(3 downto 0);
	wdt:in std_logic_vector(31 downto 0);
	out1:out std_logic_vector(31 downto 0);
	out2:out std_logic_vector(31 downto 0)
);
end RF;

architecture Behavioral of RF is
type mem is array(15 downto 0) of std_logic_vector(31 downto 0);
signal registers: mem:=(others=>(others=>'0'));
begin
    process(clk, wen, wad, rd1, rd2, wdt, wen)
	begin
		if ((wen='1') and falling_edge(clk)) then
			registers(to_integer(unsigned(wad))) <=wdt;
			end if;
		out1<=registers(to_integer(unsigned(rd1)));
		out2<=registers(to_integer(unsigned(rd2)));
	
	end process;

end Behavioral;
