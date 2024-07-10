/*
 * Project name:
     Conversions
 * Copyright:
     (c) Mikroelektronika, 2013.
 * Revision History:
     20071210:
       - initial release;
 * Description:
     This program demonstrates usage of Conversion library routines.
     Compile and run the code through software simulator.
 * Test configuration:
     MCU:             C8051F040
                      http://www.silabs.com/Support%20Documents/TechnicalDocs/C8051F04x.pdf
     Dev.Board:       BIG8051
                      http://www.mikroe.com/big8051/
     Oscillator:      Internal oscillator 24.5000 MHz
     Ext. Modules:    -
     SW:              mikroC PRO for 8051
                      http://www.mikroe.com/mikroc/8051/
 * NOTES:
     None.
 */

char res_ch;
int  res_int;
char txt[14];

void main() {
  char txt1[] = " mikroelektronika  ";
  char txt_sub[10] = " mikroe  ";
  
  Rtrim(txt1);
  Ltrim(txt_sub);

  ByteToStr(234,txt);
  WordToStr(432,txt);
  WordToStr(5679,txt);
  WordToStr(0xFFFF,txt);
  ShortToStr(12,txt);
  ShortToStr(-1,txt);
  ShortToStr(-127,txt);
  IntToStr(1224,txt);
  IntToStr(-1,txt);
  IntToStr(-12787,txt);
  LongWordToStr(12,txt);
  LongWordToStr(0xFFFFFFFF,txt);
  LongToStr(12,txt);
  LongToStr(-1,txt);
  LongToStr(0x7FFFFFFF,txt);

  FloatToStr(123.567,txt);
  FloatToStr(-123.567,txt);
  FloatToStr(14.67e12,txt);
  FloatToStr(89.77e-5,txt);
  FloatToStr(-14.67e12,txt);
  FloatToStr(-89.77e-5,txt);

  res_ch  = Dec2Bcd(23);
  res_int = Dec2Bcd16(2345);
  res_int = Bcd2Dec16(0x4325);

}