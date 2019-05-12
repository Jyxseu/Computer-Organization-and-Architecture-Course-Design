
----------------------------------------------------------------------------------
--MAR（Memory Address Register）
--?MAR存放着要从存储器中读取或要写入存储器的
--存储器地址。
--?此处，“读”定义为CPU从内存中读。“写”定
--义为CPU把数据写入内存。
--?本课程的设计中，MAR拥有8比特，可以存取256
--个地址。

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAR is
Port (
CLK:in std_logic;
RESET:in std_logic;
control_signal:in std_logic_vector(31 downto 0);
from_MBR:in std_logic_vector(15 downto 0);
from_PC:in std_logic_vector(7 downto 0);
MAR_out:out std_logic_vector(7 downto 0)
 );
end MAR;

architecture Behavioral of MAR is
begin
process (CLK)
begin
    if CLK'event and CLK='1' then
        if RESET='1' then
            if control_signal(5)='1' then
                MAR_out<=from_MBR(7 downto 0);
                end if;
            if control_signal(10)='1' then
                MAR_out<=from_PC;
               end if;
            else
                MAR_out<="00000000";
      end if;
    end if;
end process;

end Behavioral;
