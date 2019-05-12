----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/03/28 13:47:59
-- Design Name: 
-- Module Name: Display - Behavioral
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

entity Display is
Port ( 
CLK:in std_logic;
digital:in std_logic_vector(15 downto 0);--需要显示的数
en:out STD_LOGIC_VECTOR(3 DOWNTO 0);--根据ctrl信号选择4位中的一位
segcode:out STD_LOGIC_VECTOR(7 DOWNTO 0)--数码管编码
);
end Display;

architecture Behavioral of Display is

begin


end Behavioral;
