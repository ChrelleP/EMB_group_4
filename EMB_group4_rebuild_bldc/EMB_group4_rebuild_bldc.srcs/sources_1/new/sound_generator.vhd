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
           mode: in STD_LOGIC_VECTOR (1 downto 0);
           --back_emf: in STD_LOGIC;
           --pwm_add: out STD_LOGIC_VECTOR (7 downto 0);
           freq_out: out STD_LOGIC;
           direction: out STD_LOGIC);
end sound_generator;

architecture Behavioral of sound_generator is
    signal direction_temp: STD_LOGIC := '0';
begin

state: process(mode)
begin
      case mode is
        when "00" => -- NO_SOUND
          freq_out <= freq_in;
          --pwm_add <= (others => '0');
          direction <= '1';

        when "01" => -- NO_SOUND change direction
          freq_out <= freq_in;
          --pwm_add <= (others => '0');
          direction <= '0';
        when "10" => -- SOUND_2
          freq_out <= freq_in;
          direction<=direction_temp;
        when "11" => -- SOUND_3
          null;
        when others =>
          null;
    end case;
end process;


mode1:process(freq_in)
begin
    if rising_edge(freq_in) then
        direction_temp <= not direction_temp;
    end if;
end process;



end Behavioral;
