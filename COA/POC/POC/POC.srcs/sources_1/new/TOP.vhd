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
    CLK : in STD_LOGIC;    -- 输入时钟信号
    choose : in STD_LOGIC; -- 工作方式选择信号
    reset : in STD_LOGIC;  -- 重置工作方式信号
    DATA : out STD_LOGIC_VECTOR(7 downto 0)
 );
end TOP;

architecture Behavioral of TOP is

component processor is    -- Processor实体
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
end component;

component POC is    -- POC实体
    Port (

        ADDR : in STD_LOGIC;  -- 输入地址
        Din : in STD_LOGIC_VECTOR(7 downto 0);   -- 输入八位数据
        RW : in STD_LOGIC;                        -- 输入读写信号 
        CLK : in STD_LOGIC;    -- 输入时钟信号
        reset : in STD_LOGIC;  -- 重置信号
        RDY : in STD_LOGIC;    -- 输入Ready信号，由Printer模块传入
        Dout : out STD_LOGIC_VECTOR(7 downto 0); -- 输出八位数据（至Processor）
        IRQ : out STD_LOGIC;   -- 输出中断请求信号（至Processor）
        TR : out STD_LOGIC;    -- Transfer Request传输请求信号，发给Printer，表明数据可以开始传输 
        PD : out STD_LOGIC_VECTOR(7 downto 0); -- 由POC传输数据至Printer 
        RW_state :out STD_LOGIC;-----读写状态
        choose : in STD_LOGIC -- 选择工作方式信号
    );
end component;

component printer is
    Port (
        CLK : in STD_LOGIC; -- 时钟信号
        reset : in STD_LOGIC; -- 重置信号
        TR : in STD_LOGIC; -- 传输请求信号
        PD : in STD_LOGIC_VECTOR(7 downto 0); -- 打印数据
        RDY : out STD_LOGIC;   -- 打印机准备好信号
        DATA: out STD_LOGIC_VECTOR(7 downto 0):="00000000"
     );
end component;


signal ADDR : STD_LOGIC:='0'; -- 地址信号
signal Din : STD_LOGIC_VECTOR(7 downto 0):="00000000";   -- 数据传入POC信号  
signal Dout : STD_LOGIC_VECTOR(7 downto 0):="00000000";  -- 数据传出POC信号
signal RW : STD_LOGIC:='0';                        -- 表征读写信号
signal IRQ : STD_LOGIC:='0';                       -- 中断请求信号
signal RDY : STD_LOGIC:='0';                       -- 准备好信号
signal TR : STD_LOGIC:='0';                        -- 传输请求信号
signal PD : STD_LOGIC_VECTOR(7 downto 0):="00000000";    -- 打印数据选择信号方式信号
signal RW_state : STD_LOGIC:='0';-----读写状态
begin

u1 : processor port map (CLK, Dout, IRQ, choose, reset, ADDR, Din, RW,RW_state);
u2 : POC port map (ADDR, Din, RW, CLK, reset, RDY, Dout, IRQ, TR, PD,RW_state,choose);
u3 : printer port map (CLK, reset, TR, PD, RDY,DATA);
end Behavioral;
