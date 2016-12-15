----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/15/2016 01:10:52 PM
-- Design Name: 
-- Module Name: back_emf - Behavioral
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

entity back_emf is
    Port ( hall_in : in STD_LOGIC_VECTOR (2 downto 0);
           control_in : in STD_LOGIC;
           hall_out : out STD_LOGIC_VECTOR (2 downto 0);
           clk_in : in STD_LOGIC;
           direction_in : STD_LOGIC);
end back_emf;

architecture Behavioral of back_emf is
    type state is (state_1, state_2, state_3, state_4, state_5, state_6);
    signal cr_state, nx_state: state := state_1;
begin
simulate_hall: process(clk_in, hall_in)
begin
    --if rising_edge(clk_in) and 
     if control_in = '1' then
        case cr_state is
              when state_1 =>
                hall_out<="101";
                

                if direction_in = '1' then
                  nx_state <= state_2;
                elsif direction_in = '0' then
                  nx_state <= state_6;
                end if;
    
               when state_2 =>
                hall_out <= "100";
    
                if direction_in = '1' then
                  nx_state <= state_3;
                elsif direction_in = '0' then
                  nx_state <= state_1;
                end if;
    
               when state_3 =>
                hall_out <= "110";
    
                if direction_in = '1' then
                  nx_state <= state_4;
                elsif direction_in = '0' then
                  nx_state <= state_2;
                end if;
    
               when state_4 =>
                hall_out <= "010";
    
                if direction_in = '1' then
                  nx_state <= state_5;
                elsif direction_in = '0' then
                  nx_state <= state_3;
                end if;
    
               when state_5 =>
                hall_out <= "011";
    
                if direction_in = '1' then
                  nx_state <= state_6;
                elsif direction_in = '0' then
                  nx_state <= state_4;
                end if;
    
               when state_6 =>
                hall_out <= "001";
    
                if direction_in = '1' then
                  nx_state <= state_1;
                elsif direction_in = '0' then
                  nx_state <= state_5;
                end if;
    
              when others =>
                null;
        end case;
    end if;
    if control_in='0' then
        hall_out <= hall_in;
    end if;
end process;

logic: process(clk_in)
begin
    if Rising_edge(clk_in) then
        cr_state<=nx_state;
    end if;
end process;
    

end Behavioral;
