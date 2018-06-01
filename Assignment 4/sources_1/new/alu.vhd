----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2018 17:09:40
-- Design Name: 
-- Module Name: alu - Behavioral
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
Port 
(
    op1, op2: in std_logic_vector(31 downto 0);
    carry: in std_logic;
    ins: in std_logic_vector(3 downto 0);
    s: inout std_logic_vector(31 downto 0);
    flag: out std_logic_vector(3 downto 0) 
);
end alu;

architecture Behavioral of alu is
signal c31,c32: std_logic;
begin
     process(op1, op2, carry, ins, c31, c32, s)
   begin
       if ins="0000" then
           s<= op1 and op2;
       elsif ins="0001" then
           s<= op1 xor op2;
       elsif ins="0010" then
           s<= op1+ (not op2)+ 1;
       elsif ins="0011" then
           s<= (not op1) + op2 + 1;
       elsif ins="0100" then
           s<= op1 + op2;
       elsif ins="0101" then
           s<= op1 + op2 + carry;
       elsif ins="0110" then
           s<= op1 + (not op2) + carry;
       elsif ins="0111" then
           s<= (not op1) + op2 + carry;
       elsif ins="1000" then
           s<= op1 and op2;
       elsif ins="1001" then
           s<= op1 xor op2;
       elsif ins="1010" then
           s<= op1 + (not op2) + 1;
       elsif ins="1011" then
           s<= op1 + op2;
       elsif ins="1100" then
           s<= op1 or op2;
       elsif ins="1101" then
           s<= op2;
       elsif ins="1110" then
           s<= op1 and (not op2);
       elsif ins="1111" then
           s<= not op2;
       
           
           
       end if;
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
