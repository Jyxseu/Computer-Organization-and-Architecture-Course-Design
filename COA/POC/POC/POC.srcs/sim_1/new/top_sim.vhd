----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/03/14 13:58:12
-- Design Name: 
-- Module Name: top_sim - Behavioral
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

entity top_sim is
--  Port ( );
end top_sim;

architecture Behavioral of top_sim is
component Top 
      Port (
          CLK : in STD_LOGIC;    -- 输入时钟信号
          choose : in STD_LOGIC; -- 工作方式选择信号
          reset : in STD_LOGIC;  -- 重置工作方式信号
          DATA : out STD_LOGIC_VECTOR(7 downto 0)
       );
    end component;
signal CLK : STD_LOGIC := '0';
signal choose : STD_LOGIC := '0';
signal reset : STD_LOGIC := '0';
signal DATA : STD_LOGIC_VECTOR(7 downto 0):="00000000";
constant clk_period : time :=20 ns;

begin
uut : Top port map (CLK=>CLK, choose=>choose, reset=>reset,DATA=>DATA);
process    
begin        
  wait for clk_period/2;    
  CLK<='1';      
  wait for clk_period/2;    
  CLK<='0';    
end process;

process
begin
    reset<='0';
    wait for 60ns;
    reset<='1';
    wait for 40 ns;
    reset<='0';
    wait for 400ns;
end process;

process    
begin
     choose<='0';
     wait for 500 ns;  
     choose<='1';
     wait for 500 ns;  
end process;



end Behavioral;
