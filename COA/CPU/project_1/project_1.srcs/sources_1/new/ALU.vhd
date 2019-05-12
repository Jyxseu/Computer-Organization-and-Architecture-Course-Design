----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.STD_LOGIC_UNSIGNED.all;

entity ALU is
Port ( 
CLK:in std_logic;
control_signal:in std_logic_vector(31 downto 0);
from_BR:in std_logic_vector(15 downto 0);
ACC_H:buffer std_logic_vector(15 downto 0);
ACC_L:buffer std_logic_vector(15 downto 0);
digital:out std_logic_vector(7 downto 0);
RESET: in std_logic;
digital_en:out std_logic_vector(7 downto 0);

Flags:out std_logic
);
end ALU;

architecture Behavioral of ALU is
signal temp:std_logic_vector(15 downto 0);
signal temp1:std_logic_vector(15 downto 0):="0000000000000000";

signal digital_en_flag: std_logic:='0';

signal clk_digital:std_logic;
shared variable count_div:	integer range 0 to 5000;	
shared variable count:integer range 0 to 7;			
shared variable one,two,three,four,five,six,seven,eight:std_logic_vector(3 downto 0);		

begin
-------------------------------------------------------------------------
process(CLK)
begin 
		if (CLK'event and CLK='1') then				
			if count_div =4999 then
				count_div:=0;
--				clk_digital<='1';
            clk_digital<=not clk_digital;
			else 
				count_div:=count_div+1;
--				clk_digital<='0';
			end if;
		end if;	
end process;

-----------------------------------------------------------------------
process(CLK)
   begin
	if (CLK'event and CLK='1') then
	   one:=temp(3 downto 0);
	   two:=temp(7 downto 4);
	   three:=temp(11 downto 8);
	   four:=temp(15 downto 12);

--             one:=ACC_L(3 downto 0);
--              two:=ACC_L(7 downto 4);
--              three:=ACC_L(11 downto 8);
--              four:=ACC_L(15 downto 12);

     five:=temp1(3 downto 0);
     six:=temp1(7 downto 4);
     seven:=temp1(11 downto 8);
     eight:=temp1(15 downto 12);

--       five:=ACC_H(3 downto 0);
--       six:=ACC_H(7 downto 4);
--       seven:=ACC_H(11 downto 8);
--       eight:=ACC_H(15 downto 12);
	end if;
end process;

-----------------------------------------------------------------------------
process(clk_digital)
	 begin 
	 if clk_digital'event and clk_digital='1' then			
		if count=7 then
			count:=0;
		else count:=count+1;
		end if;
    end if;
		
	 if (RESET='1') then							
	if(count=0) then							
		   digital_en<="11111110";							
			case one is
				when "0000" => digital<="11000000"; --0		
				when "0001" => digital<="11111001"; --1
				when "0010" => digital<="10100100"; --2
				when "0011" => digital<="10110000"; --3
				when "0100" => digital<="10011001"; --4
				when "0101" => digital<="10010010"; --5
				when "0110" => digital<="10000010"; --6
				when "0111" => digital<="11111000"; --7
				when "1000" => digital<="10000000"; --8
				when "1001" => digital<="10010000"; --9
				when "1010" => digital<="10001000"; --a
				when "1011" => digital<="10000011"; --b
				when "1100" => digital<="11000110"; --c
				when "1101" => digital<="10100001"; --d
				when "1110" => digital<="10000110"; --e
				when "1111" => digital<="10001110"; --f
				when others => digital<="11111111";
			end case;	
     elsif(count=1) then					
			digital_en<="11111101";							
			case two is
				when "0000" => digital<="11000000"; --0		
				when "0001" => digital<="11111001"; --1
				when "0010" => digital<="10100100"; --2
				when "0011" => digital<="10110000"; --3
				when "0100" => digital<="10011001"; --4
				when "0101" => digital<="10010010"; --5
				when "0110" => digital<="10000010"; --6
				when "0111" => digital<="11111000"; --7
				when "1000" => digital<="10000000"; --8
				when "1001" => digital<="10010000"; --9
				when "1010" => digital<="10001000"; --a
				when "1011" => digital<="10000011"; --b
				when "1100" => digital<="11000110"; --c
				when "1101" => digital<="10100001"; --d
				when "1110" => digital<="10000110"; --e
				when "1111" => digital<="10001110"; --f
				when others => digital<="11111111";
			end case;
      elsif(count=2) then					
			digital_en<="11111011";							
			case three is
				when "0000" => digital<="11000000"; --0		
				when "0001" => digital<="11111001"; --1
				when "0010" => digital<="10100100"; --2
				when "0011" => digital<="10110000"; --3
				when "0100" => digital<="10011001"; --4
				when "0101" => digital<="10010010"; --5
				when "0110" => digital<="10000010"; --6
				when "0111" => digital<="11111000"; --7
				when "1000" => digital<="10000000"; --8
				when "1001" => digital<="10010000"; --9
				when "1010" => digital<="10001000"; --a
				when "1011" => digital<="10000011"; --b
				when "1100" => digital<="11000110"; --c
				when "1101" => digital<="10100001"; --d
				when "1110" => digital<="10000110"; --e
				when "1111" => digital<="10001110"; --f
				when others => digital<="11111111";
			end case;
      elsif(count=3) then					
			digital_en<="11110111";							
			case four is
				when "0000" => digital<="11000000"; --0		
				when "0001" => digital<="11111001"; --1
				when "0010" => digital<="10100100"; --2
				when "0011" => digital<="10110000"; --3
				when "0100" => digital<="10011001"; --4
				when "0101" => digital<="10010010"; --5
				when "0110" => digital<="10000010"; --6
				when "0111" => digital<="11111000"; --7
				when "1000" => digital<="10000000"; --8
				when "1001" => digital<="10010000"; --9
				when "1010" => digital<="10001000"; --a
				when "1011" => digital<="10000011"; --b
				when "1100" => digital<="11000110"; --c
				when "1101" => digital<="10100001"; --d
				when "1110" => digital<="10000110"; --e
				when "1111" => digital<="10001110"; --f
				when others => digital<="11111111";
			end case;	
	 elsif(count=4) then					
            digital_en<="11101111";                            
            if digital_en_flag='1' then
            case five is
                when "0000" => digital<="11000000"; --0        
                when "0001" => digital<="11111001"; --1
                when "0010" => digital<="10100100"; --2
                when "0011" => digital<="10110000"; --3
                when "0100" => digital<="10011001"; --4
                when "0101" => digital<="10010010"; --5
                when "0110" => digital<="10000010"; --6
                when "0111" => digital<="11111000"; --7
                when "1000" => digital<="10000000"; --8
                when "1001" => digital<="10010000"; --9
                when "1010" => digital<="10001000"; --a
                when "1011" => digital<="10000011"; --b
                when "1100" => digital<="11000110"; --c
                when "1101" => digital<="10100001"; --d
                when "1110" => digital<="10000110"; --e
                when "1111" => digital<="10001110"; --f
                when others => digital<="11111111";			
            end case;	
            else digital<="11000001";--u
            end if;
     elsif(count=5) then					
            digital_en<="11011111";                            
            if digital_en_flag='1' then
            case six is
                 when "0000" => digital<="11000000"; --0        
                 when "0001" => digital<="11111001"; --1
                 when "0010" => digital<="10100100"; --2
                 when "0011" => digital<="10110000"; --3
                 when "0100" => digital<="10011001"; --4
                 when "0101" => digital<="10010010"; --5
                 when "0110" => digital<="10000010"; --6
                 when "0111" => digital<="11111000"; --7
                 when "1000" => digital<="10000000"; --8
                 when "1001" => digital<="10010000"; --9
                 when "1010" => digital<="10001000"; --a
                 when "1011" => digital<="10000011"; --b
                 when "1100" => digital<="11000110"; --c
                 when "1101" => digital<="10100001"; --d
                 when "1110" => digital<="10000110"; --e
                 when "1111" => digital<="10001110"; --f
                 when others => digital<="11111111";            
             end case;
             else digital<="10001100";--p
              end if;
     elsif(count=6) then					
            digital_en<="10111111";                            
            if digital_en_flag='1' then
            case seven is
               when "0000" => digital<="11000000"; --0        
               when "0001" => digital<="11111001"; --1
               when "0010" => digital<="10100100"; --2
               when "0011" => digital<="10110000"; --3
               when "0100" => digital<="10011001"; --4
               when "0101" => digital<="10010010"; --5
               when "0110" => digital<="10000010"; --6
               when "0111" => digital<="11111000"; --7
               when "1000" => digital<="10000000"; --8
               when "1001" => digital<="10010000"; --9
               when "1010" => digital<="10001000"; --a
               when "1011" => digital<="10000011"; --b
               when "1100" => digital<="11000110"; --c
               when "1101" => digital<="10100001"; --d
               when "1110" => digital<="10000110"; --e
               when "1111" => digital<="10001110"; --f
               when others => digital<="11111111";            
            end case;
            else digital<="11000110";--c
            end if;
       elsif(count=7) then					
            digital_en<="01111111";                            
            if digital_en_flag='1' then
            case eight is
               when "0000" => digital<="11000000"; --0        
               when "0001" => digital<="11111001"; --1
               when "0010" => digital<="10100100"; --2
               when "0011" => digital<="10110000"; --3
               when "0100" => digital<="10011001"; --4
               when "0101" => digital<="10010010"; --5
               when "0110" => digital<="10000010"; --6
               when "0111" => digital<="11111000"; --7
               when "1000" => digital<="10000000"; --8
               when "1001" => digital<="10010000"; --9
               when "1010" => digital<="10001000"; --a
               when "1011" => digital<="10000011"; --b
               when "1100" => digital<="11000110"; --c
               when "1101" => digital<="10100001"; --d
               when "1110" => digital<="10000110"; --e
               when "1111" => digital<="10001110"; --f
               when others => digital<="11111111";            
           end case;   		
        else digital<="11111111";
                       end if;
        end if;	 
		else 								
 			digital_en<="11111111";				
		end if; 
end process; 




process(CLK)
variable x:std_logic_vector(31 downto 0);
begin
if temp(15)='1' then ----If ACC<0,flag<=1
	Flags<='1';
else Flags<='0';
end if;

if(CLK'event and CLK='1')then
if RESET='1' then
if control_signal(8)='1' then--ACC<=0
temp<="0000000000000000";
--temp1<="0000000000000000";
    elsif control_signal(9)='1' then--ADD
    temp<=temp+from_BR;
    
     
        elsif control_signal(16)='1' then--SUB
        temp<=temp-from_BR;
            elsif control_signal(17)='1' then--shiftr
            temp<='0'&temp(15 downto 1); 
               elsif control_signal(25)='1' then--shiftl
               temp<=temp(14 downto 0)&'0'; 
                  elsif control_signal(24)='1' then
                         
                       if (temp(15) xor from_BR(15))='1'then 
                         if temp(15)='1' then ----temp<0
                            x:=(0-temp)*from_BR;
                            else
                             x:=temp*(0-from_BR);
                          end if;
                          x:=0-x;
                          temp<=x(15 downto 0);  
                          temp1<=x(31 downto 16);        
--                          ACC_H<=x(31 downto 16);                         
--                         temp1<= ACC_H;
                        else 
                           if temp(15)='1' then
                            x:=(0-temp)*(0-from_BR);
                               else
                                x:=temp*from_BR;
                            end if;
                            temp<=x(15 downto 0);  
                            temp1<=x(31 downto 16);
--                            ACC_H<=x(31 downto 16);                         
--                            temp1<= ACC_H;
                     end if; 
                         elsif control_signal(28)='1' then
                           temp<=temp and from_BR; --and
                          
                           temp1<= "0000000000000000";
                           elsif control_signal(27)='1' then
                           temp<=temp or from_BR; --or
                           elsif control_signal(26)='1' then
                           temp<=not from_BR; --not
                           end if;
ACC_L<=temp;  
ACC_H<=temp1;

if  temp1/= "0000000000000000" then
digital_en_flag<='1';
else
digital_en_flag<='0';
end if;                            
else 
ACC_L<="0000000000000000";
ACC_H<="0000000000000000";
end if;
end if;
end process;
end Behavioral;
