----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/03/14 13:27:16
-- Design Name: 
-- Module Name: TOP - Behavioral
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


entity TOP is
Port (
    CLK : in STD_LOGIC;    -- ����ʱ���ź�
    choose : in STD_LOGIC; -- ������ʽѡ���ź�
    reset : in STD_LOGIC;  -- ���ù�����ʽ�ź�
    DATA : out STD_LOGIC_VECTOR(7 downto 0)
 );
end TOP;

architecture Behavioral of TOP is

component processor is    -- Processorʵ��
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
end component;

component POC is    -- POCʵ��
    Port (

        ADDR : in STD_LOGIC;  -- �����ַ
        Din : in STD_LOGIC_VECTOR(7 downto 0);   -- �����λ����
        RW : in STD_LOGIC;                        -- �����д�ź� 
        CLK : in STD_LOGIC;    -- ����ʱ���ź�
        reset : in STD_LOGIC;  -- �����ź�
        RDY : in STD_LOGIC;    -- ����Ready�źţ���Printerģ�鴫��
        Dout : out STD_LOGIC_VECTOR(7 downto 0); -- �����λ���ݣ���Processor��
        IRQ : out STD_LOGIC;   -- ����ж������źţ���Processor��
        TR : out STD_LOGIC;    -- Transfer Request���������źţ�����Printer���������ݿ��Կ�ʼ���� 
        PD : out STD_LOGIC_VECTOR(7 downto 0); -- ��POC����������Printer 
        RW_state :out STD_LOGIC;-----��д״̬
        choose : in STD_LOGIC -- ѡ������ʽ�ź�
    );
end component;

component printer is
    Port (
        CLK : in STD_LOGIC; -- ʱ���ź�
        reset : in STD_LOGIC; -- �����ź�
        TR : in STD_LOGIC; -- ���������ź�
        PD : in STD_LOGIC_VECTOR(7 downto 0); -- ��ӡ����
        RDY : out STD_LOGIC;   -- ��ӡ��׼�����ź�
        DATA: out STD_LOGIC_VECTOR(7 downto 0):="00000000"
     );
end component;


signal ADDR : STD_LOGIC:='0'; -- ��ַ�ź�
signal Din : STD_LOGIC_VECTOR(7 downto 0):="00000000";   -- ���ݴ���POC�ź�  
signal Dout : STD_LOGIC_VECTOR(7 downto 0):="00000000";  -- ���ݴ���POC�ź�
signal RW : STD_LOGIC:='0';                        -- ������д�ź�
signal IRQ : STD_LOGIC:='0';                       -- �ж������ź�
signal RDY : STD_LOGIC:='0';                       -- ׼�����ź�
signal TR : STD_LOGIC:='0';                        -- ���������ź�
signal PD : STD_LOGIC_VECTOR(7 downto 0):="00000000";    -- ��ӡ����ѡ���źŷ�ʽ�ź�
signal RW_state : STD_LOGIC:='0';-----��д״̬
begin

u1 : processor port map (CLK, Dout, IRQ, choose, reset, ADDR, Din, RW,RW_state);
u2 : POC port map (ADDR, Din, RW, CLK, reset, RDY, Dout, IRQ, TR, PD,RW_state,choose);
u3 : printer port map (CLK, reset, TR, PD, RDY,DATA);
end Behavioral;
