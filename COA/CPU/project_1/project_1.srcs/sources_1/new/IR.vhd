----------------------------------------------------------------------------------
--IR（Instruction Register）
--?IR存放指令的OPCODE（操作码）部分。
--?本课程中，IR有8比特。

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity IR is
Port ( 
CLK:in std_logic;
from_MBR:in std_logic_vector(15 downto 0);
control_signal:in std_logic_vector(31 downto 0);
to_CU:out std_logic_vector(7 downto 0);
RESET:in std_logic
);
end IR;
architecture Behavioral of IR is
begin
process(CLK)
begin
if CLK'event and CLK='1' then
    if RESET='1' then
       if control_signal(4)='1'then
          to_CU<=from_MBR(15 downto 8);
       end if;
    else to_CU<="00000000";
    end if;
end if;
end process;

end Behavioral;
