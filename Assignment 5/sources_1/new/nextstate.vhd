----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.03.2018 21:27:48
-- Design Name: 
-- Module Name: nextstate - Behavioral
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

entity nextstate is
Port 
( 
    ins: in std_logic_vector(2 downto 0);
    curstate: in std_logic_vector(3 downto 0);
    nextstate: out std_logic_vector(3 downto 0)
);
end nextstate;

architecture Behavioral of nextstate is

begin
    nextstate<="0000" when (curstate="0011" or curstate="0101" or curstate="0111" or curstate="1000") else--fetch
                "0001" when curstate="0000" else--rdAB
                "0010" when (curstate="0001" and ins(2 downto 1)="00") else --arith
                "0011" when curstate="0010" else--wrRF
                "0100" when (curstate="0001" and ins(2 downto 1)="01") else--addr
                "0101" when (curstate="0100" and ins(0)='0') else --wrM
                "0110" when (curstate="0100" and ins(0)='1') else--rdM
                "0111" when curstate="0110" else --M2RF
                "1000" when (curstate="0001" and ins(2 downto 1)="10");--brn

end Behavioral;
