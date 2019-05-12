----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/03/14 12:40:43
-- Design Name: 
-- Module Name: POC - Behavioral
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

entity POC is
Port ( 

ADDR: in STD_LOGIC;
Dout: out STD_LOGIC_VECTOR(7 downto 0);----8  output data to process
Din: in STD_LOGIC_VECTOR(7 downto 0);-----8 input data
RW:in STD_LOGIC;-----input RW signal
reset : in STD_LOGIC;  -- reset signal
CLK:in STD_LOGIC;-----input clk
IRQ:out STD_LOGIC;------output interrupt request to processor
RDY:in STD_LOGIC;-----ready signal from printer moduel 
TR:out STD_LOGIC;----input request signal from poc to printer
PD:out STD_LOGIC_VECTOR(7 downto 0);-----print data 
choose : in STD_LOGIC; -- ѡ������ʽ�ź�
RW_state :out STD_LOGIC:='0'-----��д״̬
);
end POC;

architecture Behavioral of POC is
signal SR : STD_LOGIC_VECTOR(7 downto 0) := "00000000";  -- Status Register
signal BR : STD_LOGIC_VECTOR(7 downto 0) := "00000000";  -- Buffer Register
type state_type is (s1,s2,s3,s4);
signal state:state_type;
signal rdyt:std_logic:='0';
begin
process(CLK, reset,choose)
    begin
        
         if choose='0' then              
         SR(0)<='0';                     
         else                            
         SR(0)<='1';                     
         end if;                         
  
if CLK'event and CLK = '1' then  

       if  reset='1' then------�����ź�
       SR <= "00000000";  ----����
       BR <= "00000000"; ----����
       Dout <= "00000000"; ----����
       IRQ <= '1';---���ж�
       TR <= '0';----�޴�������
       PD <= "00000000";----��ӡ��������      
       state<=s1;
       RW_state<='0';
       else
       
if SR(0)='0' then------��ѯģʽ
case state is
when s1=>       
SR(7)<='1';
if ADDR='0'and RW='0' then-----��SR
	Dout<=SR;
    RW_state<='1';
end if;
if ADDR='1'and RW='1' then----дBR
	BR<=Din;
	RW_state<='X';
end if;                
if ADDR='0'and RW='1' then----дSR
	SR<=Din;
	state<=S2;
	RW_state<='0';
end if;
when s2=>
if SR(7)='0' then ----poc detect SR7=0,state handshaking
if RDY='1' then----printer is ready to receive a character
PD<=BR;-----POC hold a character at PD;
TR<='1';----generate a TD pulse
state<=s3;
end if;
end if;
when s3=>
TR<='0';   
if RDY='1' then----��ӡ���
SR(7)<='1';
state<=s1;------ processor  can continue to fetch and execute instructions 
end if;     
when s4=>NULL;
end case;

else --------�ж�ģʽ
case state is
when s1=>
SR(7)<='1';
if SR(7)='1' then
IRQ<='0';
state<=s2;
end if;
when s2=>
if RW='1' and ADDR='1'then -----дBR
BR<=Din;
RW_state<='1';
end if;
if RW='1' and ADDR='0' then ----дSR
SR<=Din;
RW_state<='0';
IRQ<='1';
state<=s3;
end if;
when s3=>-------handshaking
if SR(7)='0' then ----poc detect SR7=0,state handshaking     
if RDY='1' then----printer is ready to receive a character   
PD<=BR;-----POC hold a character at PD;                      
TR<='1';----generate a TD pulse                              
state<=s4;                                                   
end if; 
end if;   
when s4=>
 TR<='0';                                                                                                                        
 if rdyt='0' and RDY='1'then----��ӡ���                                                         
 SR(7)<='1';  
 IRQ<='0';                                                  
 state<=s1;------ processor  can continue to fetch and execute instructions     
end if;
end case;
end if;
rdyt<=RDY;
end if;
end if;
end process;
end Behavioral;

