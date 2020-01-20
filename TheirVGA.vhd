library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TheirVGA is

port(                                   clk                  : in std_logic; --100 Mhz clock
            ANorth , ANorth_Arrow , ASouth , ASouth_Arrow    : in std_logic_vector(2 downto 0);-- Side A Traffic Lights
            BWest , BWest_Arrow , BEast , BEast_Arrow , C    : in std_logic_vector(2 downto 0);-- Side B and C traffic Lights
                                  vs, hs                     : out std_logic; -- Vertical and Horizontal Sync
                                  red, grn, blu              : out std_logic);-- Red and Green and Blue

end TheirVGA;


architecture Behavioral of TheirVGA is

-- Signals that needs to used for Vertical and Horizontal sync
    signal clkPix       : std_logic;
    signal cntImg       : std_logic_vector(6 downto 0);
    signal cntColor     : std_logic_vector(2 downto 0);
    signal cntHorz, cntVert                     : std_logic_vector(9 downto 0);
    signal upper, left, lower, right            : std_logic_vector(11 downto 0);
    signal sncHorz, clkLine, blkHorz            : std_logic;
    signal sncVert, blkVert, blkDisp, clkColor  : std_logic;

begin


------------------------------------------------------------------------
    --          VGA Controller Test
	------------------------------------------------------------------------

    -- Divide the D2XL oscillator down to form the pixel clock
    -- that is the basis for all of the other timing.
    process (clk)
        begin
            if clk = '1' and clk'Event then
                clkPix <= not clkPix;
            end if;
        end process;
    -- Generate the horizontal timing.
    process (clkPix)
        begin
		  		
            if clkPix = '1' and clkPix'Event then
                if cntHorz = "0001011101" then
                    cntHorz <= cntHorz + 1;
                    sncHorz <= '1';
                elsif cntHorz = "0010001100" then
                    cntHorz <= cntHorz + 1;
                    blkHorz <= '0';
                elsif cntHorz = "1100001100" then
                    cntHorz <= cntHorz + 1;
                    blkHorz <= '1';
                elsif cntHorz = "1100011010" then
                    cntHorz <= "0000000000";
                    clkLine <= '1';
                    sncHorz <= '0';
                else
                    cntHorz <= cntHorz + 1;
                    clkLine <= '0';
                end if;
            end if;
        end process;

    -- Generate the vertical timing.
    process (clkLine)
        begin
		  		
            if clkLine = '1' and clkLine'Event then
                if cntVert = "0000000001" then
                    cntVert <= cntVert + 1;
                    sncVert <= '1';
                elsif cntVert = "0000011010" then
                    cntVert <= cntVert + 1;
                    blkVert <= '0';
                elsif cntVert = "0111111010" then
                    cntVert <= cntVert + 1;
                    blkVert <= '1';
                elsif cntVert = "1000001100" then
                    cntVert <= "0000000000";
                    sncVert <= '0';
			    left <= X"0A8";
                    right <= X"0E8";--NOTE: =168+64(in decimal)
                    lower <= X"09C";--NOTE: =92+64(in decimal)
                    upper <= X"05C";
                else
                    cntVert <= cntVert + 1;
                end if;
            end if;
        end process;
        
    process (clkPix, blkDisp)
        begin
            if clkPix = '1' and clkPix'Event then
                if blkDisp = '1' then
                    cntImg <= "0000000";
                else
                    if cntImg = "1001111" then
                        cntImg <= "0000000";
                        clkColor <= '1';
                    else
                        cntImg <= cntImg + 1;
                        clkColor <= '0';
                    end if;
                end if;
            end if;
        end process;
    
    blkDisp <= blkVert or blkHorz;

		
      cntColor  <=     ANorth when cntHorz < right  and  cntHorz > left and cntVert < lower  and cntVert > upper    else      
                    -- Distnace between Two blocks 120
                    ASouth when cntHorz < (right+X"078") and cntHorz > (left+X"078")  and cntVert < lower  and cntVert > upper        else
                    -- Same Distance between another block so 240
                    BWest when cntHorz < (right+X"0F0")    and cntHorz > (left+X"0F0")    and cntVert < lower  and cntVert > upper   else
                    -- Same Distance Between another Block so add 120+120+120=360
                    BEast when cntHorz < (right+X"168")    and cntHorz > (left+X"168")    and cntVert < lower  and cntVert > upper   else
                    -- Same Distance Between another Block so add 120+120+120+120=480.
                    ANorth_Arrow when cntHorz < right    and cntHorz > left  and cntVert < (lower+X"078")  and cntVert > (upper+X"078")   else 
                    --Increment lower and upper positions by 120 to display block on next raw.
                    ASouth_Arrow when cntHorz < (right+X"078")    and cntHorz > (left+X"078")    and cntVert < (lower+X"078") and cntVert > (upper+X"078")    else 
                    -- Distnace between Two blocks 120
                    BWest_Arrow when cntHorz < (right+X"0F0")    and cntHorz > (left+X"0F0")    and cntVert < (lower+X"078")    and cntVert > (upper+X"078")    else
                    -- Distnace between Two blocks 240
                    BEast_Arrow when cntHorz < (right+X"168")    and cntHorz > (left+X"168")    and cntVert < (lower+X"078")    and cntVert > (upper+X"078")    else
                    -- Same Distance Between another Block so add 120+120+120=360
                    C when cntHorz < (right+X"1CC")       and cntHorz > (left+X"1CC")    and cntVert < (lower+X"078")    and cntVert > (upper+X"078")  else      
                    "111"; 
               

    vs  <= sncVert;
    hs  <= sncHorz;
    blu <= cntColor(0) and ( not blkDisp);
    grn <= cntColor(1) and (not blkDisp);
    red <= cntColor(2) and (not blkDisp);
end Behavioral;
