
----------------------------------------------------------------------------------
--MAR��Memory Address Register��
--?MAR�����Ҫ�Ӵ洢���ж�ȡ��Ҫд��洢����
--�洢����ַ��
--?�˴�������������ΪCPU���ڴ��ж�����д����
--��ΪCPU������д���ڴ档
--?���γ̵�����У�MARӵ��8���أ����Դ�ȡ256
--����ַ��

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
