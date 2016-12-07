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
           freq_in: in STD_LOGIC_VECTOR (7 downto 0);
           enable: in STD_LOGIC (1 downto 0);
           back_emf: in STD_LOGIC;
           pwm_add: out STD_LOGIC (7 downto 0)
           switch: out STD_LOGIC
           orientation: out STD_LOGIC);
end sound_generator;

architecture Behavioral of sound_generator is

begin

state: process(enable)
begin
      case enable is
        when "00" => -- NO_SOUND
          switch <= freq_in
          pwm_add <= (others => '0')
          orientation <= '1'

        when "01" => -- SOUND_1


        when "10" => -- SOUND_2

        when "11" => -- SOUND_3

        when others =>
          null;
    end case;
end process;

end Behavioral;
