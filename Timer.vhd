library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity timer is
port(    sclk           : in std_logic;
         Tinout            : in std_logic_vector(1 downto 0);
            SW              : in std_logic;
          ST            : out std_logic:='1';
         anode           : out std_logic_vector(3 downto 0);
         segment_out          : out  STD_LOGIC_VECTOR (6 downto 0));
    
 
end timer;
architecture Behavioral of timer is
    signal count     : std_logic_vector(7 downto 0) := X"00";
    signal sec2     : STD_LOGIC_VECTOR (7 downto 0):=X"09";
    signal sec8   : STD_LOGIC_VECTOR (7 downto 0):=X"15";
    signal delay  : std_logic_vector (7 downto 0):=X"15";  
    component Display7seg is
        Port (
               Input  : in  STD_LOGIC_VECTOR (3 downto 0);
               anode    : out std_logic_vector(3 downto 0);
               segment_out   : out  STD_LOGIC_VECTOR (6 downto 0));
    end component;
begin
C1: Display7seg port map (Input=>delay(3 downto 0), anode=>anode, segment_out=>segment_out );
-- Timer will display the highest clock pulse
begin
if(SW='1') then
    delay <= sec8;
else
    delay <= count;
end if;
end process;
    process(sclk , Tinout) begin
        if (sclk = '1' and sclk'event) and Tinout (0) = '1' then
				ST <= '0';
				count <= count + 1;
            if ((Tinout = "01") and (count = sec2)) then    --Short Timer
                count <= X"00";
                ST <= '1';
            elsif ((Tinout = "11") and (count = sec8)) then --Long Timer
                count <= X"00";
                ST <= '1';
            elsif (count >sec8) then
                count <= X"00";
            end if;
            end if;
    end process;
end Behavioral;
    
    