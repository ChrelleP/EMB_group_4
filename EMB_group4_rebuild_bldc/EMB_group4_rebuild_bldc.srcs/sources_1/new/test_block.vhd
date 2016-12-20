----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2016 10:14:25 AM
-- Design Name: 
-- Module Name: test_block - Behavioral
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

entity test_block is
--  Port ( );

           Port(pwm_add: out STD_LOGIC_VECTOR (7 downto 0);
           freq_out: out STD_LOGIC;
           direction_out: out STD_LOGIC;
           amplitude_in : in STD_LOGIC;
           clk_200m_in :in STD_LOGIC);
end test_block;

architecture Behavioral of test_block is
    signal freq_out_temp : STD_LOGIC :='0';
begin


end Behavioral;
