175
68
call 0fh

mov al,10h

mov bl,20h

add al,bl

inc al

dec bl

jmp 001h

















push ax

mov al,00110100b
k=1500/85
out 45h,al
cw1
mov al,00000101b
4 ����, � ��.����, �������
out 45h,al

mov al,11010000b
����������� �����
out 45h,al
CW6->
in al,45h

and al,80h

jnz 015h

mov al,10000000b
AINC=0 ��� (RGA ����) 0000
out 45h,al
CW4->
xor di,di

mov cx,8h

call clearmem

mov [16h],0
������� ������� �����������
pop ax

ret





























































































































































































































































































push all

mov al,11100000b
������ INT
out 45h,al
CW7
mov al,01010000b
���-�� ������ ����
out 45h,al
CW2
mov di,08h
����� ������ ���. � ���
call copy_allmozu
����������� ���� � ��� �� 8
mov di,0h
�������� ��������� ����
mov si,08h
����� ��������� ����(��������)
mov cx,08h
���0�� ���� ����
mov ax,0h
��� �������� �������
mov dl,[di]
�������� ������� ��������
xor dl,[si]
����������� � ������� ����������
mov dh,08h

mov bh,dl
���������� ����� dl
and dl,01h
�������� ������ ��� ��������� 
mov bl,al
���� al
cmp dl,0h
�������� �� ���� ���� ��������
je 0d6h
���� ������
push ax
���������� ��������� ��������
mov al, 10100100b
������ �� ����� � d3-d0
out 45h,al
CW5
pop ax

cmp ax, 0fh
���� �� ���-�� ���� � ��� �������
jbe 0cah
���� <, �� 1 ����� � �������
and al, 11110000b
�������� ������� �����
jmp 0cbh

mov al,0h
��� ������� ��� 2 ������� ���
call 100h
����� �� 2 �������
mov al, 10101000b
������ ������ �� d7-d4(2 �������)
out 45h, al
CW5
mov al,bl
�������������� ������ �������
mov al, 00001111b
�������� ������� �����
call 100h
����� �� 1 ������� 
cmp [16h], 3
��� ������� ��������� (4 ����)
jne 0d5h

mov [16], 0h
��������� CT ������� � �������
jmp 0d6h

inc [16h]
+1 CT
mov dl, bh
�������������� dl
shr dl, 1
����� dl ��� ������� ���� ����
mov al, bl
�������������� ������ �������
dec dh
-1 ����������� ��� � �����
inc ax
+1 ����� �������
cmp dh, 0h
���������� ���� ���� ����� ���?
jnr 0bdh
���� ���, �� � ���� ����
dec cx
-1 ����� ���������� ����
inc si

inc di

cmp cx, 0h
��� ����� �������� ���������?
jne 0bah

mov si, 08h
�� ���������
mov di, 08h
�� ���������
mov cx, 08h
��� ���� ���� �������� (�����)
call copy_ozu
������� ����� ����
pop all

iret

















































push all

push ax

mov al, [16h]
������ ������ �������� ������
and al, 07h

or al, 10000000b
CW ������ � ��� ���������
out 45h, al
CW4
pop ax

out 44h, al
������ a1 � ����
pop all

ret





















































































































































































































































































































































































































































































