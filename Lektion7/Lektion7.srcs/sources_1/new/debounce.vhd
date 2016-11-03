----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2016 04:38:51 PM
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce is
    Port ( inputz : in STD_LOGIC;
           outz : out STD_LOGIC;
           clk_in : in STD_LOGIC);
end debounce;

architecture Behavioral of debounce is
begin

--**Insert the following after the 'begin' keyword**
    process(clk_in)
        variable counter: integer:=0;
        variable counter_low : integer :=0;
    begin
       if rising_edge(clk_in) then
          if inputz = '1' then
                counter:= counter +1;
          else
                counter:=0;
          end if;
          
          if counter > 1000 then -- Change if necessary
            outz <= '1';
           else
            outz <= '0';
          end if;

         if inputz = '0' then
               counter_low:= counter_low +1;
         else
               counter_low:=0;
         end if;
         
         if counter_low > 1000 then -- Change if necessary
           outz <= '0';
          else
           outz <= '1';
         end if;
      end if;
    end process;
end Behavioral;
