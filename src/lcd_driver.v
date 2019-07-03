//http://blog.chinaaet.com/zzuxzt/p/35557
//https://wenku.baidu.com/view/aa2943abd1f34693daef3ecc.html
module lcd_driver(
  input CLOCK_50,    //    50 MHz clock
  input [17:0] SW,    //    Toggle Switch[17:0]
  input  K0_clk,     //Control Display 
  output LCD_ON,    // LCD Power ON/OFF
  output LCD_BLON,    // LCD Back Light ON/OFF
  output LCD_RW,    // LCD Read/Write Select, 0 = Write, 1 = Read
  output LCD_EN,    // LCD Enable
  output LCD_RS,    // LCD Command/Data Select, 0 = Command, 1 = Data
  inout [7:0] LCD_DATA    // LCD Data bus 8 bits
);

// reset delay gives some time for peripherals to initialize
wire DLY_RST;
Reset_Delay r0(    .iCLK(CLOCK_50),.oRESET(DLY_RST) );

// turn LCD ON
assign    LCD_ON        =    1'b1;
assign    LCD_BLON    =    1'b1;
//Store SW
wire [3:0] hex3,hex2,hex1,hex0;
assign hex3 = SW[17:14];
assign hex2 = SW[13:10];
assign hex1 = SW[7:4];
assign hex0 = SW[3:0];

    
LCD_Display u1(

   .iCLK_50MHZ(CLOCK_50),
   .iRST_N(DLY_RST),
   .K0_clk(K0_clk),
   .hex0(hex0),
   .hex1(hex1),
   .hex2(hex2),
   .hex3(hex3),

   .DATA_BUS(LCD_DATA),
   .LCD_RW(LCD_RW),
   .LCD_E(LCD_EN),
   .LCD_RS(LCD_RS)
);
endmodule


//LCD_Display.v

/*
------------------------------------------------------------------- 
--                        ASCII HEX TABLE
--  Hex                        Low Hex Digit
-- Value  0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
------\----------------------------------------------------------------
--H  2 |  SP  !   "   #   $   %   &   '   (   )   *   +   ,   -   .   /
--i  3 |  0   1   2   3   4   5   6   7   8   9   :   ;   <   =   >   ?
--g  4 |  @   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O
--h  5 |  P   Q   R   S   T   U   V   W   X   Y   Z   [   \   ]   ^   _
--   6 |  `   a   b   c   d   e   f   g   h   i   j   k   l   m   n   o
--   7 |  p   q   r   s   t   u   v   w   x   y   z   {   |   }   ~ DEL
-----------------------------------------------------------------------
*/
        
module LCD_Display(iCLK_50MHZ, iRST_N,K0_clk, hex3,hex2,hex1, hex0, 
    LCD_RS,LCD_E,LCD_RW,DATA_BUS);
input iCLK_50MHZ, iRST_N;
input  K0_clk;
input [3:0] hex3,hex2,hex1, hex0;
output LCD_RS, LCD_E, LCD_RW;
output [7:0] DATA_BUS;//change inout to output

parameter
HOLD = 4'h0,
FUNC_SET = 4'h1,
DISPLAY_ON = 4'h2,
MODE_SET = 4'h3,
Print_String = 4'h4,
LINE2 = 4'h5,
RETURN_HOME = 4'h6,
DROP_LCD_E = 4'h7,
RESET1 = 4'h8,
RESET2 = 4'h9,
RESET3 = 4'ha,
DISPLAY_OFF = 4'hb,
DISPLAY_CLEAR = 4'hc;

reg [3:0] state, next_command;
// Enter new ASCII hex data above for LCD Display
reg [7:0] DATA_BUS_VALUE;
wire [7:0] Next_Char;
reg [19:0] CLK_COUNT_400HZ;
reg [4:0] CHAR_COUNT;
reg CLK_400HZ, LCD_RW_INT, LCD_E, LCD_RS;



// BIDIRECTIONAL TRI STATE LCD DATA BUS
assign DATA_BUS = (LCD_RW_INT? 8'bZZZZZZZZ: DATA_BUS_VALUE);

LCD_display_string u1(

.index(CHAR_COUNT),
.out(Next_Char),
.K0_clk(K0_clk),
.hex3(hex3),
.hex2(hex2),
.hex1(hex1),
.hex0(hex0));

assign LCD_RW = LCD_RW_INT;



always @(posedge iCLK_50MHZ or negedge iRST_N)
    if (!iRST_N)
    begin
       CLK_COUNT_400HZ <= 20'h00000;
       CLK_400HZ <= 1'b0;
    end
	///
    else if (CLK_COUNT_400HZ < 20'h0F424)
    begin
       CLK_COUNT_400HZ <= CLK_COUNT_400HZ + 1'b1;
    end
    else
    begin
      CLK_COUNT_400HZ <= 20'h00000;
      CLK_400HZ <= ~CLK_400HZ;
    end
// State Machine to send commands and data to LCD DISPLAY







always @(posedge CLK_400HZ or negedge iRST_N)
    if (!iRST_N)
    begin
     state <= RESET1;
    end
    else
    case (state)
    RESET1:            
// Set Function to 8-bit transfer and 2 line display with 5x8 Font size
// see Hitachi HD44780 family data sheet for LCD command and timing details
    begin
      LCD_E <= 1'b1;
      LCD_RS <= 1'b0;
      LCD_RW_INT <= 1'b0;
      DATA_BUS_VALUE <=  8'h38;
      state <= DROP_LCD_E;
      next_command <= RESET2;
      CHAR_COUNT <= 5'b00000;
    end
    
	RESET2:
	 begin
      LCD_E <= 1'b1;
      LCD_RS <= 1'b0;
      LCD_RW_INT <= 1'b0;
      DATA_BUS_VALUE <=  8'h38;
      state <= DROP_LCD_E;
      next_command <= RESET3;
      CHAR_COUNT <= 5'b00000;
    end
    
    RESET3:
	 begin
      LCD_E <= 1'b1;
      LCD_RS <= 1'b0;
      LCD_RW_INT <= 1'b0;
      DATA_BUS_VALUE <=  8'h38;
      state <= DROP_LCD_E;
      next_command <= FUNC_SET;
      CHAR_COUNT <= 5'b00000;
    end

    FUNC_SET:
    begin
      LCD_E <= 1'b1;
      LCD_RS <= 1'b0;
      LCD_RW_INT <= 1'b0;
      DATA_BUS_VALUE <= 8'h38;
      state <= DROP_LCD_E;
      next_command <= DISPLAY_OFF;
    end

// Turn off Display and Turn off cursor
    DISPLAY_OFF:
    begin
      LCD_E <= 1'b1;
      LCD_RS <= 1'b0;
      LCD_RW_INT <= 1'b0;
      DATA_BUS_VALUE <= 8'h08;
      state <= DROP_LCD_E;
      next_command <= DISPLAY_CLEAR;
    end

// Clear Display and Turn off cursor
    DISPLAY_CLEAR:
    begin
      LCD_E <= 1'b1;
      LCD_RS <= 1'b0;
      LCD_RW_INT <= 1'b0;
      DATA_BUS_VALUE <= 8'h01;
      state <= DROP_LCD_E;
      next_command <=  MODE_SET;
    end
    
// Set write mode to auto increment address and move cursor to the right
    MODE_SET:
    begin
      LCD_E <= 1'b1;
      LCD_RS <= 1'b0;
      LCD_RW_INT <= 1'b0;
      DATA_BUS_VALUE <= 8'h06;
      state <= DROP_LCD_E;
      next_command <=  DISPLAY_ON;
    end
    
// Turn on Display and Turn off cursor
    DISPLAY_ON:
    begin
      LCD_E <= 1'b1;
      LCD_RS <= 1'b0;
      LCD_RW_INT <= 1'b0;
      DATA_BUS_VALUE <= 8'h0C;
      state <= DROP_LCD_E;
      next_command <= Print_String;
    end



// Write ASCII hex character in first LCD character location
    Print_String:
    begin
      state <= DROP_LCD_E;
      LCD_E <= 1'b1;
      LCD_RS <= 1'b1;
      LCD_RW_INT <= 1'b0;
    // ASCII character to output
      if (Next_Char[7:4] != 4'h0)
        DATA_BUS_VALUE <= Next_Char;
        // Convert 4-bit value to an ASCII hex digit
      else if (Next_Char[3:0] >9)
        // ASCII A...F
         DATA_BUS_VALUE <= {4'h4,Next_Char[3:0]-4'h9};
      else
        // ASCII 0...9
         DATA_BUS_VALUE <= {4'h3,Next_Char[3:0]};
         
       
    // Loop to send out 32 characters to LCD Display  (16 by 2 lines)
      if ((CHAR_COUNT < 31) && (Next_Char != 8'hFE))
         CHAR_COUNT <= CHAR_COUNT + 1'b1;
      else
         CHAR_COUNT <= 5'b00000; 
    // Jump to second line?
      if (CHAR_COUNT == 15)
        next_command <= LINE2;
    // Return to first line?
      else if ((CHAR_COUNT == 31) || (Next_Char == 8'hFE))
        next_command <= RETURN_HOME;
      else
        next_command <= Print_String;
    end

// Set write address to line 2 character 1
    LINE2:
    begin
      LCD_E <= 1'b1;
      LCD_RS <= 1'b0;
      LCD_RW_INT <= 1'b0;
      DATA_BUS_VALUE <= 8'hC0;
      state <= DROP_LCD_E;
      next_command <= Print_String;
    end

// Return write address to first character postion on line 1
    RETURN_HOME:
    begin
      LCD_E <= 1'b1;
      LCD_RS <= 1'b0;
      LCD_RW_INT <= 1'b0;
      DATA_BUS_VALUE <= 8'h80;
      state <= DROP_LCD_E;
      next_command <= Print_String;
    end

// The next three states occur at the end of each command or data transfer to the LCD
// Drop LCD E line - falling edge loads inst/data to LCD controller
    DROP_LCD_E:
    begin
      LCD_E <= 1'b0;
      state <= HOLD;
    end
// Hold LCD inst/data valid after falling edge of E line                
    HOLD:
    begin
      state <= next_command;
    end
    endcase
endmodule

/*
|----------------|
|0x41 65 'A'	255	11
|abcdefghijkl
|----------------|
*/

module LCD_display_string(index,out,K0_clk, hex3,hex2,hex0,hex1);
input K0_clk;
input [4:0] index;
input [3:0] hex3,hex2,hex1,hex0;
output [7:0] out;

reg [7:0] out;
reg [7:0]  dec;
reg [11:0] b;
reg [3:0] count=4'd0;
reg a;
reg [7:0] regs[15:0];
initial
 begin
	regs[15]= 8'h20;
	regs[14]= 8'h20;
	regs[13]= 8'h20;
	regs[12]= 8'h20;
	regs[11]= 8'h20;
	regs[10]= 8'h20;
	regs[9]= 8'h20;
	regs[8]= 8'h20;
	regs[7]= 8'h20;
	regs[6]= 8'h20;
	regs[5]= 8'h20;
	regs[4]= 8'h20;
	regs[3]= 8'h20;
	regs[2]= 8'h20;
	regs[1]= 8'h20;
	regs[0]= 8'h20;
 end

	always @(negedge K0_clk)
	if(count == 16)
		count <= 1'b0;
	else if(!K0_clk)
	begin
		 
		  regs[count] <= {hex3,hex2};
		  count<=count+1'b1;
		 
	end
	

// Line 1
   always 
     case (index)
    5'h00: out <= 8'h41;
    5'h01: out <= 8'h53;
    5'h02: out <= 8'h43;
    5'h03: out <= 8'h49;
    5'h04: out <= 8'h49;
    5'h05: out <= 8'h3a;
    5'h06: out <= 8'h30;
    5'h07: out <= 8'h78;
    5'h08: out <= {4'h0,hex1};
    5'h09: out <= {4'h0,hex0};
    
    5'h0b: out <= {hex1,hex0};
     5'h0d: 
	 begin
		dec<={hex1,hex0};
		b[11:8]=(dec/100)%10;
		out <= {4'h0,b[11:8]};
     end
   5'h0e:  
      begin
		dec<={hex1,hex0};
		b[7:4]=(dec/10)%10;
		out <= {4'h0,b[7:4]};
      end
   5'h0f: 
      begin
		dec<={hex1,hex0};
	    b[3:0]=dec%10;
		out <= {4'h0,b[3:0]};
     end
    
// Line 2
    5'h10: out <= regs[0];
    5'h11: out <= regs[1];
    5'h12: out <= regs[2];
    5'h13: out <= regs[3];
    5'h14: out <= regs[4];
    5'h15: out <= regs[5];
    5'h16: out <= regs[6];
    5'h17: out <= regs[7];
    5'h18: out <= regs[8];
    5'h19: out <= regs[9];
    5'h1a: out <= regs[10];
    5'h1b: out <= regs[11];
    5'h1c: out <= regs[12];
    5'h1d: out <= regs[13];
    5'h1e: out <= regs[14];
    5'h1f: out <= regs[15];
    default: out <= 8'h20;
     endcase
endmodule


//reset_delay.v


module    Reset_Delay(iCLK,oRESET);
input        iCLK;
output reg    oRESET;
reg    [19:0]    Cont;

always@(posedge iCLK)
begin
    if(Cont!=20'hFFFFF)
    begin
        Cont    <=    Cont+1'b1;
        oRESET    <=    1'b0;
    end
    else
    oRESET    <=    1'b1;
end

endmodule 
