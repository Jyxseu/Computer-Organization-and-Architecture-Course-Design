----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/04/19 15:11:33
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP is
Port (
 CLK : in STD_LOGIC;
 RESET : in STD_LOGIC;
 digital: out std_logic_vector(7 downto 0);
 digital_en:out std_logic_vector (7 downto 0)
 );
end TOP;

architecture Behavioral of TOP is

signal MEMORY_MBR:std_logic_vector(15 downto 0);
signal address:std_logic_vector(7 downto 0);
signal MBR_OUT:std_logic_vector(15 downto 0);
signal control_signal:std_logic_vector(31 downto 0);
signal PC_MAR:std_logic_vector(7 downto 0);
signal ALU_MBR:std_logic_vector(15 downto 0);
signal IR_CU:std_logic_vector(7 downto 0);
signal BR_ALU:std_logic_vector(15 downto 0);
signal Flags:std_logic;
signal WR_en:std_logic_vector(0 downto 0);


component CU is
Port ( 
CLK: in std_logic;
RESET: in std_logic;
Flags: in std_logic;
from_IR: in std_logic_vector(7 downto 0);
WR_en: out std_logic_vector(0 downto 0);
control_signal: buffer std_logic_vector(31 downto 0)
);
end component;

component MBR is
Port ( 
CLK:in std_logic;
RESET:in std_logic;
from_Memory:in std_logic_vector(15 downto 0);
MBR_out:buffer std_logic_vector(15 downto 0);
from_ACC:in std_logic_vector(15 downto 0);
control_signal:in std_logic_vector(31 downto 0)
);
end component;

component ALU is
Port ( 
CLK:in std_logic;
control_signal:in std_logic_vector(31 downto 0);
from_BR:in std_logic_vector(15 downto 0);
--ACC_H:out std_logic_vector(15 downto 0);
ACC_L:buffer std_logic_vector(15 downto 0);
digital:out std_logic_vector(7 downto 0);
RESET: in std_logic;
digital_en:out std_logic_vector(7 downto 0);

Flags:out std_logic
);
end component;

component IR is
Port ( 
CLK:in std_logic;
from_MBR:in std_logic_vector(15 downto 0);
control_signal:in std_logic_vector(31 downto 0);
to_CU:out std_logic_vector(7 downto 0);
RESET:in std_logic
);
end component;

component MAR is
Port (
CLK:in std_logic;
RESET:in std_logic;
control_signal:in std_logic_vector(31 downto 0);
from_MBR:in std_logic_vector(15 downto 0);
from_PC:in std_logic_vector(7 downto 0);
MAR_out:out std_logic_vector(7 downto 0)
 );
end component;

component PC is
Port (
CLK:in std_logic;
control_signal:in std_logic_vector(31 downto 0);
from_MBR:in std_logic_vector(15 downto 0);
RESET:in std_logic;
to_MAR:buffer std_logic_vector(7 downto 0)
 );
end component;

component BR is
Port (
CLK:in std_logic;
RESET:in std_logic;
from_MBR:in std_logic_vector(15 downto 0);
to_ALU:out std_logic_vector(15 downto 0);
control_signal:in std_logic_vector(31 downto 0)
 );
end component;

component memory is 
port(
clka : in STD_LOGIC;
wea : in STD_LOGIC_VECTOR(0 DOWNTO 0);
addra : in STD_LOGIC_VECTOR(7 DOWNTO 0);
dina : in STD_LOGIC_VECTOR(15 DOWNTO 0);
douta : out STD_LOGIC_VECTOR(15 DOWNTO 0)
);
end component;

begin
U1:CU port map(CLK,RESET,Flags,IR_CU,WR_en,control_signal);
U2:ALU port map(CLK,control_signal,BR_ALU,ALU_MBR,digital,RESET,digital_en,Flags);
U3:BR port map (CLK,RESET,MBR_OUT,BR_ALU,control_signal);
U4:IR port map(CLK,MBR_OUT,control_signal,IR_CU,RESET);
U5:MAR port map(CLK,RESET,control_signal,MBR_OUT,PC_MAR,address);
U6:MBR port map(CLK,RESET,MEMORY_MBR,MBR_OUT,ALU_MBR,control_signal);
U7:PC port map(CLK,control_signal,MBR_OUT,RESET,PC_MAR);
U8:memory port map(CLK,WR_en,address,MBR_OUT,MEMORY_MBR);

end Behavioral;
