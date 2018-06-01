----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2018 02:34:32 PM
-- Design Name: 
-- Module Name: flagcku - Behavioral
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

entity bctrl is
Port 
( 
    ins : in std_logic_vector(3 downto 0);
	flags : in std_logic_vector(3 downto 0);
	s : out std_logic
);
end bctrl;

architecture Behavioral of bctrl is

begin
    s <= flags(2) when ins = "0000" else
	(not flags(2)) when ins = "0001" else
	(flags(1)) when ins ="0010" else
	(not flags(1)) when ins ="0011" else
	(flags(3)) when ins ="0100" else
	(not flags(3)) when ins ="0101" else
	(flags(0)) when ins ="0110" else
	(not flags(0)) when ins ="0111" else
	(flags(1) and flags(2)) when ins ="1000" else
	not(flags(1) and flags(2)) when ins ="1001" else
	(flags(3) xor flags(0)) when ins ="1010" else
	not(flags(3) xor flags(0)) when ins ="1011" else
	((flags(3) xor flags(0)) and not(flags(2))) when ins ="1100" else
	not((flags(3) xor flags(0)) and not(flags(2))) when ins ="1101" else
	('1') when ins ="1110";

end Behavioral;