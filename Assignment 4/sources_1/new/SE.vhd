----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2018 18:17:58
-- Design Name: 
-- Module Name: SE - Behavioral
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

entity SE is
Port 
( 
    cin: in std_logic_vector(11 downto 0);
	cout: out std_logic_vector(31 downto 0)
);
end SE;

architecture Behavioral of SE is
signal s : std_logic;
begin
process(cin, s)
begin
    cout(11 downto 0) <= cin(11 downto 0);
		s <= cin(11);
		cout(31 downto 12) <= (others => s);
end process;


end Behavioral;
