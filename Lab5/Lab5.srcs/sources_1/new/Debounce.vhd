----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2016 01:36:19 PM
-- Design Name: 
-- Module Name: Debounce - Behavioral
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

entity Debounce is
    Port ( sw_in : in STD_LOGIC;
           sw_out : out STD_LOGIC;
           clk_in : in STD_LOGIC);
end Debounce;

architecture Behavioral of Debounce is

begin

    debounce: process(clk_in,sw_in)
        variable counter: integer;
    begin
        if rising_edge(clk_in) then
            if sw_in = '1' then
                counter:= counter+1; 
            else
                counter:= 0;
            end if;
        end if;
       
       if counter > 100 then
            sw_out <= '1';
       else
            sw_out <='0';
       end if;
    end process debounce;
end Behavioral;


