----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2016 12:37:30 PM
-- Design Name: 
-- Module Name: pwm_generator - Behavioral
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
USE ieee.numeric_std.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm_generator is
    Port ( clk_200m_in : in STD_LOGIC;
           pwm_duty_in : in STD_LOGIC_VECTOR (7 downto 0);
           reset_in : in STD_LOGIC;
           pwm_out : out STD_LOGIC);
end pwm_generator;

architecture Behavioral of pwm_generator is
    
begin

    pwm_generator: process (clk_200m_in)
       variable state : std_logic := '0';
       variable counter : integer := 0;
    begin
        if rising_edge(clk_200m_in) then
            if state = '1' then
                counter := counter + 1;
                
                if counter >= 255 then
                    state := '0';
                end if;
            end if;
            
            if state = '0' then
                counter := counter -1;
                
                if counter <= 0 then
                    state := '1';
                end if;
            end if;
            
            if counter >= to_integer(unsigned(pwm_duty_in)) then
                pwm_out <= '1';
            else 
                pwm_out <= '0';
            end if;
            
        end if;
        
        if reset_in = '1' then
            counter:=0;
        end if;
    end process;
end Behavioral;
