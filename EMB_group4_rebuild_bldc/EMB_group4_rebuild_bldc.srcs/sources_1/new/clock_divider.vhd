----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/23/2016 01:07:54 PM
-- Design Name: 
-- Module Name: clock_divider - Behavioral
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

entity clock_divider is
    generic ( freq : integer := 500 );             --default value is 20 khz
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC;
           prescaler_in : in STD_LOGIC_VECTOR(23 downto 0));
end clock_divider;

architecture Behavioral of clock_divider is
    signal clk_temp :std_logic := '0';
    signal counter : unsigned(22 downto 0) := (others=>'0');
    --shared variable prescale : integer := 200000000/(freq*2);
begin

    divide: process(clk_in) 
    begin
        if rising_edge(clk_in) then           
            if counter = to_integer(unsigned(prescaler_in)) then -- 200 mhz/43 hz/2 in hex
                counter<=(others=>'0');
                clk_temp <= not clk_temp;
            else
                 counter<=counter+1;
            end if;
        end if;
    end process;

    clk_out <= clk_temp;
end Behavioral;