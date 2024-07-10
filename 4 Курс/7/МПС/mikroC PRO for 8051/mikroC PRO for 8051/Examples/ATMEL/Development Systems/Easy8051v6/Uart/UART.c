/*
 * Project name:
     UART (Simple usage of UART module library functions)
 * Copyright:
     (c) Mikroelektronika, 2009.
 * Revision History:
     20071210:
       - initial release;
 * Description:
     This program demonstrates how to use uart library routines. Upon receiving
     data via RS232, MCU immediately sends it back to the sender.
 * Test configuration:
     MCU:             AT89S8253
                      http://www.atmel.com/dyn/resources/prod_documents/doc3286.pdf
     Dev.Board:       Easy8051v6 - ac:UART
                      http://www.mikroe.com/easy8051/
     Oscillator:      External Clock 10.0000 MHz
     Ext. Modules:    -
     SW:              mikroC PRO for 8051
                      http://www.mikroe.com/mikroc/8051/
 * NOTES:
     - Turn ON RX and TX UART switches (SW8.5, SW8.6).
*/

char uart_rd;

void main() {
  
  UART1_Init(4800);               // Initialize UART module at 4800 bps
  Delay_ms(100);                  // Wait for UART module to stabilize
  
  UART1_Write_Text("Start");
  while (1) {                     // Endless loop
    if (UART1_Data_Ready()) {     // If data is received,
      uart_rd = UART1_Read();     //   read the received data,
      UART1_Write(uart_rd);       //   and send data via UART
    }
  }
}