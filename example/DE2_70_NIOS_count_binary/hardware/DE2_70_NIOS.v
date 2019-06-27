module DE2_70_NIOS (
  input         iCLK_28,        // 28.63636 MHz
  input         iCLK_50,        // 50 MHz
  input         iCLK_50_2,      // 50 MHz
  input         iCLK_50_3,      // 50 MHz
  input         iCLK_50_4,      // 50 MHz
  input         iEXT_CLOCK,     // External Clock
  ////////////////////////////// Push Button ////////////////////////
  input  [3:0]  iKEY,           // Pushbutton[3:0]
  ////////////////////////////// DPDT Switch ////////////////////////
  input  [17:0] iSW,            // Toggle Switch[17:0]
  ////////////////////////////// 7-SEG Dispaly  ////////////////////////
  output [6:0]  oHEX0_D,        // Seven Segment Digit 0
  output        oHEX0_DP,       // Seven Segment Digit 0 decimal point
  output [6:0]  oHEX1_D,        // Seven Segment Digit 1
  output        oHEX1_DP,       // Seven Segment Digit 1 decimal point
  output [6:0]  oHEX2_D,        // Seven Segment Digit 2
  output        oHEX2_DP,       // Seven Segment Digit 2 decimal point
  output [6:0]  oHEX3_D,        // Seven Segment Digit 3
  output        oHEX3_DP,       // Seven Segment Digit 3 decimal point
  output [6:0]  oHEX4_D,        // Seven Segment Digit 4
  output        oHEX4_DP,       // Seven Segment Digit 4 decimal point
  output [6:0]  oHEX5_D,        // Seven Segment Digit 5
  output        oHEX5_DP,       // Seven Segment Digit 5 decimal point
  output [6:0]  oHEX6_D,        // Seven Segment Digit 6
  output        oHEX6_DP,       // Seven Segment Digit 6 decimal point
  output [6:0]  oHEX7_D,        // Seven Segment Digit 7
  output        oHEX7_DP,       // Seven Segment Digit 7 decimal point
  //////////////////////////////// LED ////////////////////////////
  output [8:0]  oLEDG,          // LED Green[8:0]
  output [17:0] oLEDR,          // LED Red[17:0]
  //////////////////////////////// UART ////////////////////////////
  output        oUART_TXD,      // UART Transmitter
  input         iUART_RXD,      // UART Receiver
  output        oUART_CTS,      // UART Clear To Send
  input         iUART_RTS,      // UART Requst To Send
  //////////////////////////////// IRDA ////////////////////////////
  output        oIRDA_TXD,      // IRDA Transmitter
  input         iIRDA_RXD,      // IRDA Receiver
  //////////////////////////////// SDRAM Interface ////////////////////////
  inout  [31:0] DRAM_DQ,        // SDRAM Data bus 32 Bits
  output [12:0] oDRAM0_A,       // SDRAM0 Address bus 12 Bits
  output [12:0] oDRAM1_A,       // SDRAM1 Address bus 12 Bits
  output        oDRAM0_LDQM0,   // SDRAM0 Low-byte Data Mask 
  output        oDRAM1_LDQM0,   // SDRAM1 Low-byte Data Mask 
  output        oDRAM0_UDQM1,   // SDRAM0 High-byte Data Mask
  output        oDRAM1_UDQM1,   // SDRAM1 High-byte Data Mask
  output        oDRAM0_WE_N,    // SDRAM0 Write Enable
  output        oDRAM1_WE_N,    // SDRAM1 Write Enable
  output        oDRAM0_CAS_N,   // SDRAM0 Column Address Strobe
  output        oDRAM1_CAS_N,   // SDRAM1 Column Address Strobe
  output        oDRAM0_RAS_N,   // SDRAM0 Row Address Strobe
  output        oDRAM1_RAS_N,   // SDRAM1 Row Address Strobe
  output        oDRAM0_CS_N,    // SDRAM0 Chip Select
  output        oDRAM1_CS_N,    // SDRAM1 Chip Select
  output [1:0]  oDRAM0_BA,      // SDRAM0 Bank Address
  output [1:0]  oDRAM1_BA,      // SDRAM1 Bank Address
  output        oDRAM0_CLK,     // SDRAM0 Clock
  output        oDRAM1_CLK,     // SDRAM0 Clock
  output        oDRAM0_CKE,     // SDRAM0 Clock Enable
  output        oDRAM1_CKE,     // SDRAM1 Clock Enable
  //////////////////////////////// Flash Interface ////////////////////////
  inout  [14:0] FLASH_DQ,       // FLASH Data bus 15 Bits (0 to 14)
  inout         FLASH_DQ15_AM1, // FLASH Data bus Bit 15 or Address A-1
  output [25:0] oFLASH_A,       // FLASH Address bus 26 Bits
  output        oFLASH_WE_N,    // FLASH Write Enable
  output        oFLASH_RST_N,   // FLASH Reset
  output        oFLASH_WP_N,    // FLASH Write Protect /Programming Acceleration 
  input         iFLASH_RY_N,    // FLASH Ready/Busy output 
  output        oFLASH_BYTE_N,  // FLASH Byte/Word Mode Configuration
  output        oFLASH_OE_N,    // FLASH Output Enable
  output        oFLASH_CE_N,    // FLASH Chip Enable
  //////////////////////////////// SRAM Interface ////////////////////////
  inout  [31:0] SRAM_DQ,        // SRAM Data Bus 32 Bits
  inout  [3:0]  SRAM_DPA,       // SRAM Parity Data Bus
  output [20:0] oSRAM_A,        // SRAM Address bus 21 Bits
  output        oSRAM_ADSC_N,   // RAM Controller Address Status 	
  output        oSRAM_ADSP_N,   // SRAM Processor Address Status
  output        oSRAM_ADV_N,    // SRAM Burst Address Advance
  output [3:0]  oSRAM_BE_N,     // SRAM Byte Write Enable
  output        oSRAM_CE1_N,    // SRAM Chip Enable
  output        oSRAM_CE2,      // SRAM Chip Enable
  output        oSRAM_CE3_N,    // SRAM Chip Enable
  output        oSRAM_CLK,      // SRAM Clock
  output        oSRAM_GW_N,     // SRAM Global Write Enable
  output        oSRAM_OE_N,     // SRAM Output Enable
  output        oSRAM_WE_N,     // SRAM Write Enable
  //////////////////////////////// ISP1362 Interface ////////////////////////
  inout  [15:0] OTG_D,          // ISP1362 Data bus 16 Bits
  output [1:0]  oOTG_A,         // ISP1362 Address 2 Bits
  output        oOTG_CS_N,      // ISP1362 Chip Select
  output        oOTG_OE_N,      // ISP1362 Read
  output        oOTG_WE_N,      // ISP1362 Write
  output        oOTG_RESET_N,   // ISP1362 Reset
  inout         OTG_FSPEED,     // USB Full Speed, 0 = Enable, Z = Disable
  inout         OTG_LSPEED,     // USB Low Speed, 	0 = Enable, Z = Disable
  input         iOTG_INT0,      // ISP1362 Interrupt 0
  input         iOTG_INT1,      // ISP1362 Interrupt 1
  input         iOTG_DREQ0,     // ISP1362 DMA Request 0
  input         iOTG_DREQ1,     // ISP1362 DMA Request 1
  output        oOTG_DACK0_N,   // ISP1362 DMA Acknowledge 0
  output        oOTG_DACK1_N,   // ISP1362 DMA Acknowledge 1
  //////////////////////////////// LCD Module 16X2 ////////////////////////////
  inout  [7:0]  LCD_D,          // LCD Data bus 8 bits
  output        oLCD_ON,        // LCD Power ON/OFF
  output        oLCD_BLON,      // LCD Back Light ON/OFF
  output        oLCD_RW,        // LCD Read/Write Select, 0 = Write, 1 = Read
  output        oLCD_EN,        // LCD Enable
  output        oLCD_RS,        // LCD Command/Data Select, 0 = Command, 1 = Data
  //////////////////////////////// SD Card Interface ////////////////////////
  inout         SD_DAT,         // SD Card Data
  inout         SD_DAT3,        // SD Card Data 3
  inout         SD_CMD,         // SD Card Command Signal
  output        oSD_CLK,        // SD Card Clock
  //////////////////////////////// I2C ////////////////////////////////
  inout         I2C_SDAT,       // I2C Data
  output        oI2C_SCLK,      // I2C Clock
  //////////////////////////////// PS2 ////////////////////////////
  inout         PS2_KBDAT,      // PS2 Keyboard Data
  inout         PS2_KBCLK,      // PS2 Keyboard Clock
  inout         PS2_MSDAT,      // PS2 Mouse Data
  inout         PS2_MSCLK,      // PS2 Mouse Clock
  //////////////////////////////// VGA ////////////////////////////
  output        oVGA_CLOCK,     // VGA Clock
  output        oVGA_HS,        // VGA H_SYNC
  output        oVGA_VS,        // VGA V_SYNC
  output        oVGA_BLANK_N,   // VGA BLANK
  output        oVGA_SYNC_N,    // VGA SYNC
  output [9:0]  oVGA_R,         // VGA Red[9:0]
  output [9:0]  oVGA_G,         // VGA Green[9:0]
  output [9:0]  oVGA_B,         // VGA Blue[9:0]
  //////////////////////////////// Ethernet Interface ////////////////////////////
  inout  [15:0] ENET_D,         // DM9000A DATA bus 16Bits
  output        oENET_CMD,      // DM9000A Command/Data Select, 0 = Command, 1 = Data
  output        oENET_CS_N,     // DM9000A Chip Select
  output        oENET_IOW_N,    // DM9000A Write
  output        oENET_IOR_N,    // DM9000A Read
  output        oENET_RESET_N,  // DM9000A Reset
  input         iENET_INT,      // DM9000A Interrupt
  output        oENET_CLK,      // DM9000A Clock 25 MHz
  //////////////////////////////// Audio CODEC ////////////////////////////
  inout         AUD_ADCLRCK,    // Audio CODEC ADC LR Clock
  input         iAUD_ADCDAT,    // Audio CODEC ADC Data
  inout         AUD_DACLRCK,    // Audio CODEC DAC LR Clock
  output        oAUD_DACDAT,    // Audio CODEC DAC Data
  inout         AUD_BCLK,       // Audio CODEC Bit-Stream Clock
  output        oAUD_XCK,       // Audio CODEC Chip Clock
  //////////////////////////////// TV Devoder ////////////////////////////
  input         iTD1_CLK27,     // TV Decoder1 Line_Lock Output Clock 
  input  [7:0]  iTD1_D,         // TV Decoder1 Data bus 8 bits
  input         iTD1_HS,        // TV Decoder1 H_SYNC
  input         iTD1_VS,        // TV Decoder1 V_SYNC
  output        oTD1_RESET_N,   // TV Decoder1 Reset
  input         iTD2_CLK27,     // TV Decoder2 Line_Lock Output Clock 		
  input  [7:0]  iTD2_D,         // TV Decoder2 Data bus 8 bits
  input         iTD2_HS,        // TV Decoder2 H_SYNC
  input         iTD2_VS,        // TV Decoder2 V_SYNC
  output        oTD2_RESET_N,   // TV Decoder2 Reset
  //////////////////////////////// GPIO ////////////////////////////////
  inout  [31:0] GPIO_0,         // GPIO Connection 0 I/O
  input         GPIO_CLKIN_N0,  // GPIO Connection 0 Clock Input 0
  input         GPIO_CLKIN_P0,  // GPIO Connection 0 Clock Input 1
  output        GPIO_CLKOUT_N0, // GPIO Connection 0 Clock Output 0
  output        GPIO_CLKOUT_P0, // GPIO Connection 0 Clock Output 1
  inout  [31:0] GPIO_1,         // GPIO Connection 1 I/O
  input         GPIO_CLKIN_N1,  // GPIO Connection 1 Clock Input 0
  input         GPIO_CLKIN_P1,  // GPIO Connection 1 Clock Input 1
  output        GPIO_CLKOUT_N1, // GPIO Connection 1 Clock Output 0
  output        GPIO_CLKOUT_P1  // PIO Connection 1 Clock Output 1
);

// 16*2 LCD Module
assign oLCD_ON   = 1'b1; // LCD ON
assign oLCD_BLON = 1'b1; // LCD Back Light

// SDRAM
// the sdram is shahred with rtl and nios
assign oDRAM1_CLK = oDRAM0_CLK;

// NIOS II system
nios_ii nios_ii0 (
  // 1) global signals:
  .clk_50(iCLK_50),
  .pll_c0_system(CPU_CLK),
  .pll_c1_memory(oDRAM0_CLK),
  .pll_c2_audio(oAUD_XCK),
  .reset_n(1'b1),
  // the_lcd
  .LCD_E_from_the_lcd(oLCD_EN),
  .LCD_RS_from_the_lcd(oLCD_RS),
  .LCD_RW_from_the_lcd(oLCD_RW),
  .LCD_data_to_and_from_the_lcd(LCD_D),
  // the_pio_button
  .in_port_to_the_pio_button(iKEY),
  // the_pio_green_led
  .out_port_from_the_pio_green_led(oLEDG),
  // the_pio_red_led
  .out_port_from_the_pio_red_led(oLEDR),
  // the_seg7  
  .avs_s1_export_seg7_from_the_SEG7({oHEX7_DP, oHEX7_D, oHEX6_DP, oHEX6_D, oHEX5_DP, 
    oHEX5_D, oHEX4_DP,oHEX4_D, oHEX3_DP, oHEX3_D, oHEX2_DP, oHEX2_D, oHEX1_DP, oHEX1_D,
    oHEX0_DP, oHEX0_D}),
  // the_sdram (u1)
  .zs_addr_from_the_sdram_u1(oDRAM0_A),
  .zs_ba_from_the_sdram_u1(oDRAM0_BA),
  .zs_cas_n_from_the_sdram_u1(oDRAM0_CAS_N),
  .zs_cke_from_the_sdram_u1(oDRAM0_CKE),
  .zs_cs_n_from_the_sdram_u1(oDRAM0_CS_N),
  .zs_dq_to_and_from_the_sdram_u1(DRAM_DQ[15:0]),
  .zs_dqm_from_the_sdram_u1({oDRAM0_UDQM1,oDRAM0_LDQM0}),
  .zs_ras_n_from_the_sdram_u1(oDRAM0_RAS_N),
  .zs_we_n_from_the_sdram_u1(oDRAM0_WE_N),
  // the_sdram (u2)
  .zs_addr_from_the_sdram_u2(oDRAM1_A),
  .zs_ba_from_the_sdram_u2(oDRAM1_BA),
  .zs_cas_n_from_the_sdram_u2(oDRAM1_CAS_N),
  .zs_cke_from_the_sdram_u2(oDRAM1_CKE),
  .zs_cs_n_from_the_sdram_u2(oDRAM1_CS_N),
  .zs_dq_to_and_from_the_sdram_u2(DRAM_DQ[31:16]),
  .zs_dqm_from_the_sdram_u2({oDRAM1_UDQM1,oDRAM1_LDQM0}),
  .zs_ras_n_from_the_sdram_u2(oDRAM1_RAS_N),
  .zs_we_n_from_the_sdram_u2(oDRAM1_WE_N)
);

endmodule
