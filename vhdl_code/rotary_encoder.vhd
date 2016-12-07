----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2016 01:42:38 PM
-- Design Name: 
-- Module Name: rotary_encoder - Behavioral
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
use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rotary_encoder is
    Port ( in_a : in STD_LOGIC;
           in_b : in STD_LOGIC;
           clk_200M : in STD_LOGIC;
           outputz : out STD_LOGIC_VECTOR (7 downto 0));
end rotary_encoder;

architecture Behavioral of rotary_encoder is
    signal pr_state, nxt_state: std_logic_vector (1 downto 0) := "11";
begin    
    comb_logic: process(clk_200M, pr_state, nxt_state) 
    begin
        case pr_state is
            when "00" => 
                    if in_a = '1' then
                        nxt_state <= "10";
                    elsif in_b = '1' then
                        nxt_state <= "01";
                    end if;
            when "01" =>
                   if in_a = '1' then
                         nxt_state <= "11";
                     elsif in_b = '0' then
                         nxt_state <= "00";
                     end if;                             
            when "11" => 
                   if in_a = '0' then
                        nxt_state <= "01";
                   elsif in_b = '0' then
                       nxt_state <= "10";
                   end if;
            when "10" =>
                   if in_a = '0' then
                      nxt_state <= "00";
                   elsif in_b = '1' then
                     nxt_state <= "11";
                   end if; 
                   
            when others => 
                    nxt_state <= nxt_state;
           end case;
    end process;
    
    output_logic: process(clk_200M)
        variable counter :integer := 0;
    begin
        if rising_edge(clk_200M) then
         -- A
            if pr_state = "11" and nxt_state = "01" then
                counter := counter -1;
            end if;
            
            if pr_state = "00" and nxt_state = "10" then
                counter := counter -1;
            end if;
            
            if pr_state = "01" and nxt_state = "11" then
                counter := counter +1;
            end if;
            
            if pr_state = "10" and nxt_state = "00" then
                counter := counter +1;
            end if;
 
 
            -- B
            --if pr_state = "11" and nxt_state = "10" then
            --    counter := counter +1;
            --end if;
            
            --if pr_state = "00" and nxt_state = "01" then
            --    counter := counter +1;
            --end if;
            
            --if pr_state = "10" and nxt_state = "11" then
            --    counter := counter -1;
            --end if;
            
            --if pr_state = "01" and nxt_state = "00" then
            --    counter := counter -1;
            --end if;
            
            
            
            if counter > 254 then
                counter := 255;
            end if;
            
            if counter <= 1 then
                counter := 0;
            end if;
            outputz<= std_logic_vector(to_unsigned(counter, outputz'length));    
        end if;

    end process;
    
    
    output_state: process(clk_200M)
    begin
        if rising_edge(clk_200M) then
                pr_state <= nxt_state;
         end if;
    end process;
end Behavioral;
