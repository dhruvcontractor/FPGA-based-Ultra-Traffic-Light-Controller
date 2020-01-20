library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity FSM is
port(   clk , S_BW , S_BE , S_C, ST       : in std_logic;--set
        ANorth, ANorth_Arrow,ASouth, ASouth_Arrow  : out std_logic_vector( 2 downto 0);-- side A signals
        BWest, BWest_Arrow, BEast, BEast_Arrow : out std_logic_vector(2 downto 0); -- side B signals
        C: out std_logic_vector(2 downto 0);
        Current_State: out std_logic_vector(3 downto 0);
        led_S_BW, led_S_BE , led_S_C        : out std_logic;
        Tinout : out std_logic_vector(1 downto 0));
        
        
       -- led_A: out std_logic_vector(4 downto 0));
end FSM;

architecture Behavioral of FSM is

--===========Temporarty Signals
--============================= 
--type state_type is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10);
signal state: std_logic_vector(3 downto 0):="0001";
--signal count: std_logic_vector(3 downto 0);
--constant sec5: std_logic_vector(3 downto 0) := "0011";-- 3s for Green Lights and Red Lights and Yellow Lights during stright transition either North to South and viceverse and West to east and Viceverse
--constant sec1: std_logic_vector(3 downto 0) := "0001"; -- 1s for Yellow light, Yellow arrows and Green Arrows.  

begin

process(clk,ST)
begin
-- Red := "100";
-- Yellow := "110";
-- Green  := "010"; 
-- NS means North to South and SN means South to North.
-- EW means East to West and WE means West to East.    
if (clk'event and clk = '1' and ST = '1') then
			Tinout <= "00";
     case state is 
        when "0001" => -- s0
                 -- side A left turn  arrows are green and all others are Red.
                ANorth <= "100";
                ANorth_Arrow <="010";
                ASouth <= "100";
                ASouth_Arrow <= "010";
                BWest <= "100";
                BWest_Arrow <= "100";
                BEast <= "100";
                BEast_Arrow <= "100";
                C <= "100";
                Current_state <= "0001";
				
                Tinout <= "01";
                state <= "0010";                 
        when "0010" => --s1
                -- side A left turn arrow are Yellow and all others are Red.            
                ANorth <= "100";
                ANorth_Arrow <="110";
                ASouth <= "100";
                ASouth_Arrow <= "110";
                BWest <= "100";
                BWest_Arrow <= "100";
                BEast <= "100";
                BEast_Arrow <= "100";
                C <= "100";
                Current_state <= "0010";		
                Tinout <= "01";
                state <= "0011";                 
        when "0011" => --s2
				-- side A NS and SN are Green and with that Yellow lights are ON on Side A left turn arrows
                   -- to go with caution and all other are Red.
                 
                   ANorth <= "010";
                   ANorth_Arrow <="110";
                   ASouth <= "010";
                   ASouth_Arrow <= "110";
                   BWest <= "100";
                   BWest_Arrow <= "100";
                   BEast <= "100";
                   BEast_Arrow <= "100";
                   C <= "100";
				 Current_state <= "0011";	
				Tinout <= "11";
                state <= "0100";
				
        when "0100" => --s3
			  -- side A NS and SN are Yellow and with that Side A left turn arrows are Yellow and all others are Red                                                                 
                  
                   ANorth <= "110";
                   ANorth_Arrow <="110";
                   ASouth <= "110";
                   ASouth_Arrow <= "110";
                   BWest <= "100";
                   BWest_Arrow <= "100";
                   BEast <= "100";
                   BEast_Arrow <= "100";
                   C <= "100";
				   Tinout <= "01";
				    Current_state <= "0100";
			   
      
               if (S_BW = '0' and S_BE = '0') then -- No cars are waiting on the either of the left turns on side B, So it will go to State
                            state <= "";
               elsif(S_BW = '1' and S_BE = '1') then -- Cars are waiting on both left turns on side B so It will go to state
                            state <= "";
			   elsif(S_BW = '1' and S_BE = '0') then -- Cars are waiting on side BWest so It will go to state
                            state <= "";
			   elsif(S_BW = '0' and S_BE = '1') then -- Cars are waiting on side BEast so it will go to state
                            state <= "";					
                 end if;     
				 
        when "0101" => --s4
		     -- Here Side B West and East left turn signals are Green. and all others are Red.
                  
                   ANorth <= "100";
                   ANorth_Arrow <="100";
                   ASouth <= "100";
                   ASouth_Arrow <= "100";
                   BWest <= "100";
                   BWest_Arrow <= "010";
                   BEast <= "100";
                   BEast_Arrow <= "010";
                   C <= "100";
					 state <= "0110";
			       Tinout <= "01";
                  Current_state <= "0101"; 
				   
        when "0110" => --s5
			 -- Side B west and east left turn arrows will become Yellow and all others are Red.           
                   
                   ANorth <= "100";
                   ANorth_Arrow <="100";
                   ASouth <= "100";
                   ASouth_Arrow <= "100";
                   BWest <= "100";
                   BWest_Arrow <= "110";
                   BEast <= "100";
                   BEast_Arrow <= "110";
                   C <= "100";
					Current_state <= "0110";
                Tinout <= "01";
                state <= "1011"; -- Go to the State S10.
        when "0111" => --s6
		     -- Here Side B West and left turn signal are Green. and all others are Red including side BEast and BEast_Arrow
                  
                   ANorth <= "100";
                   ANorth_Arrow <="100";
                   ASouth <= "100";
                   ASouth_Arrow <= "100";
                   BWest <= "010";
                   BWest_Arrow <= "010";
                   BEast <= "100";
                   BEast_Arrow <= "100";
                   C <= "100";
					 state <= "1000";
			       Tinout <= "01";
                  Current_state <= "0111"; 
				   
        when "1000" => --s7
			 -- Side B west stays Green and West left turn arrow becomes Yellow and all others are Red.           
                   
                   ANorth <= "100";
                   ANorth_Arrow <="100";
                   ASouth <= "100";
                   ASouth_Arrow <= "100";
                   BWest <= "010";
                   BWest_Arrow <= "110";
                   BEast <= "100";
                   BEast_Arrow <= "100";
                   C <= "100";
					Current_state <= "1000";
                Tinout <= "01";
                state <= "1011"; -- Go to the State S10.
		when "1001" => --s8
		     -- Here Side B East and East left turn signal are Green. and all others are Red including side BWest and BWest_Arrow.
                  
                   ANorth <= "100";
                   ANorth_Arrow <="100";
                   ASouth <= "100";
                   ASouth_Arrow <= "100";
                   BWest <= "100";
                   BWest_Arrow <= "100";
                   BEast <= "010";
                   BEast_Arrow <= "010";
                   C <= "100";
					 state <= "1010";
			       Tinout <= "01";
                  Current_state <= "1001"; 
				   
        when "1010" => --s9
			 -- Side B East stays Green and east left turn arrow becomes Yellow and all others are Red.           
                   
                   ANorth <= "100";
                   ANorth_Arrow <="100";
                   ASouth <= "100";
                   ASouth_Arrow <= "100";
                   BWest <= "100";
                   BWest_Arrow <= "100";
                   BEast <= "010";
                   BEast_Arrow <= "110";
                   C <= "100";
					Current_state <= "1010";
                Tinout <= "01";
                state <= "1011"; -- It will go to State S10.
		when "1011" => --s10 
		 -- Side BWest and BEast are Green and all others are red.
                  
                   ANorth <= "100";
                   ANorth_Arrow <="100";
                   ASouth <= "100";
                   ASouth_Arrow <= "100";
                   BWest <= "010";
                   BWest_Arrow <= "100";
                   BEast <= "010";
                   BEast_Arrow <= "100";
                   C <= "100";
				    Current_state <= "1011";
					Tinout <= "11";
					state <= "1100";
        when "1100" => --s11
		 -- Side B WE and EW are Yellow.
                      
                   ANorth <= "100";
                   ANorth_Arrow <="100";
                   ASouth <= "100";
                   ASouth_Arrow <= "100";
                   BWest <= "110";
                   BWest_Arrow <= "100";
                   BEast <= "110";
                   BEast_Arrow <= "100";
                   C <= "100";
                   Current_state <= "1100";
                    if(S_C = '1') then
                             state <= "1101";
                    else
                             state <= "0001";
                    end if;
                    Tinout <= "01";
				   
				-- If there is a car waiting at Side C then state s11 will move to s12, Otherwise it will go back to s0.
        
			  
				
        when "1101" => --s12
		        -- Here side C light becomes Green and all others are Red.
                   ANorth <= "100";
                   ANorth_Arrow <="100";
                   ASouth <= "100";
                   ASouth_Arrow <= "100";
                   BWest <= "100";
                   BWest_Arrow <= "100";
                   BEast <= "100";
                   BEast_Arrow <= "100";
                   C <= "010";
				   Tinout <= "11";
				   Current_state <= "1101";
				  
                   state <= "1110";
				   
        when "1110" => -- s9
		 -- Side C light becomes Yellow and all others are red.                  
                   ANorth <= "100";
                   ANorth_Arrow <="100";
                   ASouth <= "100";
                   ASouth_Arrow <= "100";
                   BWest <= "100";
                   BWest_Arrow <= "100";
                   BEast <= "100";
                   BEast_Arrow <= "100";
                   C <= "110";
					Current_state <= "1110";
					Tinout <= "01";
					state <= "0001";
       when others =>
               state <= "0001";
  end case;
  end if;
  end process;
  
 led_S_BW<= S_BW ;
 led_S_BE<= S_BE ;
 led_S_C<= S_C;
   
end Behavioral;