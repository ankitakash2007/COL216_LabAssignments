----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2018 18:08:36
-- Design Name: 
-- Module Name: S2 - Behavioral
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

entity S2 is
Port 
( 
    cin: in std_logic_vector(23 downto 0);
	cout: out std_logic_vector(31 downto 0)
);
end S2;

architecture Behavioral of S2 is
signal s : std_logic;
begin
process(cin, s)
begin
    cout(25 downto 2) <= cin(23 downto 0);
		s <= cin(23);
		cout(31 downto 26) <= (others => s);
		cout(1 downto 0) <= (others => '0');
end process;


end Behavioral;
