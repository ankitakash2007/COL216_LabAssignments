----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.03.2018 21:45:55
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pms is
Port 
( 
    wordin : in std_logic_vector(31 downto 0);
	BorHW : in std_logic;
	outword : out std_logic_vector(31 downto 0)
);
end pms;

architecture Behavioral of pms is
signal byte: std_logic_vector(7 downto 0);
signal halfword: std_logic_vector(15 downto 0);
begin
    process(wordin, halfword, BorHW, byte)
	begin
		byte <= wordin(7 downto 0);
		halfword <= wordin(15 downto 0);
		if(BorHW ='1') then
			outword(15 downto 0) <= halfword;
			outword(31 downto 16)<= halfword;
		else
			outword(7 downto 0) <= byte;
			outword(15 downto 8) <=byte;
			outword(23 downto 16)<=byte;
			outword(31 downto 24)<=byte;
		end if;
	end process;

end Behavioral;
