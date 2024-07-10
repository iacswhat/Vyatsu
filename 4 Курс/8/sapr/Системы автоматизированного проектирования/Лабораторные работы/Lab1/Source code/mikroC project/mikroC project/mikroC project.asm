
_DelayMs:
;mikroC project.c,38 :: 		void DelayMs(unsigned int m) {
;mikroC project.c,40 :: 		for (ms = 0; ms != m; ms++) {
	MOV _ms+0, #0
L_DelayMs0:
	MOV A, _ms+0
	XRL A, FARG_DelayMs_m+0
	JNZ L__DelayMs95
	CLR A
	XRL A, FARG_DelayMs_m+1
L__DelayMs95:
	JZ L_DelayMs1
;mikroC project.c,41 :: 		for (a = 0; a != 120; a++);
	MOV DelayMs_a_L0+0, #0
L_DelayMs3:
	MOV A, DelayMs_a_L0+0
	XRL A, #120
	JZ L_DelayMs4
	INC DelayMs_a_L0+0
	SJMP L_DelayMs3
L_DelayMs4:
;mikroC project.c,42 :: 		WMCON.WDTRST = 1;
	SETB C
	MOV A, WMCON+0
	MOV #224, C
	MOV WMCON+0, A
;mikroC project.c,40 :: 		for (ms = 0; ms != m; ms++) {
	INC _ms+0
;mikroC project.c,43 :: 		}
	SJMP L_DelayMs0
L_DelayMs1:
;mikroC project.c,44 :: 		}
	RET
; end of _DelayMs

_getRandProg:
;mikroC project.c,46 :: 		int getRandProg() {
;mikroC project.c,47 :: 		return 1;
	MOV R0, #1
	MOV R1, #0
;mikroC project.c,48 :: 		}
	RET
; end of _getRandProg

_changeProgram:
;mikroC project.c,50 :: 		void changeProgram(unsigned char key) {
;mikroC project.c,51 :: 		if (key == 0) return;
	MOV A, FARG_changeProgram_key+0
	JNZ L_changeProgram6
	RET
L_changeProgram6:
;mikroC project.c,52 :: 		switch (key) {
	SJMP L_changeProgram7
;mikroC project.c,53 :: 		case '0':
L_changeProgram9:
;mikroC project.c,54 :: 		t = 2;
	MOV _t+0, #2
;mikroC project.c,55 :: 		zero_flag = 1;
	MOV _zero_flag+0, #1
;mikroC project.c,56 :: 		break;
	LJMP L_changeProgram8
;mikroC project.c,57 :: 		case '1':
L_changeProgram10:
;mikroC project.c,58 :: 		state = p1s0;
	MOV _state+0, #1
;mikroC project.c,59 :: 		zero_flag = 0;
	MOV _zero_flag+0, #0
;mikroC project.c,60 :: 		break;
	LJMP L_changeProgram8
;mikroC project.c,61 :: 		case '2':
L_changeProgram11:
;mikroC project.c,62 :: 		state = 2;
	MOV _state+0, #2
;mikroC project.c,63 :: 		zero_flag = 0;
	MOV _zero_flag+0, #0
;mikroC project.c,64 :: 		break;
	LJMP L_changeProgram8
;mikroC project.c,65 :: 		case '3':
L_changeProgram12:
;mikroC project.c,66 :: 		state = 3;
	MOV _state+0, #3
;mikroC project.c,67 :: 		zero_flag = 0;
	MOV _zero_flag+0, #0
;mikroC project.c,68 :: 		break;
	SJMP L_changeProgram8
;mikroC project.c,69 :: 		case '4':
L_changeProgram13:
;mikroC project.c,70 :: 		state = 4;
	MOV _state+0, #4
;mikroC project.c,71 :: 		zero_flag = 0;
	MOV _zero_flag+0, #0
;mikroC project.c,72 :: 		break;
	SJMP L_changeProgram8
;mikroC project.c,73 :: 		case '5':
L_changeProgram14:
;mikroC project.c,74 :: 		state = 5;
	MOV _state+0, #5
;mikroC project.c,75 :: 		zero_flag = 0;
	MOV _zero_flag+0, #0
;mikroC project.c,76 :: 		break;
	SJMP L_changeProgram8
;mikroC project.c,77 :: 		case '6':
L_changeProgram15:
;mikroC project.c,78 :: 		state = 6;
	MOV _state+0, #6
;mikroC project.c,79 :: 		zero_flag = 0;
	MOV _zero_flag+0, #0
;mikroC project.c,80 :: 		break;
	SJMP L_changeProgram8
;mikroC project.c,81 :: 		case '7':
L_changeProgram16:
;mikroC project.c,82 :: 		state = 7;
	MOV _state+0, #7
;mikroC project.c,83 :: 		zero_flag = 0;
	MOV _zero_flag+0, #0
;mikroC project.c,84 :: 		break;
	SJMP L_changeProgram8
;mikroC project.c,85 :: 		case '8':
L_changeProgram17:
;mikroC project.c,86 :: 		state = 8;
	MOV _state+0, #8
;mikroC project.c,87 :: 		zero_flag = 0;
	MOV _zero_flag+0, #0
;mikroC project.c,88 :: 		break;
	SJMP L_changeProgram8
;mikroC project.c,89 :: 		}
L_changeProgram7:
	MOV A, FARG_changeProgram_key+0
	XRL A, #48
	JZ L_changeProgram9
	MOV A, FARG_changeProgram_key+0
	XRL A, #49
	JZ L_changeProgram10
	MOV A, FARG_changeProgram_key+0
	XRL A, #50
	JZ L_changeProgram11
	MOV A, FARG_changeProgram_key+0
	XRL A, #51
	JZ L_changeProgram12
	MOV A, FARG_changeProgram_key+0
	XRL A, #52
	JZ L_changeProgram13
	MOV A, FARG_changeProgram_key+0
	XRL A, #53
	JZ L_changeProgram14
	MOV A, FARG_changeProgram_key+0
	XRL A, #54
	JZ L_changeProgram15
	MOV A, FARG_changeProgram_key+0
	XRL A, #55
	JZ L_changeProgram16
	MOV A, FARG_changeProgram_key+0
	XRL A, #56
	JZ L_changeProgram17
L_changeProgram8:
;mikroC project.c,90 :: 		}
	RET
; end of _changeProgram

_show:
;mikroC project.c,92 :: 		void show(char* str[], int len, char speed) {
;mikroC project.c,93 :: 		char i = 0;
	MOV show_i_L0+0, #0
	MOV show_j_L0+0, #8
	MOV show_c_L0+0, #0
;mikroC project.c,94 :: 		char j = 8;
;mikroC project.c,95 :: 		char c = 0;
;mikroC project.c,96 :: 		while (i < len) {
L_show18:
	CLR C
	MOV A, show_i_L0+0
	SUBB A, FARG_show_len+0
	MOV A, FARG_show_len+1
	XRL A, #128
	MOV R0, A
	CLR A
	XRL A, #128
	SUBB A, R0
	JC #3
	LJMP L_show19
;mikroC project.c,97 :: 		c = str[i];
	MOV A, FARG_show_str+0
	ADD A, show_i_L0+0
	MOV R0, A
	MOV show_c_L0+0, @R0
;mikroC project.c,98 :: 		j = 8;
	MOV show_j_L0+0, #8
;mikroC project.c,99 :: 		while (j > 0) {
L_show20:
	SETB C
	MOV A, show_j_L0+0
	SUBB A, #0
	JC L_show21
;mikroC project.c,100 :: 		if (j & c) {
	MOV A, show_j_L0+0
	ANL A, show_c_L0+0
	JZ L_show22
;mikroC project.c,101 :: 		if (j == 1) D1 = 0;
	MOV A, show_j_L0+0
	XRL A, #1
	JNZ L_show23
	CLR P0_0_bit+0
L_show23:
;mikroC project.c,102 :: 		if (j == 2) D2 = 0;
	MOV A, show_j_L0+0
	XRL A, #2
	JNZ L_show24
	CLR P0_1_bit+0
L_show24:
;mikroC project.c,103 :: 		if (j == 4) D3 = 0;
	MOV A, show_j_L0+0
	XRL A, #4
	JNZ L_show25
	CLR P0_2_bit+0
L_show25:
;mikroC project.c,104 :: 		if (j == 8) D4 = 0;
	MOV A, show_j_L0+0
	XRL A, #8
	JNZ L_show26
	CLR P0_3_bit+0
L_show26:
;mikroC project.c,105 :: 		}
	SJMP L_show27
L_show22:
;mikroC project.c,107 :: 		if (j == 1) D1 = 1;
	MOV A, show_j_L0+0
	XRL A, #1
	JNZ L_show28
	SETB P0_0_bit+0
L_show28:
;mikroC project.c,108 :: 		if (j == 2) D2 = 1;
	MOV A, show_j_L0+0
	XRL A, #2
	JNZ L_show29
	SETB P0_1_bit+0
L_show29:
;mikroC project.c,109 :: 		if (j == 4) D3 = 1;
	MOV A, show_j_L0+0
	XRL A, #4
	JNZ L_show30
	SETB P0_2_bit+0
L_show30:
;mikroC project.c,110 :: 		if (j == 8) D4 = 1;
	MOV A, show_j_L0+0
	XRL A, #8
	JNZ L_show31
	SETB P0_3_bit+0
L_show31:
;mikroC project.c,111 :: 		}
L_show27:
;mikroC project.c,112 :: 		j >>= 1;
	MOV R0, #1
	MOV A, show_j_L0+0
	INC R0
	SJMP L__show96
L__show97:
	CLR C
	RRC A
L__show96:
	DJNZ R0, L__show97
	MOV show_j_L0+0, A
;mikroC project.c,113 :: 		}
	SJMP L_show20
L_show21:
;mikroC project.c,115 :: 		delayMs(speed);
	MOV FARG_DelayMs_m+0, FARG_show_speed+0
	CLR A
	MOV FARG_DelayMs_m+1, A
	LCALL _DelayMs+0
;mikroC project.c,116 :: 		i++;
	INC show_i_L0+0
;mikroC project.c,117 :: 		}
	LJMP L_show18
L_show19:
;mikroC project.c,118 :: 		}
	RET
; end of _show

_main:
	MOV SP+0, #128
;mikroC project.c,120 :: 		void main() {
;mikroC project.c,121 :: 		init();
	LCALL _init+0
;mikroC project.c,122 :: 		clear_lcd();
	LCALL _clear_lcd+0
;mikroC project.c,124 :: 		while (1) {
L_main32:
;mikroC project.c,125 :: 		outd(state + '0');
	MOV A, _state+0
	ADD A, #48
	MOV FARG_outd_c+0, A
	LCALL _outd+0
;mikroC project.c,128 :: 		for (i = 1; i < 32; ++i) {
	MOV main_i_L2+0, #1
	MOV main_i_L2+1, #0
L_main34:
	CLR C
	MOV A, main_i_L2+0
	SUBB A, #32
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, main_i_L2+1
	XRL A, #128
	SUBB A, R0
	JNC L_main35
;mikroC project.c,129 :: 		outd(' ');
	MOV FARG_outd_c+0, #32
	LCALL _outd+0
;mikroC project.c,128 :: 		for (i = 1; i < 32; ++i) {
	MOV A, #1
	ADD A, main_i_L2+0
	MOV main_i_L2+0, A
	MOV A, #0
	ADDC A, main_i_L2+1
	MOV main_i_L2+1, A
;mikroC project.c,130 :: 		}
	SJMP L_main34
L_main35:
;mikroC project.c,132 :: 		key = ScanKbd();
	LCALL _ScanKbd+0
	MOV _key+0, 0
;mikroC project.c,133 :: 		switch (state) {
	LJMP L_main37
;mikroC project.c,134 :: 		case p1s0:
L_main39:
;mikroC project.c,135 :: 		show(prog1, 4, speed);
	MOV FARG_show_str+0, #_prog1+0
	MOV FARG_show_len+0, #4
	MOV FARG_show_len+1, #0
	MOV FARG_show_speed+0, _speed+0
	LCALL _show+0
;mikroC project.c,136 :: 		changeProgram(key);
	MOV FARG_changeProgram_key+0, _key+0
	LCALL _changeProgram+0
;mikroC project.c,137 :: 		if (t > 0) t--;
	SETB C
	MOV A, _t+0
	SUBB A, #0
	JC L_main40
	DEC _t+0
L_main40:
;mikroC project.c,138 :: 		if ((t == 0) && (zero_flag)) {
	MOV A, _t+0
	JNZ L_main43
	MOV A, _zero_flag+0
	JZ L_main43
L__main94:
;mikroC project.c,139 :: 		t = 2;
	MOV _t+0, #2
;mikroC project.c,140 :: 		state = getRandProg();
	LCALL _getRandProg+0
	MOV _state+0, 0
;mikroC project.c,141 :: 		}
L_main43:
;mikroC project.c,142 :: 		break;
	LJMP L_main38
;mikroC project.c,143 :: 		case p2s0:
L_main44:
;mikroC project.c,144 :: 		show(prog2, 4, speed);
	MOV FARG_show_str+0, #_prog2+0
	MOV FARG_show_len+0, #4
	MOV FARG_show_len+1, #0
	MOV FARG_show_speed+0, _speed+0
	LCALL _show+0
;mikroC project.c,145 :: 		changeProgram(key);
	MOV FARG_changeProgram_key+0, _key+0
	LCALL _changeProgram+0
;mikroC project.c,146 :: 		if (t > 0) t--;
	SETB C
	MOV A, _t+0
	SUBB A, #0
	JC L_main45
	DEC _t+0
L_main45:
;mikroC project.c,147 :: 		if ((t == 0) && (zero_flag)) {
	MOV A, _t+0
	JNZ L_main48
	MOV A, _zero_flag+0
	JZ L_main48
L__main93:
;mikroC project.c,148 :: 		t = 2;
	MOV _t+0, #2
;mikroC project.c,149 :: 		state = getRandProg();
	LCALL _getRandProg+0
	MOV _state+0, 0
;mikroC project.c,150 :: 		}
L_main48:
;mikroC project.c,151 :: 		break;
	LJMP L_main38
;mikroC project.c,152 :: 		case p3s0:
L_main49:
;mikroC project.c,153 :: 		show(prog3, 2, speed);
	MOV FARG_show_str+0, #_prog3+0
	MOV FARG_show_len+0, #2
	MOV FARG_show_len+1, #0
	MOV FARG_show_speed+0, _speed+0
	LCALL _show+0
;mikroC project.c,154 :: 		changeProgram(key);
	MOV FARG_changeProgram_key+0, _key+0
	LCALL _changeProgram+0
;mikroC project.c,155 :: 		if (t > 0) t--;
	SETB C
	MOV A, _t+0
	SUBB A, #0
	JC L_main50
	DEC _t+0
L_main50:
;mikroC project.c,156 :: 		if ((t == 0) && (zero_flag)) {
	MOV A, _t+0
	JNZ L_main53
	MOV A, _zero_flag+0
	JZ L_main53
L__main92:
;mikroC project.c,157 :: 		t = 2;
	MOV _t+0, #2
;mikroC project.c,158 :: 		state = getRandProg();
	LCALL _getRandProg+0
	MOV _state+0, 0
;mikroC project.c,159 :: 		}
L_main53:
;mikroC project.c,160 :: 		break;
	LJMP L_main38
;mikroC project.c,161 :: 		case p4s0:
L_main54:
;mikroC project.c,162 :: 		show(prog4, 8, speed);
	MOV FARG_show_str+0, #_prog4+0
	MOV FARG_show_len+0, #8
	MOV FARG_show_len+1, #0
	MOV FARG_show_speed+0, _speed+0
	LCALL _show+0
;mikroC project.c,163 :: 		changeProgram(key);
	MOV FARG_changeProgram_key+0, _key+0
	LCALL _changeProgram+0
;mikroC project.c,164 :: 		if (t > 0) t--;
	SETB C
	MOV A, _t+0
	SUBB A, #0
	JC L_main55
	DEC _t+0
L_main55:
;mikroC project.c,165 :: 		if ((t == 0) && (zero_flag)) {
	MOV A, _t+0
	JNZ L_main58
	MOV A, _zero_flag+0
	JZ L_main58
L__main91:
;mikroC project.c,166 :: 		t = 2;
	MOV _t+0, #2
;mikroC project.c,167 :: 		state = getRandProg();
	LCALL _getRandProg+0
	MOV _state+0, 0
;mikroC project.c,168 :: 		}
L_main58:
;mikroC project.c,169 :: 		break;
	LJMP L_main38
;mikroC project.c,170 :: 		case p5s0:
L_main59:
;mikroC project.c,171 :: 		show(prog5, 8, speed);
	MOV FARG_show_str+0, #_prog5+0
	MOV FARG_show_len+0, #8
	MOV FARG_show_len+1, #0
	MOV FARG_show_speed+0, _speed+0
	LCALL _show+0
;mikroC project.c,172 :: 		changeProgram(key);
	MOV FARG_changeProgram_key+0, _key+0
	LCALL _changeProgram+0
;mikroC project.c,173 :: 		if (t > 0) t--;
	SETB C
	MOV A, _t+0
	SUBB A, #0
	JC L_main60
	DEC _t+0
L_main60:
;mikroC project.c,174 :: 		if ((t == 0) && (zero_flag)) {
	MOV A, _t+0
	JNZ L_main63
	MOV A, _zero_flag+0
	JZ L_main63
L__main90:
;mikroC project.c,175 :: 		t = 2;
	MOV _t+0, #2
;mikroC project.c,176 :: 		state = getRandProg();
	LCALL _getRandProg+0
	MOV _state+0, 0
;mikroC project.c,177 :: 		}
L_main63:
;mikroC project.c,178 :: 		break;
	LJMP L_main38
;mikroC project.c,179 :: 		case p6s0:
L_main64:
;mikroC project.c,180 :: 		show(prog6, 2, speed);
	MOV FARG_show_str+0, #_prog6+0
	MOV FARG_show_len+0, #2
	MOV FARG_show_len+1, #0
	MOV FARG_show_speed+0, _speed+0
	LCALL _show+0
;mikroC project.c,181 :: 		changeProgram(key);
	MOV FARG_changeProgram_key+0, _key+0
	LCALL _changeProgram+0
;mikroC project.c,182 :: 		if (t > 0) t--;
	SETB C
	MOV A, _t+0
	SUBB A, #0
	JC L_main65
	DEC _t+0
L_main65:
;mikroC project.c,183 :: 		if ((t == 0) && (zero_flag)) {
	MOV A, _t+0
	JNZ L_main68
	MOV A, _zero_flag+0
	JZ L_main68
L__main89:
;mikroC project.c,184 :: 		t = 2;
	MOV _t+0, #2
;mikroC project.c,185 :: 		state = getRandProg();
	LCALL _getRandProg+0
	MOV _state+0, 0
;mikroC project.c,186 :: 		}
L_main68:
;mikroC project.c,187 :: 		break;
	LJMP L_main38
;mikroC project.c,188 :: 		case p7s0:
L_main69:
;mikroC project.c,189 :: 		show(prog7, 2, speed);
	MOV FARG_show_str+0, #_prog7+0
	MOV FARG_show_len+0, #2
	MOV FARG_show_len+1, #0
	MOV FARG_show_speed+0, _speed+0
	LCALL _show+0
;mikroC project.c,190 :: 		changeProgram(key);
	MOV FARG_changeProgram_key+0, _key+0
	LCALL _changeProgram+0
;mikroC project.c,191 :: 		if (t > 0) t--;
	SETB C
	MOV A, _t+0
	SUBB A, #0
	JC L_main70
	DEC _t+0
L_main70:
;mikroC project.c,192 :: 		if ((t == 0) && (zero_flag)) {
	MOV A, _t+0
	JNZ L_main73
	MOV A, _zero_flag+0
	JZ L_main73
L__main88:
;mikroC project.c,193 :: 		t = 2;
	MOV _t+0, #2
;mikroC project.c,194 :: 		state = getRandProg();
	LCALL _getRandProg+0
	MOV _state+0, 0
;mikroC project.c,195 :: 		}
L_main73:
;mikroC project.c,196 :: 		break;
	LJMP L_main38
;mikroC project.c,197 :: 		case p8s0:
L_main74:
;mikroC project.c,198 :: 		show(prog8, 3, speed);
	MOV FARG_show_str+0, #_prog8+0
	MOV FARG_show_len+0, #3
	MOV FARG_show_len+1, #0
	MOV FARG_show_speed+0, _speed+0
	LCALL _show+0
;mikroC project.c,199 :: 		changeProgram(key);
	MOV FARG_changeProgram_key+0, _key+0
	LCALL _changeProgram+0
;mikroC project.c,200 :: 		if (t > 0) t--;
	SETB C
	MOV A, _t+0
	SUBB A, #0
	JC L_main75
	DEC _t+0
L_main75:
;mikroC project.c,201 :: 		if ((t == 0) && (zero_flag)) {
	MOV A, _t+0
	JNZ L_main78
	MOV A, _zero_flag+0
	JZ L_main78
L__main87:
;mikroC project.c,202 :: 		t = 2;
	MOV _t+0, #2
;mikroC project.c,203 :: 		state = getRandProg();
	LCALL _getRandProg+0
	MOV _state+0, 0
;mikroC project.c,204 :: 		}
L_main78:
;mikroC project.c,205 :: 		break;
	SJMP L_main38
;mikroC project.c,206 :: 		}
L_main37:
	MOV A, _state+0
	XRL A, #1
	JNZ #3
	LJMP L_main39
	MOV A, _state+0
	XRL A, #2
	JNZ #3
	LJMP L_main44
	MOV A, _state+0
	XRL A, #3
	JNZ #3
	LJMP L_main49
	MOV A, _state+0
	XRL A, #4
	JNZ #3
	LJMP L_main54
	MOV A, _state+0
	XRL A, #5
	JNZ #3
	LJMP L_main59
	MOV A, _state+0
	XRL A, #6
	JNZ #3
	LJMP L_main64
	MOV A, _state+0
	XRL A, #7
	JNZ #3
	LJMP L_main69
	MOV A, _state+0
	XRL A, #8
	JNZ #3
	LJMP L_main74
L_main38:
;mikroC project.c,207 :: 		if ((key == key_up) && (speed > 100)) {
	MOV A, _key+0
	XRL A, #101
	JNZ L_main81
	SETB C
	MOV A, _speed+0
	SUBB A, #100
	MOV A, _speed+1
	SUBB A, #0
	JC L_main81
L__main86:
;mikroC project.c,208 :: 		speed -= 100;
	CLR C
	MOV A, _speed+0
	SUBB A, #100
	MOV _speed+0, A
	MOV A, _speed+1
	SUBB A, #0
	MOV _speed+1, A
;mikroC project.c,209 :: 		}
L_main81:
;mikroC project.c,210 :: 		if ((key == key_down) && (speed < 1000)) {
	MOV A, _key+0
	XRL A, #35
	JNZ L_main84
	CLR C
	MOV A, _speed+0
	SUBB A, #232
	MOV A, _speed+1
	SUBB A, #3
	JNC L_main84
L__main85:
;mikroC project.c,211 :: 		speed += 100;
	MOV A, #100
	ADD A, _speed+0
	MOV _speed+0, A
	MOV A, #0
	ADDC A, _speed+1
	MOV _speed+1, A
;mikroC project.c,212 :: 		}
L_main84:
;mikroC project.c,213 :: 		delayMs(speed);
	MOV FARG_DelayMs_m+0, _speed+0
	MOV FARG_DelayMs_m+1, _speed+1
	LCALL _DelayMs+0
;mikroC project.c,214 :: 		}
	LJMP L_main32
;mikroC project.c,215 :: 		}
	SJMP #254
; end of _main
