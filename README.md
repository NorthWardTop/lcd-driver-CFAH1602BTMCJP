# lcd-driver-CFAH1602BTMCJP
在DE2_70 FPGA上实现LCD驱动程序

# DE2-70主板引脚对应关系(没有背光)
Signal Name  FPGA Pin No. Description 
LCD_DATA[0] PIN_E1 LCD Data[0] 
LCD_DATA[1] PIN_E3 LCD Data[1] 
LCD_DATA[2] PIN_D2 LCD Data[2] 
LCD_DATA[3] PIN_D3 LCD Data[3] 
LCD_DATA[4] PIN_C1 LCD Data[4] 
LCD_DATA[5] PIN_C2 LCD Data[5] 
LCD_DATA[6] PIN_C3 LCD Data[6] 
LCD_DATA[7] PIN_B2 LCD Data[7] 
读写模式,read:处理器到LCD
LCD_RW 		PIN_F3 LCD Read/Write Select, 0 = Write, 1 = Read 
使能LCD芯片
LCD_EN 		PIN_E2 LCD Enable 
选择传输数据/指令,0时传输指令,1时传数据
LCD_RS 		PIN_F2 LCD Command/Data Select, 0 = Command, 1 = Data 
LCD电源
LCD_ON 		PIN_F1 LCD Power ON/OFF 
LCD背光电源
LCD_BLON 	PIN_G3 LCD Back Light ON/OFF 


