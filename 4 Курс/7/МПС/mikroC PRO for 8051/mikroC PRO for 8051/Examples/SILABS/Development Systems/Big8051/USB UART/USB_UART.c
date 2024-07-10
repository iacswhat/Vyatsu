/*
 * Project name:
     USB_UART (Simple usage of UART module library functions)
 * Copyright:
     (c) Mikroelektronika, 2013.
 * Revision History:
     20101129:
       - initial release (SZ)
 * Description:
     This program demonstrates how to use uart library routines. Upon receiving
     data via USB-UART, MCU immediately sends it back to the sender.
 * Test configuration:
     MCU:             C8051F040
                      http://www.silabs.com/Support%20Documents/TechnicalDocs/C8051F04x.pdf
     Dev.Board:       BIG8051  ac:USB_UART
                      http://www.mikroe.com/big8051/
     Oscillator:      External oscillator 25MHz
     Ext. Modules:    -
     SW:              mikroC PRO for 8051
                      http://www.mikroe.com/mikroc/8051/
 * NOTES:
    - SW13 (1,3 - ON)
*/


char uart_rd;

void main() {

  WDTCN    = 0xDE;                     // Sequence for
  WDTCN    = 0xAD;                     // disabling the watchdog timer



  OSCICN = 0x83;                       // Configure internal oscillator for
                                       // its highest frequency (24.5 MHz)
  RSTSRC = 0x04;                       // Enable missing clock detector


// Consult datasheet for more details about starting External oscillator
 // Step 1. Enable the external oscillator.
   OSCXCN = 0x60;                      // External Oscillator is an external
                                       // crystal (no divide by 2 stage)
   OSCXCN |= 7;


   // Step 2. Wait at least 1 ms.
   Delay_ms(5);

   // Step 3. Poll for XTLVLD => �1�.
   while ((OSCXCN & 0x80) != 0x80);


   // Step 4. Switch the system clock to the external oscillator.
   CLKSEL = 0x01;
//

   XBR0      = 0x04;
   XBR1      = 0;
   XBR2      = 0x40;                   // Enable crossbar and weak pull-ups

   P0MDOUT |= 0x01;                    // Configure P0.0 (TX) pin as push-pull

   UART1_Init(4800);                   // Initialize UART module at 4800 bps
   Delay_ms(100);                      // Wait for UART module to stabilize

   UART1_Write_Text("Start");

   while (1) {                         // Endless loop
     if (UART1_Data_Ready()) {         // If data is received,
       uart_rd = UART1_Read();         //   read the received data,
       UART1_Write(uart_rd);           //   and send data via UART
     }
   }
}