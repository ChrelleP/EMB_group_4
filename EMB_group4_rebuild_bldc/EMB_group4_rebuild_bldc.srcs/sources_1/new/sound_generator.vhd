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

--state: process(mode,freq_out_temp)
--begin
--      case mode is
--        when "000" => -- NO_SOUND mode 1
--          freq_out <= freq_in;
--          direction_out <= '1';
--          back_emf_enable <= '0';
--          pwm_add<= (others=>'0');

--        when "001" => -- NO_SOUND change direction mode 2
--          freq_out <= freq_in;
--          direction_out <= '0';
--          back_emf_enable <= '0';
--          pwm_add<= (others=>'0');

--        when "010" => -- mode 3
--          freq_out <= freq_in;
--          direction_out<=direction_temp;
--          back_emf_enable <= '0';
--          pwm_add<= (others=>'0');

--        when "011" => --  mode 4
--          back_emf_enable <= '0';
--          pwm_add <= (others => '0');
--          direction_out <= amplitude_in(8);
--          freq_out<=   freq_out_temp;
          
--        when "111" => --  sound_2
--          back_emf_enable <= '1';
--          pwm_add <=amplitude_in(7 downto 0);


--        when "100" => -- BACK EMF
--          back_emf_enable <= '1';
--          pwm_add<= (others=>'0');

--        when others =>
--          null; 
--       end case;
--end process;

--direction_out <= '1' when ---- else '0' when ...

freq_out <= freq_in when mode = "000" or mode = "001" or mode = "010" else
            freq_out_temp when mode = "011"
            else '0';
            
direction_out <= '1' when mode = "000" else
                 '0' when mode = "001" else
                  direction_temp when mode = "010" else
                  amplitude_in(8) when mode = "011" 
                  else '0';

back_emf_enable <= mode(2);

pwm_add <= amplitude_in(7 downto 0) when mode = "111"
           else (others=>'0');

mode1:process(freq_in)
begin
    if rising_edge(freq_in) then
        direction_temp <= not direction_temp;
    end if;
end process;


mode12:process(amplitude_in(8),clk_200m_in)
begin
    --if rising_edge(amplitude_in(8)) then
    --    freq_out_temp <= not freq_out_temp;
    --end if;
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


--mode3: process(amplitude_in,clk_200m_in) 
--    VARIABLE   counter : INTEGER RANGE 0 TO 2 := 0;
--begin
--    if rising_edge(amplitude_in(8)) then
--        freq_out_temp <= '1';
--        counter:=0;
--    end if;
    
--    if falling_edge(amplitude_in(8)) then
--        freq_out_temp <='1';
--        counter:=0;
--    end if;
    
--    if rising_edge(clk_200m_in) and freq_out_temp='1' then
--        if counter = 2 then
--            freq_out_temp <= '0';
--         end if;
--         counter:=counter+1;
--    end if;
--end process;

end Behavioral;
