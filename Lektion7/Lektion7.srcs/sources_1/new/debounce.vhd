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
    signal Q1, Q2, Q3 : std_logic;
begin

--**Insert the following after the 'begin' keyword**
process(clk_in)
begin
   if rising_edge(clk_in) then
         Q1 <= inputz;
         Q2 <= Q1;
         Q3 <= Q2;
      end if;
end process;

outz <= Q1 and Q2;

end Behavioral;
