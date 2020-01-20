library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Top is port( 
    mclk , S_BW , S_BE , S_C        : in std_logic;-- Sensor and Clock input
    JA                              : inout std_logic_vector (7 downto 0);
    SW                             : in std_logic;
    btnC                            : in std_logic; -- Reset
    Tinout                        : out std_logic_vector(1 downto 0);
    ST                        : out std_logic;
    vs, hs                          : out std_logic;
    red, grn, blu                   : out std_logic;
    led_S_BW, led_S_BE , led_S_C    : out std_logic;
    anode                           : out std_logic_vector(3 downto 0);
    segment_out                         : out std_logic_vector(6 downto 0);
    JB                              : out std_logic_vector(7 downto 0);
    JC                              : out std_logic_vector (6 downto 4));
end entity;
 

architecture Behaviour of Top is
-- Finite State machine of Traffic Light Controller
    component FSM  port ( 
        clk , S_BW , S_BE , S_C, ST       : in std_logic;--set
        ANorth , ANorth_Arrow, ASouth , ASouth_Arrow               : out std_logic_vector(2 downto 0);-- Side A Traffic Lights
        BWest , BWest_Arrow , BEast , BEast_Arrow , C           : out std_logic_vector(2 downto 0);--Side B and C Traffic Lights
        led_S_BW, led_S_BE , led_S_C        : out std_logic;
        Tinout                                : out std_logic_vector(1 downto 0);
        Current_state                              : out std_logic_vector(3 downto 0));-- Current state 
     end component;
     
-- VGA Controller to display Traffic lights with blocks, Each block displays individual traffic lights.     
     component TheirVGA  port(     
        clk                        : in std_logic;--set
        ANorth , ANorth_Arrow , ASouth , ASouth_Arrow               : in std_logic_vector(2 downto 0);--Side A Traffic Lights
        BWest , BWest_Arrow , BEast , BEast_Arrow , C           : in std_logic_vector(2 downto 0);-- Side B and C Traffic Lights
        vs, hs                     : out std_logic;-- Horizontal sync, Vertical sync
        red, grn, blu              : out std_logic);-- Red, Green, Blue
     end component;
     
-- Clock Divider to slow down the clock
    component Clockdiv port ( 
        clk         : in std_logic;
        sclk        : out std_logic);
    end component;

-- Timer for 2s and 7s for separate states.    
 component Timer port ( 
         sclk           : in std_logic;--set
         Tinout            : in std_logic_vector(1 downto 0);
        SW                  : std_logic;
          ST            : out std_logic:='1';
         anode           : out std_logic_vector(3 downto 0);
         segment_out          : out  STD_LOGIC_VECTOR (6 downto 0));--set
    end component; 
    
    
-- PMODCLP Displays the current state
    component PmodCLP Port (
        btnC   : in std_logic;
        clk     : in std_logic;            --100 MHz clock input
        Current_state  : in std_logic_vector(3 downto 0);
        JB      : out std_logic_vector(7 downto 0);
        JC      : out std_logic_vector (6 downto 4));        
    end component;
    
--Temporarty Signals to connect all modules togather (To transfer data to this signal to allocate data to the corresponding module)
    signal ANorth1 , ANorth_Arrow1  , ASouth1 , ASouth_Arrow1           : std_logic_vector(2 downto 0);
    signal BWest1, BWest_Arrow1, BEast1, BEast_Arrow1, C1      : std_logic_vector(2 downto 0);
    signal sclk1, ST1                        : std_logic;
    signal Tinout1                               : std_logic_vector(1 downto 0);
    signal Current_state1                             : std_logic_vector(3 downto 0);
begin
    Tinout<=Tinout1;
    ST<=ST1;
-- Component connections
U1:         Clockdiv port map (
                               clk => mclk, 
                                sclk => sclk1 ); 

U2:         FSM port map (
                            clk => sclk1,
                            S_BW => S_BW,
                            S_BE => S_BE,
                            S_C => S_C,
                            ST => ST1,
                     ANorth => ANorth1, ANorth_Arrow => ANorth_Arrow1, ASouth => ASouth1, ASouth_Arrow => ASouth_Arrow1,
                     BWest => BWest1, BWest_Arrow => BWest_Arrow1, BEast => BEast1, BEast_Arrow => BEast_Arrow1,
                     C => C1, led_S_BW => led_S_BW, led_S_BE => led_S_BE, led_S_C => led_S_C,
                     Tinout => Tinout1, Current_state => Current_state1);
                     
U3:         Timer port map (
                             sclk => sclk1, Tinout => Tinout1,
                             SW => SW,ST => ST1,
                             anode => anode, segment_out => segment_out);
                                                        
U4:         TheirVGA port map (
                                clk => mclk,
                      ANorth => ANorth1, ANorth_Arrow => ANorth_Arrow1, ASouth => ASouth1, ASouth_Arrow => ASouth_Arrow1,
                      BWest => BWest1, BWest_Arrow => BWest_Arrow1, BEast => BEast1, BEast_Arrow => BEast_Arrow1,          
                      C => C1, vs => vs, hs => hs, red => red, grn => grn, blu => blu); 
                     
U5:         PmodCLP port map(
                                btnC => btnC, clk => mclk,
                                Current_state => Current_state1, JB => JB, JC => JC);        
     
end Behaviour;