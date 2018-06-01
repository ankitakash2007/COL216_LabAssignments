----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.03.2018 18:45:38
-- Design Name: 
-- Module Name: shifter - Behavioral
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

entity shifter is
Port 
( 
    input: in std_logic_vector(31 downto 0);
    s_type: in std_logic_vector(1 downto 0);
    amount: in std_logic_vector(4 downto 0);
    cin: in std_logic_vector(3 downto 0);
    cout: out std_logic_vector(3 downto 0);
    output: out std_logic_vector(31 downto 0)
);
end shifter;

architecture Behavioral of shifter is
signal temp1,temp2,temp3,temp4: std_logic_vector(31 downto 0);
begin
process(input, s_type, amount, temp1, temp2, temp3, temp4)
begin
    cout<= cin;
    if s_type="00" then --LSL
        if amount(0)='1' then
            temp1(31 downto 1)<=input(30 downto 0);
            temp1(0)<='0';
            
        elsif amount(0)='0' then
            temp1<=input; 
        end if;
        if amount(1)='1' then
            temp2(31 downto 2)<=temp1(29 downto 0);
            temp2(1 downto 0)<="00";
        else
            temp2<=temp1;
        end if;
        if amount(2)='1' then
            temp3(31 downto 4)<=temp2(27 downto 0);
            temp3(3 downto 0)<="0000";
        else
            temp3<=temp2; 
        end if;
        if amount(3)='1' then
            temp4(31 downto 8)<=temp3(23 downto 0);
            temp4(7 downto 0)<="00000000";
        else
            temp4<=temp3;
        end if;
        if amount(4)='1' then
            output(31 downto 16)<=temp4(15 downto 0);
            output(15 downto 0)<="0000000000000000";
        else
            output<= temp4; 
        end if;
        if to_integer(unsigned(amount))=0 then
            cout<= cin;
        else
            cout(1)<= input(32-to_integer(unsigned(amount)));
        end if;
    elsif s_type="01" then --LSR
        if amount(0)='1' then
            temp1(30 downto 0)<=input(31 downto 1);
            temp1(31)<='0';
        elsif amount(0)='0' then
            temp1<=input; 
        end if;
        if amount(1)='1' then
            temp2(29 downto 0)<=temp1(31 downto 2);
            temp2(31 downto 30)<="00";
        else
            temp2<=temp1;
        end if;
        if amount(2)='1' then
            temp3(27 downto 0)<=temp2(31 downto 4);
            temp3(31 downto 28)<="0000";
        else
            temp3<=temp2; 
        end if;
        if amount(3)='1' then
            temp4(23 downto 0)<=temp3(31 downto 8);
            temp4(31 downto 24)<="00000000";
        else
            temp4<=temp3;
        end if;
        if amount(4)='1' then
            output(15 downto 0)<=temp4(31 downto 16);
            output(31 downto 16)<="0000000000000000";
        else
            output<= temp4; 
        end if;
        if to_integer(unsigned(amount))=0 then
            cout<= cin;
        else
            cout(1)<= input(to_integer(unsigned(amount))-1);
        end if;
     elsif s_type="10" then --ASR
        if amount(0)='1' then
             temp1(30 downto 0)<=input(31 downto 1);
             temp1(31)<=input(31);
         elsif amount(0)='0' then
             temp1<=input; 
         end if;
         if amount(1)='1' then
             temp2(29 downto 0)<=temp1(31 downto 2);
             if temp1(31)='0' then
                 temp2(31 downto 30)<="00";
             else
                 temp2(31 downto 30)<="11";
             end if;
         else
             temp2<=temp1;
         end if;
         if amount(2)='1' then
             temp3(27 downto 0)<=temp2(31 downto 4);
             if temp2(31)='0' then
                 temp3(31 downto 28)<="0000";
             else
                 temp3(31 downto 28)<="1111";
             end if;
         else
             temp3<=temp2; 
         end if;
         if amount(3)='1' then
             temp4(23 downto 0)<=temp3(31 downto 8);
             if temp3(31)='0' then
                 temp4(31 downto 24)<="00000000";
             else
                 temp4(31 downto 24)<="11111111";
             end if;
         else
             temp4<=temp3;
         end if;
         if amount(4)='1' then
             output(15 downto 0)<=temp4(31 downto 16);
             if temp4(31)='0' then
                 output(31 downto 16)<="0000000000000000";
             else
                 output(31 downto 16)<="1111111111111111";
             end if;
         else
             output<= temp4; 
         end if;
         if to_integer(unsigned(amount))=0 then
            cout<= cin;
        else
            cout(1)<= input(to_integer(unsigned(amount))-1);
        end if;
     else --ROR
        if amount(0)='1' then
             temp1(30 downto 0)<=input(31 downto 1);
             temp1(31)<=input(0);
         elsif amount(0)='0' then
             temp1<=input; 
         end if;
         if amount(1)='1' then
             temp2(29 downto 0)<=temp1(31 downto 2);
             temp2(31 downto 30)<=temp1(1 downto 0);
         else
             temp2<=temp1;
         end if;
         if amount(2)='1' then
             temp3(27 downto 0)<=temp2(31 downto 4);
             temp3(31 downto 28)<=temp2(3 downto 0);
         else
             temp3<=temp2; 
         end if;
         if amount(3)='1' then
             temp4(23 downto 0)<=temp3(31 downto 8);
             temp4(31 downto 24)<=temp3(7 downto 0);
         else
             temp4<=temp3;
         end if;
         if amount(4)='1' then
             output(15 downto 0)<=temp4(31 downto 16);
             output(31 downto 16)<=temp4(15 downto 0);
         else
             output<= temp4; 
         end if;
         if to_integer(unsigned(amount))=0 then
            cout<= cin;
        else
            cout(1)<= input(to_integer(unsigned(amount))-1);
        end if;
        
    END IF;
    
 end process; 
    


end Behavioral;
