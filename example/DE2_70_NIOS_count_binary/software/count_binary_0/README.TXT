/******************************************************************************
 * README.TXT for count_binary software example.
 *
 * Project Contents
 * **************** 
 * README.TXT          This file.
 * count_binary.c      The main C code.
 * count_binary.h      C Header file containing various includes and LCD 
 *                     convenience definitions.
 ******************************************************************************
 * Description
 * ************* 
 * A simple program which, using an 8 bit variable, counts from 0 to ff, 
 * repeatedly.  Output of this variable is displayed on the LEDs, the Seven
 * Segment Display, and the LCD.  The four "buttons" (SW0-SW3) are used
 * to control output to these devices in the following manner:
 *   Button1 (SW0) => LED is "counting"
 *   Button2 (SW1) => Seven Segment is "counting"
 *   Button3 (SW2) => LCD is "counting"
 *   Button4 (SW3) => All of the peripherals are "counting".
 *
 * Upon completion of "counting", there is a short waiting period during 
 * which button/switch presses will be identified on STDOUT.
 * NOTE:  These buttons have not been de-bounced, so one button press may 
 *        cause multiple notifications to STDOUT.
 ****************************************************************************** 
 * Requirements
 * **************
 * This program requires the following devices to be configured:
 *   an LED PIO named 'led_pio',
 *   a Seven Segment Display PIO named 'seven_seg_pio',
 *   an LCD Display named 'lcd_display',
 *   a Button PIO named 'button_pio',
 *   a UART (JTAG or standard serial)
 ******************************************************************************
 * 
 * Peripherals Exercised by SW
 * *****************************
 * LEDs
 * Seven Segment Display
 * LCD
 * Buttons (SW0-SW3)
 * UART (JTAG or serial)
 ****************************************************************************** 
 ** NOTE:  For additional information, please see the top of count_binary.c. **
 **        Behavior will be different on the 1C12 board, due to its of       **
 **        peripherals.                                                      **
 ******************************************************************************
 */
