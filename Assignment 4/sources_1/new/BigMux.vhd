----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2018 17:22:18
-- Design Name: 
-- Module Name: BigMux - Behavioral
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

entity BigMux is
Port 
( 
     in1 : in std_logic_vector(31 downto 0);
	 in2 : in std_logic_vector(31 downto 0);
	 in3 : in std_logic_vector(31 downto 0);
	 in4 : in std_logic_vector(31 downto 0);
	 output : out std_logic_vector(31 downto 0);
	 control : in std_logic_vector(1 downto 0)
);
end BigMux;

architecture Behavioral of BigMux is

begin
    process(in1, in2, control)
		begin
			if(control="00") then 
				output <= in1;
			elsif(control="01") then
				output <= in2;
			elsif(control="10") then
				output <= in3;
			else
				output <= in4;	
			end if;
		end process;

end Behavioral;
