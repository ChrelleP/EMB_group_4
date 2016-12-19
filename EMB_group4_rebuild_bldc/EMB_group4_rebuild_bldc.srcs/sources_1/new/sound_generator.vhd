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

entity sound_generator is
    Port ( clk_200m_in : in STD_LOGIC;
           freq_in: in STD_LOGIC;
           mode: in STD_LOGIC_VECTOR (2 downto 0);
           --back_emf: in STD_LOGIC;
           pwm_add: out STD_LOGIC_VECTOR (7 downto 0);
           freq_out: out STD_LOGIC;
           direction_out: out STD_LOGIC;
           amplitude_in: in STD_LOGIC_VECTOR(8 downto 0);
           back_emf_enable: out STD_LOGIC);
end sound_generator;

architecture Behavioral of sound_generator is
    signal direction_temp: STD_LOGIC := '0';
    signal freq_out_temp : STD_LOGIC :='0';
    
    signal last: STD_LOGIC := '0';
begin

-- Mode 0 = "000" = feedforward, direction1
-- Mode 1 = "001" = feeforward, direction2
-- Mode 2 = "010" = music method 1
-- Mode 3 = "011" = music method 3
-- Mode 4 = "100" = Backemf, direction1
-- Mode 5 = "101" = Backemf, direction2
-- Mode 6 = "110" = Music method 2

freq_out <= freq_in when mode = "000" or mode = "001" or mode = "010" else
            freq_out_temp when mode = "011"
            else '0';
            
direction_out <= '1' when mode = "000" or mode = "100" else
                 '0' when mode = "001" or mode = "101" else
                  direction_temp when mode = "010" else
                  amplitude_in(8) when mode = "011" 
                  else '0';

back_emf_enable <= mode(2);

pwm_add <= amplitude_in(7 downto 0) when mode = "110" or mode = "011"
           else (others=>'0');

mode1:process(freq_in)
begin
    if rising_edge(freq_in) then
        direction_temp <= not direction_temp;
    end if;
end process;


mode12:process(amplitude_in(8),clk_200m_in)
begin
    if rising_edge(clk_200m_in) then
        freq_out_temp<='0';
        if last = '0' and amplitude_in(8) = '1' then -- rising
            freq_out_temp<='1';
        elsif last = '1' and amplitude_in(8) = '0' then -- falling
            freq_out_temp<='1';
        end if;
    
        last <= amplitude_in(8);  
    end if;
    
end process;


end Behavioral;
