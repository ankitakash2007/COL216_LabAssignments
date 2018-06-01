----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2018 18:34:14
-- Design Name: 
-- Module Name: mul - Behavioral
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

entity mul is
Port 
( 
    op1, op2: in std_logic_vector(31 downto 0);
    s: inout std_logic_vector(31 downto 0);
    flag: out std_logic_vector(3 downto 0)
);
end mul;

architecture Behavioral of mul is
signal temp:  std_logic_vector(63 downto 0);
signal c31, c32: std_logic;
begin
    process(op1, op2, temp, c31, c32, s)
    begin
        temp <= std_logic_vector(signed(op1) * signed(op2));
        s<= temp(31 downto 0);
        c31<= op1(31) xor op2(31) xor s(31);
               c32<= (op1(31) and op2(31)) or (op1(31) and c31) or (c31 and op2(31));
               if s="00000000000000000000000000000000" then
                   flag(2)<='1';--Z
               else
                   flag(2)<='0';--Z
               end if;
               flag(3)<= s(31); --N
               flag(0)<= c31 xor c32; --V
               flag(1)<= c32; --C
    end process;

end Behavioral;
