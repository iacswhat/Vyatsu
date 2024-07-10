/*
 * Project name:
     Sprinti
 * Copyright:
     (c) Mikroelektronika, 2009.
 * Revision History:
     20071210:
       - initial release;
 * Description:
     This is a demonstration of the standard C library sprinti routine usage.
     Two different representations of the same integer number obtained
     by using the sprintf routine are sent via UART.
 * Test configuration:
     MCU:             AT89S8253
                      http://www.atmel.com/dyn/resources/prod_documents/doc3286.pdf
     Dev.Board:       Easy8051v6
                      http://www.mikroe.com/easy8051/
     Oscillator:      External Clock 10.0000 MHz
     Ext. Modules:    -
     SW:              mikroC PRO for 8051
                      http://www.mikroe.com/mikroc/8051/
 * NOTES:
     - Turn ON RX and TX UART switches  (SW8.5 and SW8.6).
*/

unsigned int int_no = 30000;
char  buffer[15], msg[25];

// store strings to CODE space to save DATA space (Memory Type Specifiers, code)
const char code msg1[] = "Integer representation";
const char code msg2[] = "\r\nd format:";
const char code msg3[] = "\r\nx format:";

void CopyCodeStrToRam(const char *source, char *dest) {
  while(*source) {
    *dest++ = *source++ ;
  }
  *dest = 0;
}

void main(){

  UART1_Init(4800);                        // Initialize UART module at 4800 bps
  Delay_ms(10);
  
  CopyCodeStrToRam(msg1, msg);             // copy message1 to RAM
  UART1_Write_Text(msg);                   // Write message on UART

  sprinti(buffer, "%10d", int_no);         // Format int_no and store it to buffer
  CopyCodeStrToRam(msg2, msg);             // copy message2 to RAM
  UART1_Write_Text(msg);                   // Write message on UART
  UART1_Write_Text(buffer);                // Write buffer on UART

  sprinti(buffer, "%10x", int_no);         // Format int_no and store it to buffer
  CopyCodeStrToRam(msg3, msg);             // copy message3 to RAM
  UART1_Write_Text(msg);                   // Write message on UART
  UART1_Write_Text(buffer);                // Write buffer on UART
  
}