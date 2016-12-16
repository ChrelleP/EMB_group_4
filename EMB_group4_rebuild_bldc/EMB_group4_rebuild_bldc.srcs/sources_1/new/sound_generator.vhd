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
           --pwm_add: out STD_LOGIC_VECTOR (7 downto 0);
           freq_out: out STD_LOGIC;
           direction: out STD_LOGIC;
           control_out: out STD_LOGIC);
end sound_generator;

architecture Behavioral of sound_generator is
    signal direction_temp: STD_LOGIC := '0';
begin

state: process(mode)
begin
      case mode is
        when "000" => -- NO_SOUND
          freq_out <= freq_in;
          --pwm_add <= (others => '0');
          direction <= '1';
          control_out <= '1';

        when "001" => -- NO_SOUND change direction
          freq_out <= freq_in;
          --pwm_add <= (others => '0');
          direction <= '0';
          control_out <= '1';

        when "010" => -- SOUND_1
          freq_out <= freq_in;
          direction<=direction_temp;
          control_out <= '1';

        when "011" => --  Back EMF
          control_out <= '0';

        when "100" => -- BACK EMF
          control_out <= '1';


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
