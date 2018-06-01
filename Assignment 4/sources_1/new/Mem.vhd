----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2018 17:45:23
-- Design Name: 
-- Module Name: Mem - Behavioral
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

entity Mem is
Port 
( 
    clk: in std_logic;
	 ad: in std_logic_vector(31 downto 0);
	 Wen: in std_logic;
	 Ren: in std_logic;
	 wdt: in std_logic_vector(31 downto 0);
	 rdt: out std_logic_vector(31 downto 0)
);
end Mem;

architecture Behavioral of Mem is
type mem is array(511 downto 0) of std_logic_vector(31 downto 0);
signal Data_Memory: mem := (others =>(others=> '0'));
begin
    process(ad, Wen, wdt, Ren, clk)
	begin
	   if(Ren ='1') then 	
                rdt<=Data_Memory(to_integer(unsigned(ad)));
           end if;
		if(Wen ='1' and falling_edge(clk)) then 
			Data_Memory(to_integer(unsigned(ad)))<= wdt;
			end if;
		
	end process;


end Behavioral;
