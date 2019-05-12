----------------------------------------------------------------------------------
--PC（Program Counter）
--?PC寄存器用来跟踪程序中将要使用的指令。
--?本课程中，PC有8比特

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity PC is
Port (
CLK:in std_logic;
control_signal:in std_logic_vector(31 downto 0);
from_MBR:in std_logic_vector(15 downto 0);
RESET:in std_logic;
to_MAR:buffer std_logic_vector(7 downto 0)
 );
end PC;

architecture Behavioral of PC is

begin
process(CLK)
variable temp:std_logic_vector(7 downto 0):="00000000";
begin
if CLK'event and CLK='1'then
   if RESET='1' then
       if control_signal(15)='1'then
           temp:="00000000"; --reset
       elsif control_signal(14)='1'then
           temp:=from_MBR(7 downto 0);
       elsif control_signal(6)='1'then
           temp:=temp+1; --increment
       end if;
       to_MAR<=temp;
   else to_MAR<="00000000";
   end if;
end if;
end process;

end Behavioral;
