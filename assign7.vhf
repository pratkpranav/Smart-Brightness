----------------------------------------------------------------------------------
-- Company:
-- Engineer:
-- 
-- Create Date:    18:51:10 09/04/2019
-- Design Name:
-- Module Name:    pract - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pract is
port(
clk : in STD_LOGIC;
outpwm : out STD_LOGIC_vector(15 downto 0);
A : out STD_LOGIC;
B : out STD_LOGIC;
C : out STD_LOGIC;
D: out STD_LOGIC;
E : out STD_LOGIC;
F : out STD_LOGIC;
G : out STD_LOGIC;
A0 : out STD_LOGIC;
A1 : out STD_LOGIC;
A2 : out STD_LOGIC;
A3 : out STD_LOGIC;
CS : out std_logic;
SCK : out std_logic;
SDO : in std_logic

);
end pract;

architecture Behavioral of pract is

signal u :std_logic_vector(4 downto 0);
signal vec : std_logic_vector(3 downto 0);
Signal t : STD_LOGIC_vector(25 downto 0);
signal twentyfiveHzclock : STD_LOGIC ;
signal fourhundredHzclock : STD_LOGIC ;
signal threeMegaHzclock : std_logic;
signal s : STD_LOGIC_vector(12 downto 0);
signal counterinput : STD_LOGIC_vector(4 downto 0);
signal     P_tmp : std_logic_vector(15 downto 0);
signal              P0  : std_logic; 
signal             P1  :  std_logic; 
signal       P10 :    std_logic; 
signal             P11 :    std_logic; 
signal             P12 :    std_logic; 
signal             P13 :    std_logic; 
signal             P14 :    std_logic; 
signal             P15 :    std_logic; 
signal             P2  :    std_logic; 
signal             P3  :    std_logic; 
signal             P4  :    std_logic; 
signal             P5  :    std_logic; 
signal             P6  :    std_logic; 
signal             P7  :    std_logic; 
signal             P8  :    std_logic; 
signal             P9  :    std_logic;
signal             temp  : std_logic;
signal             SDOcounter : std_logic_vector(3 downto 0);
signal pp : std_logic;
signal input : std_logic_vector(0 to 14);

begin

Process(clk,t,twentyfiveHzclock)
begin
    if(clk'event and clk='1' ) then
        t <= t+1 ; 
        if(t = "10111110101111000010000000") then
            twentyfiveHzclock <= not twentyfiveHzclock;
            t<="00000000000000000000000000";
        end if;

    end if;
end process;


Process(clk,s,fourhundredHzclock)
begin
    if(clk'event and clk='1' ) then
        s <= s+1 ;
        if(s =      "1100001101010") then
            fourhundredHzclock <= not fourhundredHzclock;
            s <=    "0000000000000";
        end if;
    end if;
end process;

Process(clk,u,threeMegaHzclock)
begin
    if(clk'event and clk='1' ) then
        u <= u+1 ; 
        if(u = "11111") then
            threeMegaHzclock <= not threeMegaHzclock;
            u<="00000";
        end if;
    end if;
end process;

Process(fourhundredHzclock,clk,counterinput,vec)
begin
        if(clk'event and clk='1') then
            counterinput <= counterinput + 1 ;
            if(counterinput = "10000") then
                counterinput <= "00000";
            end if;
        if(counterinput< vec ) then
            outpwm <= "1111111111111111";
        else
            outpwm <= "0000000000000000";
        end if;
    end if;
end process;

Process(threeMegaHzclock,twentyfiveHzclock)
begin 


		if(twentyfiveHzclock = '1' and twentyfiveHzclock'event ) then
		    temp <= '1';
			CS <= '0';
                               SDOcounter <= "0000";  
		end if;
		if(threeMegaHzclock ='1'  and threeMegaHzclock'event) then
		if(temp = '1') then
		      SDOcounter<= SDOcounter +1;
		     end if;
		     end if;
    if(SDOcounter = "1111") then
                     temp <= '0';
                   CS <= '1';  
             end if;
    
    
    
    pp <= NOT temp or (temp and threeMegaHzclock);
    SCK <= pp;
    
		
		
		
		
		
		
		

end process;

Process(pp)
begin
if(pp'event and pp = '1') then
		input <=  input(1 to 14)&SDO;
		end if;
end process;


Process(temp)
begin
if(temp'event and temp ='0') then
		vec <= input(3 to 6);
		end if; 
end process;

Process(vec,clk,P_tmp,P0,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13,P14,P15)
begin

case vec is 

      when "0000" => P_tmp <= "0000000000000001";
      when "0001" => P_tmp <= "0000000000000010";
      when "0010" => P_tmp <= "0000000000000100";
      when "0011" => P_tmp <= "0000000000001000";
      when "0100" => P_tmp <= "0000000000010000";
      when "0101" => P_tmp <= "0000000000100000";
      when "0110" => P_tmp <= "0000000001000000";
      when "0111" => P_tmp <= "0000000010000000";
      when "1000" => P_tmp <= "0000000100000000";
      when "1001" => P_tmp <= "0000001000000000";
      when "1010" => P_tmp <= "0000010000000000";
      when "1011" => P_tmp <= "0000100000000000";
      when "1100" => P_tmp <= "0001000000000000";
      when "1101" => P_tmp <= "0010000000000000";
      when "1110" => P_tmp <= "0100000000000000";
      when "1111" => P_tmp <= "1000000000000000";
      when others => NULL;
      end case;
		
    P15 <= P_tmp(15);
    P14 <= P_tmp(14);
    P13 <= P_tmp(13);
    P12 <= P_tmp(12);
    P11 <= P_tmp(11);
    P10 <= P_tmp(10);
    P9  <= P_tmp(9);
    P8  <= P_tmp(8);
    P7  <= P_tmp(7);
    P6  <= P_tmp(6);
    P5  <= P_tmp(5);
    P4  <= P_tmp(4);
    P3  <= P_tmp(3);
    P2  <= P_tmp(2);
    P1  <= P_tmp(1);
    P0  <= P_tmp(0);
	 
	 A <= P1 OR P4 OR P11 OR P13;
	 B <= P5 OR P6 OR P11 OR P12 OR P14 OR P15;
	 C <= P2 OR P12 OR P14 OR P15;
	 D <= P1 OR P4 OR P7 OR P10 OR P15;
	 E <= P1 OR P3 OR P4 OR P5 OR P7 OR P9 ;
	 F <= P1 OR P2 OR P3 OR P7 OR P13;
	 G <= P0 OR P1 OR P7 OR P12 ;
	 A0 <= P10 AND NOT P10;
	 A1 <= P10 OR NOT P10;
	 A2 <= P10 OR NOT P10;
	 A3 <= P10 OR NOT P10;
end process;

end Behavioral;

