----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2016 01:36:19 PM
-- Design Name: 
-- Module Name: ClockInverter - Behavioral
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

entity ClockInverter is
    Port ( clk_in : in STD_LOGIC;
           sw_in : in STD_LOGIC;
           clk_inv_out : out STD_LOGIC);
end ClockInverter;

architecture Behavioral of ClockInverter is
begin
    clk_inv_out <= not (clk_in and sw_in);
end Behavioral;
