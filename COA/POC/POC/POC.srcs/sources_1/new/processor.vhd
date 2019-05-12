----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/03/14 12:50:21
-- Design Name: 
-- Module Name: processor - Behavioral
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

entity processor is
Port (    
    CLK : in STD_LOGIC;    -- ����ʱ���ź�
    Dout : in STD_LOGIC_VECTOR(7 downto 0); -- �����λ���ݣ���POC��dout������
    IRQ : in STD_LOGIC; -- �����ж������źţ���POC������
    choose : in STD_LOGIC; -- ѡ������ʽ�ź�
    reset : in STD_LOGIC;  -- ���ù�����ʽ�ź�
    ADDR : out STD_LOGIC; -- ��ַ��
    Din : out STD_LOGIC_VECTOR(7 downto 0);   -- �����λ���ݣ���POC��din������
    RW : out STD_LOGIC; -- �����д�ź�
    RW_state :in STD_LOGIC-----��д״̬
 );
end processor;
     
architecture Behavioral of processor is
signal data : std_logic_vector(7 downto 0 ) := "00000000";
       
begin

process(CLK,reset,choose,IRQ)
begin 

if CLK'event and CLK = '1' then

      if  reset='1'then -- ��ʼ��
      ADDR <= '0';
      Din <= "00000000";
      RW <= '0';
else
      
if choose = '0' then -- ѡ������ʽΪ��ѯ,��ʱSR0=0        
        ADDR <= '0'; -- ѡ��SR       
        RW<='0';---��SR 
if Dout(0)='0' then          
     if Dout(7)='1' then ----���SR=1,process select BR and write BR
     if RW_state='0' then
     ADDR <= '0'; -- ѡ��SR       
      RW<='0';---��SR 
      end if;
      if RW_state='1' then
      ADDR <= '1'; -- ѡ��BRдBR,Ȼ��process write SR7<=0       
      RW<='1';
      Din<=data;
      data<=data+1;
      end if;
      
     if  RW_state='X'then 
     ADDR <= '0';      
     RW<='1';
     Din<="00000000";
     end if;
       end if;   
      end if;
  end if; 
       
  if choose='1'then -------ѡ������ʽΪ�жϣ���ʱSR0=1
         ADDR <= '0'; -- ѡ��SR       
         RW<='0';---��SR      
if IRQ='0' then-----IRQ=0,select BR and write BR
        if RW_state='0'then
            ADDR<='1';
            RW<='1';
            Din<=data;
            data<=data+1; 
         end if;
         if RW_state='1'then  
          ADDR<='0';-----SR7<=0
          RW<='1';
          Din<="00000001";
          end if;
   end if;    
 end if;  
end if;     
end if;     
end process;
end Behavioral;
