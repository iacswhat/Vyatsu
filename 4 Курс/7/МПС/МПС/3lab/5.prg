189
60
mov al, 00010100b
cw0
out 3Dh, al
�������� cw0
mov al, 00101011b
cw1, k=11
out 3Dh, al
�������� cw1
mov al, 11000001b
cw6
out 3Dh, al
�������� cw6
in al, 3Dh
������ ����� ��������� ����
and al, 80h
������������ ����� psw � ���
jnz 06h
���� ������ � ���� ����� �������
mov al, 10010000b
cw4
out 3Dh, al
�������� cw4
mov di, 100h
����� ������ ��������� �������
mov cx, 8
8 ���� ��� �������
call ClearMem
������� ������
call Copy_AllMOZU
������� ���������
nop
�������� ���������
jmp 0Fh











mov al,11000001b

out 3Dh,al

call Copy_MOZU

ret







































































































































































































































































































































push all
���������� ���������
mov cx,8

mov di, 108h
������� ����� ����������� �������
mov al,11000001b

out 3Dh,al

call Copy_MOZU
������ �-��� � ��
mov di, 100h
����� ������ ��
mov si, 108h
����� ������ ��
xor cx,cx

call Comps
����� ��������� ���������
mov ax,bx

test ax,1h

jz 0CBh
���� ��� �������
call 100h
�����
cmp cx,7h
���� ��� ���� � ������ ���������
jz 0D0h

inc cx
� ���� ����
shr bx,1
���� ���
jmp 0C7h
� �������� ��������� ����
mov ax,di

sub ax,100h

cmp ax,7h
�������� ��������� ���� �����
jz 0D7h
���� �� ��������
inc di
������� � ���� ������
inc si
������� � ���� ������
jmp 0C5h
��������� �������� �� ����� �����
mov di,100h
��������� ��� ������
mov si,108h

mov cx,8

call Copy_OZU
�������� ������ ��� ���� ��������
mov al,11100000b
������ ������� �� ����������
out 3Dh,al

pop all
�������������� ���������
iret
�������


































































mov ax,di
���� �����������
sub ax,100h
������������ ������� �����
inc al
al:=al+1
shl al,4
����� ����������� al �� 4 � <-
or al,cl
������������ ������� �����
inc al
al:=al+1
out 3Ch, al
������ ����������� al � ����
ret
������� �� ��
























































































































































































































































































































































































































































































