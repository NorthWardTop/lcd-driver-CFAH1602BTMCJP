/* system.h
 *
 * Machine generated for a CPU named "cpu" as defined in:
 * d:\0Clare\DE2-70\Q80\DE2_70_NIOS_count_binary\software\count_binary_0_syslib\..\..\nios_ii.ptf
 *
 * Generated: 2008-10-21 15:18:14.39
 *
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/*

DO NOT MODIFY THIS FILE

   Changing this file will have subtle consequences
   which will almost certainly lead to a nonfunctioning
   system. If you do modify this file, be aware that your
   changes will be overwritten and lost when this file
   is generated again.

DO NOT MODIFY THIS FILE

*/

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2003 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
******************************************************************************/

/*
 * system configuration
 *
 */

#define ALT_SYSTEM_NAME "nios_ii"
#define ALT_CPU_NAME "cpu"
#define ALT_CPU_ARCHITECTURE "altera_nios2"
#define ALT_DEVICE_FAMILY "CYCLONEII"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN_BASE 0x096051e8
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_PRESENT
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT_BASE 0x096051e8
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_PRESENT
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDERR_BASE 0x096051e8
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_PRESENT
#define ALT_CPU_FREQ 100000000
#define ALT_IRQ_BASE NULL

/*
 * processor configuration
 *
 */

#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_BIG_ENDIAN 0

#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_FLUSHDA_SUPPORTED

#define NIOS2_EXCEPTION_ADDR 0x09602020
#define NIOS2_RESET_ADDR 0x04000000
#define NIOS2_BREAK_ADDR 0x09604820

#define NIOS2_HAS_DEBUG_STUB

#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0

/*
 * A define for each class of peripheral
 *
 */

#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_LCD_16207
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_SYSID
#define __ALTERA_AVALON_TIMER
#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_UART
#define __ALTERA_AVALON_PLL
#define __SEG7_IF

/*
 * onchip_mem configuration
 *
 */

#define ONCHIP_MEM_NAME "/dev/onchip_mem"
#define ONCHIP_MEM_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEM_BASE 0x09602000
#define ONCHIP_MEM_SPAN 8192
#define ONCHIP_MEM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEM_RAM_BLOCK_TYPE "M4K"
#define ONCHIP_MEM_INIT_CONTENTS_FILE "onchip_mem"
#define ONCHIP_MEM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEM_GUI_RAM_BLOCK_TYPE "Automatic"
#define ONCHIP_MEM_WRITEABLE 1
#define ONCHIP_MEM_DUAL_PORT 0
#define ONCHIP_MEM_SIZE_VALUE 8192
#define ONCHIP_MEM_SIZE_MULTIPLE 1
#define ONCHIP_MEM_USE_SHALLOW_MEM_BLOCKS 0
#define ONCHIP_MEM_INIT_MEM_CONTENT 1
#define ONCHIP_MEM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEM_INSTANCE_ID "NONE"
#define ONCHIP_MEM_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEM_IGNORE_AUTO_BLOCK_TYPE_ASSIGNMENT 1
#define ONCHIP_MEM_CONTENTS_INFO "QUARTUS_PROJECT_DIR/onchip_mem.hex 1224570271"
#define ALT_MODULE_CLASS_onchip_mem altera_avalon_onchip_memory2

/*
 * pio_green_led configuration
 *
 */

#define PIO_GREEN_LED_NAME "/dev/pio_green_led"
#define PIO_GREEN_LED_TYPE "altera_avalon_pio"
#define PIO_GREEN_LED_BASE 0x09605120
#define PIO_GREEN_LED_SPAN 16
#define PIO_GREEN_LED_DO_TEST_BENCH_WIRING 0
#define PIO_GREEN_LED_DRIVEN_SIM_VALUE 0
#define PIO_GREEN_LED_HAS_TRI 0
#define PIO_GREEN_LED_HAS_OUT 1
#define PIO_GREEN_LED_HAS_IN 0
#define PIO_GREEN_LED_CAPTURE 0
#define PIO_GREEN_LED_DATA_WIDTH 9
#define PIO_GREEN_LED_RESET_VALUE 0
#define PIO_GREEN_LED_EDGE_TYPE "NONE"
#define PIO_GREEN_LED_IRQ_TYPE "NONE"
#define PIO_GREEN_LED_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_GREEN_LED_FREQ 100000000
#define ALT_MODULE_CLASS_pio_green_led altera_avalon_pio

/*
 * pio_red_led configuration
 *
 */

#define PIO_RED_LED_NAME "/dev/pio_red_led"
#define PIO_RED_LED_TYPE "altera_avalon_pio"
#define PIO_RED_LED_BASE 0x09605130
#define PIO_RED_LED_SPAN 16
#define PIO_RED_LED_DO_TEST_BENCH_WIRING 0
#define PIO_RED_LED_DRIVEN_SIM_VALUE 0
#define PIO_RED_LED_HAS_TRI 0
#define PIO_RED_LED_HAS_OUT 1
#define PIO_RED_LED_HAS_IN 0
#define PIO_RED_LED_CAPTURE 0
#define PIO_RED_LED_DATA_WIDTH 18
#define PIO_RED_LED_RESET_VALUE 0
#define PIO_RED_LED_EDGE_TYPE "NONE"
#define PIO_RED_LED_IRQ_TYPE "NONE"
#define PIO_RED_LED_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_RED_LED_FREQ 100000000
#define ALT_MODULE_CLASS_pio_red_led altera_avalon_pio

/*
 * pio_switch configuration
 *
 */

#define PIO_SWITCH_NAME "/dev/pio_switch"
#define PIO_SWITCH_TYPE "altera_avalon_pio"
#define PIO_SWITCH_BASE 0x09605140
#define PIO_SWITCH_SPAN 16
#define PIO_SWITCH_DO_TEST_BENCH_WIRING 0
#define PIO_SWITCH_DRIVEN_SIM_VALUE 0
#define PIO_SWITCH_HAS_TRI 0
#define PIO_SWITCH_HAS_OUT 0
#define PIO_SWITCH_HAS_IN 1
#define PIO_SWITCH_CAPTURE 0
#define PIO_SWITCH_DATA_WIDTH 18
#define PIO_SWITCH_RESET_VALUE 0
#define PIO_SWITCH_EDGE_TYPE "NONE"
#define PIO_SWITCH_IRQ_TYPE "NONE"
#define PIO_SWITCH_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_SWITCH_FREQ 100000000
#define ALT_MODULE_CLASS_pio_switch altera_avalon_pio

/*
 * pio_button configuration
 *
 */

#define PIO_BUTTON_NAME "/dev/pio_button"
#define PIO_BUTTON_TYPE "altera_avalon_pio"
#define PIO_BUTTON_BASE 0x09605150
#define PIO_BUTTON_SPAN 16
#define PIO_BUTTON_IRQ 4
#define PIO_BUTTON_DO_TEST_BENCH_WIRING 0
#define PIO_BUTTON_DRIVEN_SIM_VALUE 0
#define PIO_BUTTON_HAS_TRI 0
#define PIO_BUTTON_HAS_OUT 0
#define PIO_BUTTON_HAS_IN 1
#define PIO_BUTTON_CAPTURE 1
#define PIO_BUTTON_DATA_WIDTH 4
#define PIO_BUTTON_RESET_VALUE 0
#define PIO_BUTTON_EDGE_TYPE "RISING"
#define PIO_BUTTON_IRQ_TYPE "EDGE"
#define PIO_BUTTON_BIT_CLEARING_EDGE_REGISTER 0
#define PIO_BUTTON_FREQ 100000000
#define ALT_MODULE_CLASS_pio_button altera_avalon_pio

/*
 * lcd configuration
 *
 */

#define LCD_NAME "/dev/lcd"
#define LCD_TYPE "altera_avalon_lcd_16207"
#define LCD_BASE 0x09605160
#define LCD_SPAN 16
#define ALT_MODULE_CLASS_lcd altera_avalon_lcd_16207

/*
 * sdram_u1 configuration
 *
 */

#define SDRAM_U1_NAME "/dev/sdram_u1"
#define SDRAM_U1_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_U1_BASE 0x04000000
#define SDRAM_U1_SPAN 33554432
#define SDRAM_U1_REGISTER_DATA_IN 1
#define SDRAM_U1_SIM_MODEL_BASE 1
#define SDRAM_U1_SDRAM_DATA_WIDTH 16
#define SDRAM_U1_SDRAM_ADDR_WIDTH 13
#define SDRAM_U1_SDRAM_ROW_WIDTH 13
#define SDRAM_U1_SDRAM_COL_WIDTH 9
#define SDRAM_U1_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_U1_SDRAM_NUM_BANKS 4
#define SDRAM_U1_REFRESH_PERIOD 7.8125
#define SDRAM_U1_POWERUP_DELAY 200.0
#define SDRAM_U1_CAS_LATENCY 3
#define SDRAM_U1_T_RFC 70.0
#define SDRAM_U1_T_RP 20.0
#define SDRAM_U1_T_MRD 3
#define SDRAM_U1_T_RCD 20.0
#define SDRAM_U1_T_AC 5.5
#define SDRAM_U1_T_WR 14.0
#define SDRAM_U1_INIT_REFRESH_COMMANDS 2
#define SDRAM_U1_INIT_NOP_DELAY 0.0
#define SDRAM_U1_SHARED_DATA 0
#define SDRAM_U1_SDRAM_BANK_WIDTH 2
#define SDRAM_U1_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_U1_STARVATION_INDICATOR 0
#define SDRAM_U1_IS_INITIALIZED 1
#define ALT_MODULE_CLASS_sdram_u1 altera_avalon_new_sdram_controller

/*
 * sdram_u2 configuration
 *
 */

#define SDRAM_U2_NAME "/dev/sdram_u2"
#define SDRAM_U2_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_U2_BASE 0x06000000
#define SDRAM_U2_SPAN 33554432
#define SDRAM_U2_REGISTER_DATA_IN 1
#define SDRAM_U2_SIM_MODEL_BASE 1
#define SDRAM_U2_SDRAM_DATA_WIDTH 16
#define SDRAM_U2_SDRAM_ADDR_WIDTH 13
#define SDRAM_U2_SDRAM_ROW_WIDTH 13
#define SDRAM_U2_SDRAM_COL_WIDTH 9
#define SDRAM_U2_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_U2_SDRAM_NUM_BANKS 4
#define SDRAM_U2_REFRESH_PERIOD 7.8125
#define SDRAM_U2_POWERUP_DELAY 200.0
#define SDRAM_U2_CAS_LATENCY 3
#define SDRAM_U2_T_RFC 70.0
#define SDRAM_U2_T_RP 20.0
#define SDRAM_U2_T_MRD 3
#define SDRAM_U2_T_RCD 20.0
#define SDRAM_U2_T_AC 5.5
#define SDRAM_U2_T_WR 14.0
#define SDRAM_U2_INIT_REFRESH_COMMANDS 2
#define SDRAM_U2_INIT_NOP_DELAY 0.0
#define SDRAM_U2_SHARED_DATA 0
#define SDRAM_U2_SDRAM_BANK_WIDTH 2
#define SDRAM_U2_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_U2_STARVATION_INDICATOR 0
#define SDRAM_U2_IS_INITIALIZED 1
#define ALT_MODULE_CLASS_sdram_u2 altera_avalon_new_sdram_controller

/*
 * sysid configuration
 *
 */

#define SYSID_NAME "/dev/sysid"
#define SYSID_TYPE "altera_avalon_sysid"
#define SYSID_BASE 0x096051d0
#define SYSID_SPAN 8
#define SYSID_ID 1114575596u
#define SYSID_TIMESTAMP 1224570194u
#define SYSID_REGENERATE_VALUES 0
#define ALT_MODULE_CLASS_sysid altera_avalon_sysid

/*
 * timer configuration
 *
 */

#define TIMER_NAME "/dev/timer"
#define TIMER_TYPE "altera_avalon_timer"
#define TIMER_BASE 0x09605080
#define TIMER_SPAN 32
#define TIMER_IRQ 0
#define TIMER_ALWAYS_RUN 0
#define TIMER_FIXED_PERIOD 0
#define TIMER_SNAPSHOT 1
#define TIMER_PERIOD 1.0
#define TIMER_PERIOD_UNITS "ms"
#define TIMER_RESET_OUTPUT 0
#define TIMER_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_LOAD_VALUE 99999
#define TIMER_COUNTER_SIZE 32
#define TIMER_MULT 0.0010
#define TIMER_TICKS_PER_SEC 1000
#define TIMER_FREQ 100000000
#define ALT_MODULE_CLASS_timer altera_avalon_timer

/*
 * timer_stamp configuration
 *
 */

#define TIMER_STAMP_NAME "/dev/timer_stamp"
#define TIMER_STAMP_TYPE "altera_avalon_timer"
#define TIMER_STAMP_BASE 0x096050a0
#define TIMER_STAMP_SPAN 32
#define TIMER_STAMP_IRQ 1
#define TIMER_STAMP_ALWAYS_RUN 0
#define TIMER_STAMP_FIXED_PERIOD 0
#define TIMER_STAMP_SNAPSHOT 1
#define TIMER_STAMP_PERIOD 1.0
#define TIMER_STAMP_PERIOD_UNITS "ms"
#define TIMER_STAMP_RESET_OUTPUT 0
#define TIMER_STAMP_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_STAMP_LOAD_VALUE 99999
#define TIMER_STAMP_COUNTER_SIZE 32
#define TIMER_STAMP_MULT 0.0010
#define TIMER_STAMP_TICKS_PER_SEC 1000
#define TIMER_STAMP_FREQ 100000000
#define ALT_MODULE_CLASS_timer_stamp altera_avalon_timer

/*
 * jtag_uart configuration
 *
 */

#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_BASE 0x096051e8
#define JTAG_UART_SPAN 8
#define JTAG_UART_IRQ 2
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_READ_CHAR_STREAM ""
#define JTAG_UART_SHOWASCII 1
#define JTAG_UART_READ_LE 0
#define JTAG_UART_WRITE_LE 0
#define JTAG_UART_ALTERA_SHOW_UNRELEASED_JTAG_UART_FEATURES 0
#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart

/*
 * uart configuration
 *
 */

#define UART_NAME "/dev/uart"
#define UART_TYPE "altera_avalon_uart"
#define UART_BASE 0x096050c0
#define UART_SPAN 32
#define UART_IRQ 3
#define UART_BAUD 115200
#define UART_DATA_BITS 8
#define UART_FIXED_BAUD 1
#define UART_PARITY 'N'
#define UART_STOP_BITS 1
#define UART_USE_CTS_RTS 1
#define UART_USE_EOP_REGISTER 0
#define UART_SIM_TRUE_BAUD 0
#define UART_SIM_CHAR_STREAM ""
#define UART_FREQ 100000000
#define ALT_MODULE_CLASS_uart altera_avalon_uart

/*
 * pll configuration
 *
 */

#define PLL_NAME "/dev/pll"
#define PLL_TYPE "altera_avalon_pll"
#define PLL_BASE 0x096050e0
#define PLL_SPAN 32
#define PLL_ARESET "None"
#define PLL_PFDENA "None"
#define PLL_LOCKED "None"
#define PLL_PLLENA "None"
#define PLL_SCANCLK "None"
#define PLL_SCANDATA "None"
#define PLL_SCANREAD "None"
#define PLL_SCANWRITE "None"
#define PLL_SCANCLKENA "None"
#define PLL_SCANACLR "None"
#define PLL_SCANDATAOUT "None"
#define PLL_SCANDONE "None"
#define PLL_CONFIGUPDATE "None"
#define PLL_PHASECOUNTERSELECT "None"
#define PLL_PHASEDONE "None"
#define PLL_PHASEUPDOWN "None"
#define PLL_PHASESTEP "None"
#define PLL_CONFIG_DONE 0
#define ALT_MODULE_CLASS_pll altera_avalon_pll

/*
 * SEG7 configuration
 *
 */

#define SEG7_NAME "/dev/SEG7"
#define SEG7_TYPE "SEG7_IF"
#define SEG7_BASE 0x00000000
#define SEG7_SPAN 32
#define SEG7_TERMINATED_PORTS ""
#define ALT_MODULE_CLASS_SEG7 SEG7_IF

/*
 * system library configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK TIMER
#define ALT_TIMESTAMP_CLK none

/*
 * Devices associated with code sections.
 *
 */

#define ALT_TEXT_DEVICE       SDRAM_U1
#define ALT_RODATA_DEVICE     SDRAM_U1
#define ALT_RWDATA_DEVICE     SDRAM_U1
#define ALT_EXCEPTIONS_DEVICE ONCHIP_MEM
#define ALT_RESET_DEVICE      SDRAM_U1

/*
 * The text section is initialised so no bootloader will be required.
 * Set a variable to tell crt0.S to provide code at the reset address and
 * to initialise rwdata if appropriate.
 */

#define ALT_NO_BOOTLOADER


#endif /* __SYSTEM_H_ */
