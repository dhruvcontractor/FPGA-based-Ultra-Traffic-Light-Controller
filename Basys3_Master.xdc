## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
#Bank = 34, Pin name = ,					Sch name = CLK100MHZ
set_property PACKAGE_PIN W5 [get_ports mclk]
set_property IOSTANDARD LVCMOS33 [get_ports mclk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports mclk]


# Inputitches
set_property PACKAGE_PIN V17 [get_ports {S_BW}]
set_property IOSTANDARD LVCMOS33 [get_ports {S_BW}]
set_property PACKAGE_PIN V16 [get_ports {S_BE}]
set_property IOSTANDARD LVCMOS33 [get_ports {S_BE}]
set_property PACKAGE_PIN W16 [get_ports {S_C}]
set_property IOSTANDARD LVCMOS33 [get_ports {S_C}]
#set_property IOSTANDARD LVCMOS33 [get_ports {Tinout[0]}]
#set_property PACKAGE_PIN W15 [get_ports {Tinout[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {Tinout[1]}]
#set_property PACKAGE_PIN V15 [get_ports {Tinout[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {Input[2]}]
#set_property PACKAGE_PIN W14 [get_ports {Input[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {Input[3]}]
#set_property PACKAGE_PIN W13 [get_ports {Input[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {Input[4]}]
#set_property PACKAGE_PIN V2 [get_ports {Input[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {Input[5]}]
#set_property PACKAGE_PIN T3 [get_ports {Input[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {Input[6]}]
#set_property PACKAGE_PIN T2 [get_ports {Input[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {Input[7]}]
#set_property PACKAGE_PIN R3 [get_ports {Input[11]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {Input[11]}]
#set_property PACKAGE_PIN W2 [get_ports {SW[12]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SW[12]}]
#set_property PACKAGE_PIN U1 [get_ports {Tinout[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {Tinout[0]}]
#set_property PACKAGE_PIN T1 [get_ports {Tinout[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {Tinout[1]}]
set_property PACKAGE_PIN R2 [get_ports {SW}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW}]


# LEDs
 
set_property PACKAGE_PIN U16 [get_ports {led_S_BW}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_S_BW}]
set_property PACKAGE_PIN E19 [get_ports {led_S_BE}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_S_BE}]
set_property PACKAGE_PIN U19 [get_ports {led_S_C}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_S_C}]
#set_property PACKAGE_PIN V19 [get_ports {ANorth}]
#set_property IOSTANDARD LVCMOS33 [get_ports {ANorth}]
#set_property PACKAGE_PIN W18 [get_ports {ANouth_Arrow}]
#set_property IOSTANDARD LVCMOS33 [get_ports {ANorth_Arrow}]
#set_property PACKAGE_PIN U15 [get_ports {ASouth}]
#set_property IOSTANDARD LVCMOS33 [get_ports {ASouth}]
#set_property PACKAGE_PIN U14 [get_ports {ASouth_Arrow}]
#set_property IOSTANDARD LVCMOS33 [get_ports {ASouth_Arrow}]
#set_property PACKAGE_PIN V14 [get_ports {BWest}]
#set_property IOSTANDARD LVCMOS33 [get_ports {BWest}]
#set_property PACKAGE_PIN V13 [get_ports {BWest_Arrow}]
#set_property IOSTANDARD LVCMOS33 [get_ports {BWest_Arrow}]
#set_property PACKAGE_PIN V3 [get_ports {BEest}]
#set_property IOSTANDARD LVCMOS33 [get_ports {BEast}]
#set_property PACKAGE_PIN W3 [get_ports {BEest_Arrow}]
#set_property IOSTANDARD LVCMOS33 [get_ports {BEest_Arrow}]
#set_property PACKAGE_PIN U3 [get_ports {C}]
#set_property IOSTANDARD LVCMOS33 [get_ports {C}]
set_property PACKAGE_PIN P3 [get_ports {ST}]
set_property IOSTANDARD LVCMOS33 [get_ports {ST}]
#set_property PACKAGE_PIN N3 [get_ports {LED[13]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {LED[13]}]
set_property PACKAGE_PIN P1 [get_ports {Tinout[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Tinout[0]}]
set_property PACKAGE_PIN L1 [get_ports {Tinout[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Tinout[1]}]


#7 segment display
#Bank = 34, Pin name = ,						Sch name = CA
set_property PACKAGE_PIN W7 [get_ports {segment_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_out[0]}]
#Bank = 34, Pin name = ,					Sch name = CB
set_property PACKAGE_PIN W6 [get_ports {segment_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_out[1]}]
#Bank = 34, Pin name = ,					Sch name = CC
set_property PACKAGE_PIN U8 [get_ports {segment_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_out[2]}]
#Bank = 34, Pin name = ,						Sch name = CD
set_property PACKAGE_PIN V8 [get_ports {segment_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_out[3]}]
#Bank = 34, Pin name = ,						Sch name = CE
set_property PACKAGE_PIN U5 [get_ports {segment_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_out[4]}]
#Bank = 34, Pin name = ,						Sch name = CF
set_property PACKAGE_PIN V5 [get_ports {segment_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_out[5]}]
#Bank = 34, Pin name = ,						Sch name = CG
set_property PACKAGE_PIN U7 [get_ports {segment_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_out[6]}]

##Bank = 34, Pin name = ,						Sch name = DP
#set_property PACKAGE_PIN V7 [get_ports {segOut[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {segOut[7]}]

#Bank = 34, Pin name = ,						Sch name = AN0
set_property PACKAGE_PIN U2 [get_ports {anode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[0]}]
#Bank = 34, Pin name = ,						Sch name = AN1
set_property PACKAGE_PIN U4 [get_ports {anode[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[1]}]
#Bank = 34, Pin name = ,						Sch name = AN2
set_property PACKAGE_PIN V4 [get_ports {anode[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[2]}]
#Bank = 34, Pin name = ,					Sch name = AN3
set_property PACKAGE_PIN W4 [get_ports {anode[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {anode[3]}]


##Buttons
set_property PACKAGE_PIN U18 [get_ports btnC]						
	set_property IOSTANDARD LVCMOS33 [get_ports btnC]
#set_property PACKAGE_PIN T18 [get_ports btnU]						
	#set_property IOSTANDARD LVCMOS33 [get_ports btnU]
#set_property PACKAGE_PIN W19 [get_ports btnL]						
	#set_property IOSTANDARD LVCMOS33 [get_ports btnL]
#set_property PACKAGE_PIN T17 [get_ports btnR]						
	#set_property IOSTANDARD LVCMOS33 [get_ports btnR]
#set_property PACKAGE_PIN U17 [get_ports btnD]						
	#set_property IOSTANDARD LVCMOS33 [get_ports btnD]



#Pmod Header JA
#Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {JA[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {JA[0]}]
#Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {JA[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {JA[1]}]
#Sch name = JA3
set_property PACKAGE_PIN J2 [get_ports {JA[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {JA[2]}]
#Sch name = JA4
set_property PACKAGE_PIN G2 [get_ports {JA[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {JA[3]}]
#Sch name = JA7
set_property PACKAGE_PIN H1 [get_ports {JA[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {JA[4]}]
#Sch name = JA8
set_property PACKAGE_PIN K2 [get_ports {JA[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {JA[5]}]
#Sch name = JA9
set_property PACKAGE_PIN H2 [get_ports {JA[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {JA[6]}]
#Sch name = JA10
set_property PACKAGE_PIN G3 [get_ports {JA[7]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {JA[7]}]




#Pmod Header JB
#Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports {JB[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {JB[0]}]
#Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports {JB[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {JB[1]}]
#Sch name = JB3
set_property PACKAGE_PIN B15 [get_ports {JB[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {JB[2]}]
#Sch name = JB4
set_property PACKAGE_PIN B16 [get_ports {JB[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {JB[3]}]
#Sch name = JB7
set_property PACKAGE_PIN A15 [get_ports {JB[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {JB[4]}]
#Sch name = JB8
set_property PACKAGE_PIN A17 [get_ports {JB[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {JB[5]}]
#Sch name = JB9
set_property PACKAGE_PIN C15 [get_ports {JB[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {JB[6]}]
#Sch name = JB10 
set_property PACKAGE_PIN C16 [get_ports {JB[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {JB[7]}]
 


##Pmod Header JC
##Sch name = JC1
#set_property PACKAGE_PIN K17 [get_ports {JC[0]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[0]}]
##Sch name = JC2
#set_property PACKAGE_PIN M18 [get_ports {JC[1]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[1]}]
##Sch name = JC3
#set_property PACKAGE_PIN N17 [get_ports {JC[2]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[2]}]
##Sch name = JC4
#set_property PACKAGE_PIN P18 [get_ports {JC[3]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[3]}]
#Sch name = JC7
set_property PACKAGE_PIN L17 [get_ports {JC[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {JC[4]}]
#Sch name = JC8
set_property PACKAGE_PIN M19 [get_ports {JC[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {JC[5]}]
#Sch name = JC9
set_property PACKAGE_PIN P17 [get_ports {JC[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {JC[6]}]
##Sch name = JC10
#set_property PACKAGE_PIN R18 [get_ports {JC[7]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {JC[7]}]


##Pmod Header JXADC
##Bank = 15, Pin name = IO_L9P_T1_DQS_AD3P_15,				Sch name = XADC1_P -> XA1_P
#set_property PACKAGE_PIN A13 [get_ports {JXADC[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[0]}]
##Bank = 15, Pin name = IO_L8P_T1_AD10P_15,					Sch name = XADC2_P -> XA2_P
#set_property PACKAGE_PIN A15 [get_ports {JXADC[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[1]}]
##Bank = 15, Pin name = IO_L7P_T1_AD2P_15,					Sch name = XADC3_P -> XA3_P
#set_property PACKAGE_PIN B16 [get_ports {JXADC[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[2]}]
##Bank = 15, Pin name = IO_L10P_T1_AD11P_15,					Sch name = XADC4_P -> XA4_P
#set_property PACKAGE_PIN B18 [get_ports {JXADC[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[3]}]
##Bank = 15, Pin name = IO_L9N_T1_DQS_AD3N_15,				Sch name = XADC1_N -> XA1_N
#set_property PACKAGE_PIN A14 [get_ports {JXADC[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[4]}]
##Bank = 15, Pin name = IO_L8N_T1_AD10N_15,					Sch name = XADC2_N -> XA2_N
#set_property PACKAGE_PIN A16 [get_ports {JXADC[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[5]}]
##Bank = 15, Pin name = IO_L7N_T1_AD2N_15,					Sch name = XADC3_N -> XA3_N
#set_property PACKAGE_PIN B17 [get_ports {JXADC[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[6]}]
##Bank = 15, Pin name = IO_L10N_T1_AD11N_15,					Sch name = XADC4_N -> XA4_N
#set_property PACKAGE_PIN A18 [get_ports {JXADC[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[7]}]



#VGA Connector
#Bank = 14, Pin name = ,					Sch name = VGA_R0
set_property PACKAGE_PIN G19 [get_ports red]
set_property IOSTANDARD LVCMOS33 [get_ports red]
#Bank = 14, Pin name = ,					Sch name = VGA_R1
set_property PACKAGE_PIN H19 [get_ports red]
set_property IOSTANDARD LVCMOS33 [get_ports red]
#Bank = 14, Pin name = ,					Sch name = VGA_R2
set_property PACKAGE_PIN J19 [get_ports red]
set_property IOSTANDARD LVCMOS33 [get_ports red]
#Bank = 14, Pin name = ,					Sch name = VGA_R3
set_property PACKAGE_PIN N19 [get_ports red]
set_property IOSTANDARD LVCMOS33 [get_ports red]
#Bank = 14, Pin name = ,					Sch name = VGA_B0
set_property PACKAGE_PIN N18 [get_ports blu]
set_property IOSTANDARD LVCMOS33 [get_ports blu]
#Bank = 14, Pin name = ,						Sch name = VGA_B1
set_property PACKAGE_PIN L18 [get_ports blu]
set_property IOSTANDARD LVCMOS33 [get_ports blu]
#Bank = 14, Pin name = ,					Sch name = VGA_B2
set_property PACKAGE_PIN K18 [get_ports blu]
set_property IOSTANDARD LVCMOS33 [get_ports blu]
#Bank = 14, Pin name = ,						Sch name = VGA_B3
set_property PACKAGE_PIN J18 [get_ports blu]
set_property IOSTANDARD LVCMOS33 [get_ports blu]
#Bank = 14, Pin name = ,					Sch name = VGA_G0
set_property PACKAGE_PIN J17 [get_ports grn]
set_property IOSTANDARD LVCMOS33 [get_ports grn]
#Bank = 14, Pin name = ,				Sch name = VGA_G1
set_property PACKAGE_PIN H17 [get_ports grn]
set_property IOSTANDARD LVCMOS33 [get_ports grn]
#Bank = 14, Pin name = ,					Sch name = VGA_G2
set_property PACKAGE_PIN G17 [get_ports grn]
set_property IOSTANDARD LVCMOS33 [get_ports grn]
#Bank = 14, Pin name = ,				Sch name = VGA_G3
set_property PACKAGE_PIN D17 [get_ports grn]
set_property IOSTANDARD LVCMOS33 [get_ports grn]
#Bank = 14, Pin name = ,						Sch name = VGA_HS
set_property PACKAGE_PIN P19 [get_ports hs]
set_property IOSTANDARD LVCMOS33 [get_ports hs]
#Bank = 14, Pin name = ,				Sch name = VGA_VS
set_property PACKAGE_PIN R19 [get_ports vs]
set_property IOSTANDARD LVCMOS33 [get_ports vs]


##USB-RS232 Interface
##Bank = 16, Pin name = ,					Sch name = UART_TXD_IN
#set_property PACKAGE_PIN B18 [get_ports RsRx]
#set_property IOSTANDARD LVCMOS33 [get_ports RsRx]
#Bank = 16, Pin name = ,					Sch name = UART_RXD_OUT
#set_property PACKAGE_PIN A18 [get_ports UART_TXD]
#set_property IOSTANDARD LVCMOS33 [get_ports UART_TXD]



#USB HID (PS/2)
#Bank = 16, Pin name = ,					Sch name = PS2_CLK
#set_property PACKAGE_PIN C17 [get_ports PS2_CLK]
#set_property IOSTANDARD LVCMOS33 [get_ports PS2_CLK]
#set_property PULLUP true [get_ports PS2_CLK]
#Bank = 16, Pin name = ,					Sch name = PS2_DATA
#set_property PACKAGE_PIN B17 [get_ports PS2_DATA]
#set_property IOSTANDARD LVCMOS33 [get_ports PS2_DATA]
#set_property PULLUP true [get_ports PS2_DATA]



##Quad SPI Flash
##Bank = CONFIG, Pin name = CCLK_0,							Sch name = QSPI_SCK
#set_property PACKAGE_PIN C11 [get_ports {QspiSCK}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiSCK}]
##Bank = CONFIG, Pin name = IO_L1P_T0_D00_MOSI_14,			Sch name = QSPI_DQ0
#set_property PACKAGE_PIN D18 [get_ports {QspiDB[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[0]}]
##Bank = CONFIG, Pin name = IO_L1N_T0_D01_DIN_14,			Sch name = QSPI_DQ1
#set_property PACKAGE_PIN D19 [get_ports {QspiDB[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[1]}]
##Bank = CONFIG, Pin name = IO_L20_T0_D02_14,				Sch name = QSPI_DQ2
#set_property PACKAGE_PIN G18 [get_ports {QspiDB[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[2]}]
##Bank = CONFIG, Pin name = IO_L2P_T0_D03_14,				Sch name = QSPI_DQ3
#set_property PACKAGE_PIN F18 [get_ports {QspiDB[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[3]}]
##Bank = CONFIG, Pin name = IO_L6P_T0_FCS_B_14,	Sch name = QSPI_CS
#set_property PACKAGE_PIN K19 [get_ports QspiCSn]
#set_property IOSTANDARD LVCMOS33 [get_ports QspiCSn]



set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]







