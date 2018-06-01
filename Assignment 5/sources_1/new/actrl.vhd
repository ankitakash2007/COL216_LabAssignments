----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.03.2018 22:10:24
-- Design Name: 
-- Module Name: actrl - Behavioral
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

entity actrl is
Port 
( 
    ins: in std_logic_vector(6 downto 0);
	op: out std_logic_vector(3 downto 0)
);
end actrl;

architecture Behavioral of actrl is
signal temp: std_logic_vector(3 downto 0);
begin
temp <= ins(3 downto 0);
process(ins, temp)

begin
	if(ins(6) ='1') then ---b/bl
		op <= "0100";
	elsif(ins(5) ='1') then ---ldr/str
		if(ins(2) ='1') then 
			op<="0100";
		else
			op <="0010";
		end if;
	elsif(ins(4) ='1') then
		op <= temp;	---dp ins
	else 
		if(ins(0)='1') then
			op <="0100"; ---mal
		else 
			op <= "1101"; ---mul
	   end if;
	end if;
end process;


end Behavioral;
