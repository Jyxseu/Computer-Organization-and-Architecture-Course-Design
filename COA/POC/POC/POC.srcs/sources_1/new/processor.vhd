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
    CLK : in STD_LOGIC;    -- 输入时钟信号
    Dout : in STD_LOGIC_VECTOR(7 downto 0); -- 输入八位数据（由POC的dout而来）
    IRQ : in STD_LOGIC; -- 输入中断请求信号（由POC而来）
    choose : in STD_LOGIC; -- 选择工作方式信号
    reset : in STD_LOGIC;  -- 重置工作方式信号
    ADDR : out STD_LOGIC; -- 地址线
    Din : out STD_LOGIC_VECTOR(7 downto 0);   -- 输出八位数据（由POC的din而来）
    RW : out STD_LOGIC; -- 输出读写信号
    RW_state :in STD_LOGIC-----读写状态
 );
end processor;
     
architecture Behavioral of processor is
signal data : std_logic_vector(7 downto 0 ) := "00000000";
       
begin

process(CLK,reset,choose,IRQ)
begin 

if CLK'event and CLK = '1' then

      if  reset='1'then -- 初始化
      ADDR <= '0';
      Din <= "00000000";
      RW <= '0';
else
      
if choose = '0' then -- 选择工作方式为查询,此时SR0=0        
        ADDR <= '0'; -- 选择SR       
        RW<='0';---读SR 
if Dout(0)='0' then          
     if Dout(7)='1' then ----如果SR=1,process select BR and write BR
     if RW_state='0' then
     ADDR <= '0'; -- 选择SR       
      RW<='0';---读SR 
      end if;
      if RW_state='1' then
      ADDR <= '1'; -- 选择BR写BR,然后process write SR7<=0       
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
       
  if choose='1'then -------选择工作方式为中断，此时SR0=1
         ADDR <= '0'; -- 选择SR       
         RW<='0';---读SR      
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
