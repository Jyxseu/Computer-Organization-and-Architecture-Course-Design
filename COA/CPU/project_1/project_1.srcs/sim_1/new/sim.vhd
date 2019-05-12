----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/04/20 19:38:10
-- Design Name: 
-- Module Name: sim - Behavioral
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

entity sim is
--  Port ( );
end sim;

architecture Behavioral of sim is
component TOP
     Port (
       CLK : in STD_LOGIC;
       RESET : in STD_LOGIC;
       digital: out std_logic_vector(7 downto 0);
       digital_en:out std_logic_vector (7 downto 0)       
        );
end component;
signal CLK,RESET :std_logic:='0'; 
signal digital :std_logic_vector(7 downto 0);
signal digital_en :std_logic_vector(7 downto 0);
constant clk_period : time :=20 ns;
begin

top_sim:top port map(CLK=>CLK,RESET=>RESET,digital=>digital,digital_en=>digital_en);

clk_gen:process    
begin        
  wait for clk_period/2;    
  CLK<='1';      
  wait for clk_period/2;    
  CLK<='0';    
end process;

reset1:process    
begin
     RESET<='0';
     wait for 2*clk_period;    
--     RESET<='1';  
--     wait for  150*clk_period;  
--     RESET<='0';
--          wait for 2*clk_period;    
          RESET<='1';
          wait;
end process;
end Behavioral;
