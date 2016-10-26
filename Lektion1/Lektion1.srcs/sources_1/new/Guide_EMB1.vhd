----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2016 01:02:39 PM
-- Design Name: 
-- Module Name: Guide_EMB1 - Behavioral
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

entity Guide_EMB1 is
    Port ( clk_200M_In : in STD_LOGIC;
           sw_in : in STD_LOGIC;
           led_out : out STD_LOGIC);
end Guide_EMB1;

architecture Behavioral of Guide_EMB1 is

begin

sync_proc: process(clk_200M_in, sw_in)
begin
    if rising_edge(clk_200M_in) then
        led_out<=sw_in;
    end if;
end process sync_proc;

end Behavioral;
