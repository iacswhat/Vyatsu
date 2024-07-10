#line 1 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
#line 38 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
unsigned long Get_Fosc_kHz() {
 return Clock_kHz();
}
#line 63 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
 void Delay_1us() {
 Delay_us(1);
}
#line 88 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
 void Delay_10us() {
 Delay_us(10);
}
#line 113 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
 void Delay_22us() {
 Delay_us(22);
}
#line 138 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
 void Delay_50us() {
 Delay_us(50);
}
#line 163 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
 void Delay_80us() {
 Delay_us(78);
}
#line 188 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
 void Delay_500us() {
 Delay_us(498);
}
#line 213 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
 void Delay_5500us() {
 Delay_us(5500);
}
#line 238 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
 void Delay_8ms() {
 Delay_ms(8);
}
#line 263 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
void Delay_10ms() {
 Delay_ms(10);
}
#line 288 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
 void Delay_100ms() {
 Delay_ms(100);
}
#line 313 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
 void Delay_1sec()
{
 Delay_ms(1000);
}
#line 341 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
void Delay_Cyc(char cycles_div_by_10) {

 --cycles_div_by_10;
 --cycles_div_by_10;

 while (cycles_div_by_10 > 0) {
 --cycles_div_by_10;
 asm nop;
 asm nop;
 }

 asm nop;
 asm nop;
 asm nop;
 asm nop;
 asm nop;
 asm nop;
 asm nop;
}
#line 388 "D:/mikroC PRO for 8051/Uses/ATMEL/__Lib_Delays.c"
void VDelay_ms(unsigned Time_ms) {
 unsigned long NumberOfCyc;

 NumberOfCyc = Clock_kHz()/12;
 NumberOfCyc = NumberOfCyc * Time_ms;
 NumberOfCyc = NumberOfCyc >> 5;

 if (NumberOfCyc > 8)
 NumberOfCyc -= 8;
 else
 NumberOfCyc = 0;

 while (NumberOfCyc)
 {
 --NumberOfCyc;
 asm nop;
 asm nop;
 asm nop;

 asm nop;
 asm nop;
 asm nop;

 asm nop;
 asm nop;
 asm nop;

 asm nop;
 asm nop;
 }
}
