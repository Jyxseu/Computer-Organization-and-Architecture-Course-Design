----------------------------------------------------------------------------------
--MBR��Memory Buffer Register��
--MBR�洢�Ž�Ҫ�������ڴ�������һ�δ��ڴ�
--�ж���������ֵ��
--���γ̵�����У�MBR��16���ء�

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
entity MBR is
Port ( 
CLK:in std_logic;
RESET:in std_logic;
from_Memory:in std_logic_vector(15 downto 0);
MBR_out:buffer std_logic_vector(15 downto 0);
from_ACC:in std_logic_vector(15 downto 0);
control_signal:in std_logic_vector(31 downto 0)

);
end MBR;

architecture Behavioral of MBR is
begin
process(CLK)
begin
if CLK'event and CLK='1' then
   if RESET='1' then
       if control_signal(3)='1'then
          MBR_OUT<=FROM_MEMORY; -- MBR<=MEMORY
       elsif control_signal(12)='1'then
          MBR_OUT<=FROM_ACC; -- MBR<=ACC
       end if;
   else 
       MBR_OUT<="0000000000000000";
   end if;
end if;
end process;

end Behavioral;
