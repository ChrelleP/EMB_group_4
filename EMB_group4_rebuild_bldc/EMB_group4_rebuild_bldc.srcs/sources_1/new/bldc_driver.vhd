----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11/16/2016 04:28:51 PM
-- Design Name:
-- Module Name: bldc_driver - Behavioral
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

entity bldc_driver is
    Port ( Aout     : out STD_LOGIC;
           Aout_en  : out STD_LOGIC;
           Bout     : out STD_LOGIC;
           Bout_en  : out STD_LOGIC;
           Cout     : out STD_LOGIC;
           Cout_en  : out STD_LOGIC;
           clk_in   : in STD_LOGIC;
           pwm_in   : in STD_LOGIC;
           direction: in STD_LOGIC);
end bldc_driver;

architecture Behavioral of bldc_driver is
    type state is (state_1, state_2, state_3, state_4, state_5, state_6);
    signal cr_state, nx_state: state := state_1;
begin

fsm: process(cr_state, pwm_in)
begin
        case cr_state is
          when state_1 =>
            Aout<='1'  and pwm_in;
            Aout_en<='1';

            Bout<='0';
            Bout_en<='1';

            Cout<='0';
            Cout_en<='0';

            if direction = '1' then
              nx_state <= state_2;
            elsif direction = '0' then
              nx_state <= state_6;
            end if;

           when state_2 =>
            Aout<='1' and pwm_in;
            Aout_en <='1';

            Bout<='0';
            Bout_en <='0';

            Cout<='0';
            Cout_en<='1';

            if direction = '1' then
              nx_state <= state_3;
            elsif direction = '0' then
              nx_state <= state_1;
            end if;

           when state_3 =>
            Aout<='0';
            Aout_en <='0';

            Bout<='1'  and pwm_in;
            Bout_en <='1';

            Cout<='0';
            Cout_en<='1';

            if direction = '1' then
              nx_state <= state_4;
            elsif direction = '0' then
              nx_state <= state_2;
            end if;

           when state_4 =>

            Aout<='0';
            Aout_en <='1';

            Bout<='1'  and pwm_in;
            Bout_en <='1';

            Cout<='0';
            Cout_en<='0';

            if direction = '1' then
              nx_state <= state_5;
            elsif direction = '0' then
              nx_state <= state_3;
            end if;

           when state_5 =>
            Aout<='0';
            Aout_en <='1';

            Bout<='0';
            Bout_en <='0';

            Cout<='1'  and pwm_in;
            Cout_en<='1';

            if direction = '1' then
              nx_state <= state_6;
            elsif direction = '0' then
              nx_state <= state_4;
            end if;

           when state_6 =>

            Aout<='0';
            Aout_en <='0';

            Bout<='0';
            Bout_en <='1';

            Cout<='1'  and pwm_in;
            Cout_en<='1';

            if direction = '1' then
              nx_state <= state_1;
            elsif direction = '0' then
              nx_state <= state_5;
            end if;

          when others =>
            null;
      end case;
end process;

logic: process(clk_in)
begin
    if Rising_edge(clk_in) then
        cr_state<=nx_state;
    end if;
end process;

end Behavioral;
