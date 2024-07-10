#include "drv.h"

#define D1 P0_0_bit
#define D2 P0_1_bit
#define D3 P0_2_bit
#define D4 P0_3_bit

#define p0s0 0
#define p1s0 1
#define p2s0 2
#define p3s0 3
#define p4s0 4
#define p5s0 5
#define p6s0 6
#define p7s0 7
#define p8s0 8

#define key_up 'e'
#define key_down '#'

char ms = 0;
char state = 1;
char key = 0;
char t = 0;
unsigned int speed = 100;
char T_FLAG = 0;
char zero_flag = 0;

char* prog1[] = { 8, 4, 2, 1 };
char* prog2[] = { 1, 2, 4, 8 };
char* prog3[] = { 5, 10 };
char* prog4[] = { 0, 8, 12, 14, 15, 14, 12, 8 };
char* prog5[] = { 0, 1, 3, 7, 15, 7, 3, 1 };
char* prog6[] = { 9, 6 };
char* prog7[] = { 12, 3 };
char* prog8[] = { 12, 6, 3 };

void DelayMs(unsigned int m) {
        unsigned char a;
        for (ms = 0; ms != m; ms++) {
                for (a = 0; a != 120; a++);
                WMCON.WDTRST = 1;
        }
}

int getRandProg() {
        return 1;
}

void changeProgram(unsigned char key) {
        if (key == 0) return;
        switch (key) {
        case '0':
                t = 2;
                zero_flag = 1;
                break;
        case '1':
                state = p1s0;
                zero_flag = 0;
                break;
        case '2':
                state = 2;
                zero_flag = 0;
                break;
        case '3':
                state = 3;
                zero_flag = 0;
                break;
        case '4':
                state = 4;
                zero_flag = 0;
                break;
        case '5':
                state = 5;
                zero_flag = 0;
                break;
        case '6':
                state = 6;
                zero_flag = 0;
                break;
        case '7':
                state = 7;
                zero_flag = 0;
                break;
        case '8':
                state = 8;
                zero_flag = 0;
                break;
        }
}

void show(char* str[], int len, char speed) {
        char i = 0;
        char j = 8;
        char c = 0;
        while (i < len) {
                c = str[i];
                j = 8;
                while (j > 0) {
                        if (j & c) {
                                if (j == 1) D1 = 0;
                                if (j == 2) D2 = 0;
                                if (j == 4) D3 = 0;
                                if (j == 8) D4 = 0;
                        }
                        else {
                                if (j == 1) D1 = 1;
                                if (j == 2) D2 = 1;
                                if (j == 4) D3 = 1;
                                if (j == 8) D4 = 1;
                        }
                        j >>= 1;
                }

                delayMs(speed);
                i++;
        }
}

void main() {
        init();
        clear_lcd();

        while (1) {
                outd(state + '0');
                {
                        int i;
                        for (i = 1; i < 32; ++i) {
                                outd(' ');
                        }
                }
                key = ScanKbd();
                switch (state) {
                case p1s0:
                        show(prog1, 4, speed);
                        changeProgram(key);
                        if (t > 0) t--;
                        if ((t == 0) && (zero_flag)) {
                                t = 2;
                                state = getRandProg();
                        }
                        break;
                case p2s0:
                        show(prog2, 4, speed);
                        changeProgram(key);
                        if (t > 0) t--;
                        if ((t == 0) && (zero_flag)) {
                                t = 2;
                                state = getRandProg();
                        }
                        break;
                case p3s0:
                        show(prog3, 2, speed);
                        changeProgram(key);
                        if (t > 0) t--;
                        if ((t == 0) && (zero_flag)) {
                                t = 2;
                                state = getRandProg();
                        }
                        break;
                case p4s0:
                        show(prog4, 8, speed);
                        changeProgram(key);
                        if (t > 0) t--;
                        if ((t == 0) && (zero_flag)) {
                                t = 2;
                                state = getRandProg();
                        }
                        break;
                case p5s0:
                        show(prog5, 8, speed);
                        changeProgram(key);
                        if (t > 0) t--;
                        if ((t == 0) && (zero_flag)) {
                                t = 2;
                                state = getRandProg();
                        }
                        break;
                case p6s0:
                        show(prog6, 2, speed);
                        changeProgram(key);
                        if (t > 0) t--;
                        if ((t == 0) && (zero_flag)) {
                                t = 2;
                                state = getRandProg();
                        }
                        break;
                case p7s0:
                        show(prog7, 2, speed);
                        changeProgram(key);
                        if (t > 0) t--;
                        if ((t == 0) && (zero_flag)) {
                                t = 2;
                                state = getRandProg();
                        }
                        break;
                case p8s0:
                        show(prog8, 3, speed);
                        changeProgram(key);
                        if (t > 0) t--;
                        if ((t == 0) && (zero_flag)) {
                                t = 2;
                                state = getRandProg();
                        }
                        break;
                }
                if ((key == key_up) && (speed > 100)) {
                        speed -= 100;
                }
                if ((key == key_down) && (speed < 1000)) {
                        speed += 100;
                }
                delayMs(speed);
        }
}