----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2018 17:30:44
-- Design Name: 
-- Module Name: flags - Behavioral
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

entity flags is
Port 
( 
    flagin: in std_logic_vector(3 downto 0);
	 flagout: out std_logic_vector(3 downto 0);
	 fset: in std_logic
);
end flags;

architecture Behavioral of flags is
signal flag: std_logic_vector(3 downto 0) := (others => '0');
begin
process(flagin, fset)
	begin 
		if(fset='1') then 
			flag <= flagin;
			flagout <= flagin;
		else 
			flagout <= flag;
		end if;
	end process;


end Behavioral;
