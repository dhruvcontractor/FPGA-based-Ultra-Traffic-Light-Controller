library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity PmodCLP is
    Port (		btnC    : in std_logic;									--use BTNR as reset input
                clk     : in std_logic;						--100 MHz clock input
				--lcd input signals
				--signal on connector JB 
				Current_state  : in std_logic_vector(3 downto 0);
				JB      : out std_logic_vector(7 downto 0);		--output bus, used for data transfer (DB)
					-- signal on connector JC
					--JC(4)register selection pin  (RS)
					--JC(5)selects between read/write modes (RW)
					--JC(6)enable signal for starting the data read/write (E)
				JC      : out std_logic_vector (6 downto 4)
			);		
end PmodCLP;

architecture Behavioral of PmodCLP is
			    
------------------------------------------------------------------
--  Component Declarations
------------------------------------------------------------------

------------------------------------------------------------------
--  Local Type Declarations
-----------------------------------------------------------------
--  Symbolic names for all possible states of the state machines.

	--LCD control state machine
	type mstate is (					  
		stFunctionSet,		 				--Initialization states
		stDisplayCtrlSet,
		stDisplayClear,
		stPowerOn_Delay,  					--Delay states
		stFunctionSet_Delay,
		stDisplayCtrlSet_Delay, 	
		stDisplayClear_Delay,
		stInitDne,							--Display characters and perform standard operations
		stActWr,
		stCharDelay							--Write delay for operations
	);

------------------------------------------------------------------
--  Signal Declarations and Constants
------------------------------------------------------------------
	--These constants are used to initialize the LCD pannel.

	--FunctionSet:
		--Bit 0 and 1 are arbitrary
		--Bit 2:  Displays font type(0=5x8, 1=5x11)
		--Bit 3:  Numbers of display lines (0=1, 1=2)
		--Bit 4:  Data length (0=4 bit, 1=8 bit)
		--Bit 5-7 are set
	--DisplayCtrlSet:
		--Bit 0:  Blinking cursor control (0=off, 1=on)
		--Bit 1:  Cursor (0=off, 1=on)
		--Bit 2:  Display (0=off, 1=on)
		--Bit 3-7 are set
	--DisplayClear:
		--Bit 1-7 are set	
		
	signal clkCount:	std_logic_vector (6 downto 0);
	signal count:		std_logic_vector (20 downto 0):= "000000000000000000000";	--21 bit count variable for timing delays
	signal delayOK:	    std_logic:= '0';												--High when count has reached the right delay time
	signal OneUSClk:	std_logic;													--Signal is treated as a 1 MHz clock	
	signal stCur:		mstate:= stPowerOn_Delay;									--LCD control state machine
	signal stNext:		mstate;			  	
	signal writeDone:	std_logic:= '0';											--Command set finish

	type LCD_CMDS_T is array(integer range <>) of std_logic_vector(9 downto 0);
	
	signal LCD_CMDS : LCD_CMDS_T := ( 
                         0 => "00"&X"3C",            --Function Set
                         1 => "00"&X"0C",            --Display ON, Cursor OFF, Blink OFF
                         2 => "00"&X"01",            --Clear Display
                         3 => "00"&X"02",             --return home
    
						 4 => "10"&X"52",             --R 
						 5 => "10"&X"45",             --E
						 6 => "10"&X"53",             --S 
					     7 => "10"&X"45",             --E 
						 8 => "10"&X"54",             --T 
                         9 => "10"&X"20",            --blank
                         10 => "10"&X"20",           --blank
                         11 => "10"&X"20",           --blank
                         12 => "10"&X"20",           --blank
                         13 => "10"&X"20",           --blank
                         14 => "10"&X"20" ,          --blank
                                             
                         15 => "00"&X"18");            --Shift left
	constant LCD_CMDS_01 : LCD_CMDS_T := ( 
                        0 => "00"&X"3C",			--Function Set
                        1 => "00"&X"0C",            --Display ON, Cursor OFF, Blink OFF
                        2 => "00"&X"01",            --Clear Display
                        3 => "00"&X"02",             --return home

                        4 => "10"&X"53", 			--S 
                        5 => "10"&X"49", 			--I
                        6 => "10"&X"44", 			--D
                        7 => "10"&X"45", 			--E
                        8 => "10"&X"41", 			--A
                        9 => "10"&X"20", 			--blank
                        10 => "10"&X"54", 			--T
                        11 => "10"&X"75", 			--u
                        12 => "10"&X"72", 			--r
                        13 => "10"&X"6E",           --n 
                        14 => "10"&X"20",           --blank
                        
                        15 => "00"&X"18");            --Shift left
	constant LCD_CMDS_02 : LCD_CMDS_T := ( 
                        0 => "00"&X"3C",			--Function Set
					    1 => "00"&X"0C",			--Display ON, Cursor OFF, Blink OFF
					    2 => "00"&X"01",			--Clear Display
					    3 => "00"&X"02", 			--return home

					    4 => "10"&X"53", 			--S  
					    5 => "10"&X"49",  			--I 
					    6 => "10"&X"44",  			--D
					    7 => "10"&X"45", 			--E 
					    8 => "10"&X"41", 			--A 
					    9 => "10"&X"54",  			--T
					    10 => "10"&X"26", 			--&
					    11 => "10"&X"54", 			--T
					    12 => "10"&X"75", 			--u
					    13 => "10"&X"72", 			--r
						14 => "10"&X"6E",			--n
						
                        15 => "00"&X"18");            --Shift left
	constant LCD_CMDS_03 : LCD_CMDS_T := ( 
                        0 => "00"&X"3C",			--Function Set
					    1 => "00"&X"0C",			--Display ON, Cursor OFF, Blink OFF
					    2 => "00"&X"01",			--Clear Display
					    3 => "00"&X"02", 			--return home

					    4 => "10"&X"53", 			--S  
					    5 => "10"&X"49",  			--I 
					    6 => "10"&X"44",  			--D 
					    7 => "10"&X"45", 			--E 
					    8 => "10"&X"42", 			--B 
					    9 => "10"&X"54",  			--T 
					    10 => "10"&X"26", 			--&
					    11 => "10"&X"54", 			--T
					    12 => "10"&X"75", 			--u
					    13 => "10"&X"72", 			--r
						14 => "10"&X"6E",				--n
						
                        15 => "00"&X"18");            --Shift left
	constant LCD_CMDS_04 : LCD_CMDS_T := ( 
                        0 => "00"&X"3C",			--Function Set
					    1 => "00"&X"0C",			--Display ON, Cursor OFF, Blink OFF
					    2 => "00"&X"01",			--Clear Display
					    3 => "00"&X"02", 			--return home

					    4 => "10"&X"53", 			--S  
					    5 => "10"&X"49",  			--I 
					    6 => "10"&X"44",  			--D 
					    7 => "10"&X"45", 			--E 
					    8 => "10"&X"42", 			--B 
					    9 => "10"&X"20", 			--blank 
					    10 => "10"&X"54", 			--T 
					    11 => "10"&X"75", 			--u 
						12 => "10"&X"72",			--r 
                        13 => "10"&X"6E",           --n 
                        14 => "10"&X"20",           --blank
						
                        15 => "00"&X"18");            --Shift left
	constant LCD_CMDS_05 : LCD_CMDS_T := ( 
                        0 => "00"&X"3C",			--Function Set
					    1 => "00"&X"0C",			--Display ON, Cursor OFF, Blink OFF
					    2 => "00"&X"01",			--Clear Display
					    3 => "00"&X"02", 			--return home

					    4 => "10"&X"53",             --S  
					    5 => "10"&X"49",             --I 
					    6 => "10"&X"44",             --D 
					    7 => "10"&X"45",             --E 
					    8 => "10"&X"20",            --blank 
					    9 => "10"&X"20",            --blank
					    10 => "10"&X"43",           --C
					    11 => "10"&X"20",           --blank
					    12 => "10"&X"54",           --T
					    13 => "10"&X"20",           --blank
					    14 => "10"&X"20",          --blank
					    
						
                        15 => "00"&X"18");            --Shift left
					    
	constant LCD_CMDS_06 : LCD_CMDS_T := ( 
                        0 => "00"&X"3C",			--Function Set
                        1 => "00"&X"0C",            --Display ON, Cursor OFF, Blink OFF
                        2 => "00"&X"01",            --Clear Display
                        3 => "00"&X"02",             --return home

                        4 => "10"&X"52",             --R 
                        5 => "10"&X"45",             --E
                        6 => "10"&X"53",             --S 
                        7 => "10"&X"45",             --E 
					    8 => "10"&X"54",             --T 
                        9 => "10"&X"20",            --blank
                        10 => "10"&X"20",           --blank
                        11 => "10"&X"20",           --blank
                        12 => "10"&X"20",           --blank
                        13 => "10"&X"20",           --blank
                        14 => "10"&X"20" ,          --blank
                                            
                        15 => "00"&X"18");            --Shift left
												
signal lcd_cmd_ptr : integer range 0 to LCD_CMDS'HIGH + 1 := 0;
	
begin

    process(Current_state)
    begin
        case Current_state is 
            when "0001" | "0010" =>     
                    LCD_CMDS <= LCD_CMDS_01;
            when "0011" | "0100" =>
                    LCD_CMDS <= LCD_CMDS_02;
            when "0101" | "0110" =>     
                    LCD_CMDS <= LCD_CMDS_04;
            when "0111" | "1000" => 
                    LCD_CMDS <= LCD_CMDS_03;
            when "1001" | "1010" =>     
                    LCD_CMDS <= LCD_CMDS_05;
            when others =>        
                    LCD_CMDS <= LCD_CMDS_06;                     
        end case;
    end process;


	--This process counts to 100, and then resets.  It is used to divide the clock signal.
	--This makes oneUSClock peak aprox. once every 1microsecond
	process (CLK)
    	begin
		if (CLK = '1' and CLK'event) then
			--if(clkCount = "1100100") then	--100  
			if(clkCount = "11001") then	--25
				clkCount <= "0000000";
				oneUSClk <= not oneUSClk;
			else 
				clkCount <= clkCount + 1;
			end if;
		end if;
	end process;
	
	--This process increments the count variable unless delayOK = 1.
	process (oneUSClk, delayOK)
		begin
			if (oneUSClk = '1' and oneUSClk'event) then
				if delayOK = '1' then
					count <= "000000000000000000000";
				else
					count <= count + 1;
				end if;
			end if;
		end process;

	--Determines when count has gotten to the right number, depending on the state.
	delayOK <= '1' when 		((stCur = stPowerOn_Delay and count = "111101000010010000000") or 					--2000000	 	-> 20 ms  
								(stCur = stFunctionSet_Delay and count = "000000000111110100000") or				--4000 			-> 40 us
								(stCur = stDisplayCtrlSet_Delay and count = "000000000111110100000") or			--4000 			-> 40 us
								(stCur = stDisplayClear_Delay and count = "000100111000100000000") or			--160000 		-> 1.6 ms
								(stCur = stCharDelay and count = "000111111011110100000"))							--260000			-> 2.6 ms - Max Delay for character writes and shifts
					else '0';

	--writeDone goes high when all commands have been run
	writeDone <= '1' when (lcd_cmd_ptr = LCD_CMDS'HIGH) 
					else '0';
		
	--Increments the pointer so the statemachine goes through the commands
	process (lcd_cmd_ptr, oneUSClk)
   		begin
			if (oneUSClk = '1' and oneUSClk'event) then
				if ((stNext = stInitDne or stNext = stDisplayCtrlSet or stNext = stDisplayClear) and writeDone = '0') then 
					lcd_cmd_ptr <= lcd_cmd_ptr + 1;
				elsif stCur = stPowerOn_Delay or stNext = stPowerOn_Delay then
					lcd_cmd_ptr <= 0;
				else
					lcd_cmd_ptr <= lcd_cmd_ptr;
				end if;
			end if;
		end process;
	
	--This process runs the LCD state machine
	process (oneUSClk, btnC)
        begin
            if oneUSClk = '1' and oneUSClk'Event then
                if btnC = '1' then
                    stCur <= stPowerOn_Delay;
                else
                    stCur <= stNext;
                end if;
            end if;
        end process;

	
	--This process generates the sequence of outputs needed to initialize and write to the LCD screen
	process (stCur, delayOK, writeDone, lcd_cmd_ptr)
		begin   
			case stCur is
				--Delays the state machine for 20ms which is needed for proper startup.
				when stPowerOn_Delay =>
					if delayOK = '1' then
						stNext <= stFunctionSet;
					else
						stNext <= stPowerOn_Delay;
					end if;
					
				--This issues the function set to the LCD as follows 
				--8 bit data length, 1 lines, font is 5x8.
				when stFunctionSet =>
					stNext <= stFunctionSet_Delay;
				
				--Gives the proper delay of 37us between the function set and
				--the display control set.
				when stFunctionSet_Delay =>
					if delayOK = '1' then
						stNext <= stDisplayCtrlSet;
					else
						stNext <= stFunctionSet_Delay;
					end if;
				
				--Issuse the display control set as follows
				--Display ON,  Cursor OFF, Blinking Cursor OFF.
				when stDisplayCtrlSet =>
					stNext <= stDisplayCtrlSet_Delay;

				--Gives the proper delay of 37us between the display control set
				--and the Display Clear command. 
				when stDisplayCtrlSet_Delay =>
					if delayOK = '1' then
						stNext <= stDisplayClear;
					else
						stNext <= stDisplayCtrlSet_Delay;
					end if;
				
				--Issues the display clear command.
				when stDisplayClear	=>
					stNext <= stDisplayClear_Delay;

				--Gives the proper delay of 1.52ms between the clear command
				--and the state where you are clear to do normal operations.
				when stDisplayClear_Delay =>
					if delayOK = '1' then
						stNext <= stInitDne;
					else
						stNext <= stDisplayClear_Delay;
					end if;
				
				--State for normal operations for displaying characters, changing the
				--Cursor position etc.
				when stInitDne =>		
					stNext <= stActWr;

				when stActWr =>		
					stNext <= stCharDelay;
					
				--Provides a max delay between instructions.
				when stCharDelay =>
					if delayOK = '1' then
						stNext <= stInitDne;
					else
						stNext <= stCharDelay;
					end if;
			end case;	
		end process;					
	
		JC(4) <= LCD_CMDS(lcd_cmd_ptr)(9);
		JC(5) <= LCD_CMDS(lcd_cmd_ptr)(8);
		JB <= LCD_CMDS(lcd_cmd_ptr)(7 downto 0);
		JC(6) <= '1' when stCur = stFunctionSet or stCur = stDisplayCtrlSet or stCur = stDisplayClear or stCur = stActWr
				else '0';	
						
end Behavioral;