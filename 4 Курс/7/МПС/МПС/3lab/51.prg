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
4 разр, с ст.разр, декодир
out 45h,al

mov al,11010000b
программный опрос
out 45h,al
CW6->
in al,45h

and al,80h

jnz 015h

mov al,10000000b
AINC=0 адр (RGA ОЗУИ) 0000
out 45h,al
CW4->
xor di,di

mov cx,8h

call clearmem

mov [16h],0
счётчик позиции риндикатора
pop ax

ret





























































































































































































































































































push all

mov al,11100000b
снятие INT
out 45h,al
CW7
mov al,01010000b
уст-ка чтение МОЗУ
out 45h,al
CW2
mov di,08h
адрес начала коп. в ОЗУ
call copy_allmozu
копирование МОЗУ в ОЗУ по 8
mov di,0h
исходное состояние МОЗУ
mov si,08h
текущ состояние МОЗУ(датчиков)
mov cx,08h
кол0во байт МОЗУ
mov ax,0h
код старшего датчика
mov dl,[di]
исходная линейка датчиков
xor dl,[si]
стравниваем с текущим состоянием
mov dh,08h

mov bh,dl
сохранение байта dl
and dl,01h
выделяем первый бит сравнения 
mov bl,al
сохр al
cmp dl,0h
проверка на совп знач датчиков
je 0d6h
если совпал
push ax
сохранение счётчиков датчиков
mov al, 10100100b
запрет на вывод в d3-d0
out 45h,al
CW5
pop ax

cmp ax, 0fh
пров на кол-во цифр в ном датчике
jbe 0cah
если <, то 1 цифра и переход
and al, 11110000b
выделяем старшую цифру
jmp 0cbh

mov al,0h
код пробела для 2 линейки инд
call 100h
вывод на 2 линейку
mov al, 10101000b
запрет записи на d7-d4(2 линейка)
out 45h, al
CW5
mov al,bl
восстановление номера датчика
mov al, 00001111b
выделяем младшую цифру
call 100h
вывод на 1 линейку 
cmp [16h], 3
все позиции заполнены (4 разр)
jne 0d5h

mov [16], 0h
занулкние CT позиции в линейке
jmp 0d6h

inc [16h]
+1 CT
mov dl, bh
восстановление dl
shr dl, 1
сдвиг dl для анализа след бита
mov al, bl
восстановление номера датчика
dec dh
-1 проверенных бит в линии
inc ax
+1 номер датчика
cmp dh, 0h
просмотрен весь байт линии дат?
jnr 0bdh
если нет, то к след биту
dec cx
-1 числа оставщихся байт
inc si

inc di

cmp cx, 0h
все байты датчиков проверены?
jne 0bah

mov si, 08h
ад источника
mov di, 08h
ад приемника
mov cx, 08h
кол байт сост датчиков (линий)
call copy_ozu
обновит исход сост
pop all

iret

















































push all

push ax

mov al, [16h]
запись адреса позициии вывода
and al, 07h

or al, 10000000b
CW записи в ОЗУ индикации
out 45h, al
CW4
pop ax

out 44h, al
запись a1 в ОЗУИ
pop all

ret





















































































































































































































































































































































































































































































