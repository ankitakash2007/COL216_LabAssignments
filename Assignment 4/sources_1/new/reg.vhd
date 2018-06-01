----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2018 12:28:23
-- Design Name: 
-- Module Name: reg - Behavioral
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

entity reg is
Port 
( 
    control: in std_logic;
    clk:in std_logic;
	ltdt:in std_logic_vector(31 downto 0);
	rtdt:out std_logic_vector(31 downto 0)
);
end reg;

architecture Behavioral of reg is
--signal temp:std_logic_vector(31 downto 0);
begin
process(clk)
	begin
		if falling_edge(clk) and control='1' then
				rtdt <= ltdt;
		end if;
	end process;

end Behavioral;
