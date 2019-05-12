----------------------------------------------------------------------------------
--BR（Buffer Register）
--?BR作为ALU的一个输入，存放着ALU的一个操作
--数。本课程中，BR有16比特。

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity BR is
Port (
CLK:in std_logic;
RESET:in std_logic;
from_MBR:in std_logic_vector(15 downto 0);
to_ALU:out std_logic_vector(15 downto 0);
control_signal:in std_logic_vector(31 downto 0)
 );
end BR;
architecture Behavioral of BR is
begin
process(CLK)
begin
if CLK'event and CLK='1' then
    if RESET='1' then 
        if control_signal(7)='1'then
              to_ALU<=from_MBR; -- BR<=MBR
        else to_ALU<="0000000000000000";
        end if;
    end if;
end if;
end process;
end Behavioral;
