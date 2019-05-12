----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/03/14 13:24:42
-- Design Name: 
-- Module Name: printer - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity Printer is
Port (
CLK : in STD_LOGIC; -- ʱ���ź�
reset : in STD_LOGIC; -- �����ź�
TR : in STD_LOGIC; -- ���������ź�
PD : in STD_LOGIC_VECTOR(7 downto 0); -- ��ӡ����
RDY : out STD_LOGIC; -- ��ӡ��׼�����ź�
DATA: out STD_LOGIC_VECTOR(7 downto 0):="00000000"
);
end Printer;
architecture Behavioral of Printer is
signal count:integer range 0 to 4:=0;
signal trt:std_logic:='0';
signal ready:std_logic:='1';
begin
process(CLK, TR, reset)
begin

if clk'event and clk = '1' then
if reset= '1' then
RDY <= '1';
DATA<="00000000";
else

if TR = '1' and trt='0' and ready='1' then------
RDY <= '0';
DATA<=PD;------ȡPD
ready<='0';
elsif ready='0' then
count <= count + 1;
 if count=4 then---��ʱ5��ʱ�����ڣ��ȴ���ӡ���
 RDY<='1';-----RDY��1��׼��������һ���ַ�
 ready<='1';
 count<=0;
 end if;
else
RDY <= '1';
end if;
trt<=TR;
end if;
end if;
end process;
end Behavioral; 