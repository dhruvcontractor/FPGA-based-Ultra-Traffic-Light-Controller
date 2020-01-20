library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity Clockdiv is port ( 
    clk         : in std_logic;--set
    sclk        : out std_logic);--set
end Clockdiv;
architecture Behavioral of Clockdiv is
    signal cntr         : std_logic_vector(31 downto 0):= X"00000000";   
begin

    process (clk)
    begin
        if clk = '1' and clk'Event then
            cntr <= cntr + X"0000001"; -- incrementing the counter
            
            if (cntr >= X"02FAF080") then --02FAF080 for 100Mhz
                cntr <= X"00000000";
                
            end if;
        end if;
    end process;
    sclk <= '0' when cntr < X"0000001" else '1';
    -- result in 1Hz
   

end Behavioral;
