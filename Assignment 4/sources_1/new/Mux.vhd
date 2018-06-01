----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2018 18:05:32
-- Design Name: 
-- Module Name: Mux - Behavioral
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

entity Mux is
Port 
( 
    in1 : in std_logic_vector(31 downto 0);
	 in2 : in std_logic_vector(31 downto 0);
	 output : out std_logic_vector(31 downto 0);
	 control : in std_logic
);
end Mux;

architecture Behavioral of Mux is

begin
    process(in1, in2, control)
		begin
			if(control='0') then 
				output <= in1;
			else
				output <= in2;
			end if;
		end process;


end Behavioral;
