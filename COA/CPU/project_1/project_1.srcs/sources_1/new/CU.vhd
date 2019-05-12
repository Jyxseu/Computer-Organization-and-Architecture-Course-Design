----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/03/21 15:03:12
-- Design Name: 
-- Module Name: CU - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CU is
Port ( 
CLK: in std_logic;
RESET: in std_logic;
Flags: in std_logic;
from_IR: in std_logic_vector(7 downto 0);
WR_en: out std_logic_vector(0 downto 0);
control_signal: buffer std_logic_vector(31 downto 0)
);
end CU;

architecture Behavioral of CU is
begin
process(CLK)

variable car_addr:std_logic_vector(7 downto 0):="00000000";
variable WR:std_logic_vector(0 downto 0);
begin

if CLK'event and CLK='1' then
if control_signal(11)='1' then
WR:="1";
else WR:="0";
end if;
if control_signal(0)='1' then
car_addr:=car_addr+"00000001";
elsif control_signal(1)='1' then
case from_IR is
       when "00000001"=> car_addr:="00100000";-- store
       when "00000010"=> car_addr:="00010000";-- load
       when "00000011"=> car_addr:="00110000";-- add
       when "00000100"=> car_addr:="01000000";-- sub
       when "00000101"=>
       if Flags='0' then -- JMPGEZ
       car_addr:="11000010";--
       else 
       car_addr:="11000000";--
       end if;
       when "00000110"=> car_addr:="11000010";-- JMP
       when "00000111"=> car_addr:="01010000";-- HALT
       when "00001000"=> car_addr:="10110000";-- MPY
       when "00001001"=> car_addr:="11010000";-- DIV
       when "00001010"=> car_addr:="01100000";-- and
       when "00001011"=> car_addr:="01110000";-- or
       when "00001100"=> car_addr:="10000000";-- not
       when "00001101"=> car_addr:="10010000";-- shiftr
       when "00001110"=> car_addr:="10100000";-- shirfl
       when others=>null;
end case;
elsif control_signal(2)='1' then
car_addr:="00000000";
end if;

case car_addr is
   --fetch
    when "00000000"=>control_signal<=X"00000009";
    when "00000010"=> control_signal<=X"00000011";
    when "00000011"=> control_signal<=X"00000002";
  
    
    --LOAD
    when "00010000"=> control_signal<=X"00000061";
    when "00010001"=> control_signal<=X"00000009";

    when "00010011"=> control_signal<=X"00000181";
    when "00010100"=> control_signal<=X"00000201";
    when "00010101"=> control_signal<=X"00000404";

    --STORE
    when "00100000"=> control_signal<=X"00000061";
    when "00100001"=> control_signal<=X"00001001";
    when "00100010"=> control_signal<=X"00000801";

    when "00100100"=> control_signal<=X"00000404";
  
    --ADD
    when "00110000"=> control_signal<=X"00000061";
    when "00110001"=> control_signal<=X"00000009";

    when "00110011"=> control_signal<=X"00000081";
    when "00110100"=> control_signal<=X"00000201";
    when "00110101"=> control_signal<=X"00000404";
    
 
    --SUB
    when "01000000"=> control_signal<=X"00000061";
    when "01000001"=> control_signal<=X"00000009";

    when "01000011"=> control_signal<=X"00000081";
    when "01000100"=> control_signal<=X"00010001";
    when "01000101"=> control_signal<=X"00000404";
    --HALT
    when "01010000"=> control_signal<=X"00008000";
    --AND
    when "01100000"=> control_signal<=X"00000061";
    when "01100001"=> control_signal<=X"00000009";

    when "01100011"=> control_signal<=X"00000081";
    when "01100100"=> control_signal<=X"10000001";
    when "01100101"=> control_signal<=X"00000404";
    --OR
    when "01110000"=> control_signal<=X"00000061";
    when "01110001"=> control_signal<=X"00000009";

    when "01110011"=> control_signal<=X"00000081";
    when "01110100"=> control_signal<=X"08000001";
    when "01110101"=> control_signal<=X"00000404";
    --NOT
    when "10000000"=> control_signal<=X"00000061";
    when "10000001"=> control_signal<=X"00000009";

    when "10000011"=> control_signal<=X"00000081";
    when "10000100"=> control_signal<=X"04000001";
    when "10000101"=> control_signal<=X"00000404";
    --SHIFTR
    when "10010000"=> control_signal<=X"00020041";
    when "10010001"=> control_signal<=X"00000404";
    --shiftl
    when "10100000"=> control_signal<=X"02000041";
    when "10100001"=> control_signal<=X"00000404";
    --MPY
    when "10110000"=> control_signal<=X"00000061";
    when "10110001"=> control_signal<=X"00000009";
  
    when "10110011"=> control_signal<=X"00000081";
    when "10110100"=> control_signal<=X"01000001";
    when "10110101"=> control_signal<=X"00040001";
    when "10110110"=> control_signal<=X"00000404";
    --JUMPEZ
    when "11000000"=> control_signal<=X"00000041";
    when "11000001"=> control_signal<=X"00000404";
    when "11000010"=> control_signal<=X"00004001";
    when "11000011"=> control_signal<=X"00000404";
when others=>null;
end case;
if RESET='0' then
control_signal<=X"00000000";
end if;
end if;
WR_en<=WR;
end process;
end Behavioral;
