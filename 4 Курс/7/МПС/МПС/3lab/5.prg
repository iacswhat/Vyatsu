189
60
mov al, 00010100b
cw0
out 3Dh, al
загрузка cw0
mov al, 00101011b
cw1, k=11
out 3Dh, al
загрузка cw1
mov al, 11000001b
cw6
out 3Dh, al
загрузка cw6
in al, 3Dh
чтение слова состояния ПККИ
and al, 80h
формирование флага psw в МПС
jnz 06h
ожид записи в ОЗУИ конст гашения
mov al, 10010000b
cw4
out 3Dh, al
загрузка cw4
mov di, 100h
адрес начала очищаемой области
mov cx, 8
8 байт для очистки
call ClearMem
очистка памяти
call Copy_AllMOZU
текущее состояние
nop
основная программа
jmp 0Fh











mov al,11000001b

out 3Dh,al

call Copy_MOZU

ret







































































































































































































































































































































push all
сохранение регистров
mov cx,8

mov di, 108h
базовый адрес копируемого массива
mov al,11000001b

out 3Dh,al

call Copy_MOZU
чтение М-ОЗУ в ОП
mov di, 100h
адрес первой ЯП
mov si, 108h
адрес второй ЯП
xor cx,cx

call Comps
вызов процедуры сравнения
mov ax,bx

test ax,1h

jz 0CBh
если бит изменен
call 100h
вывод
cmp cx,7h
если все биты в строке проверены
jz 0D0h

inc cx
к след биту
shr bx,1
след бит
jmp 0C7h
к проверке изменения бита
mov ax,di

sub ax,100h

cmp ax,7h
проверка окончания всех строк
jz 0D7h
если не окончены
inc di
переход к след строке
inc si
переход к след строке
jmp 0C5h
очередная проверка по новой строк
mov di,100h
проверены все строки
mov si,108h

mov cx,8

call Copy_OZU
копируем данные для след сравнени
mov al,11100000b
снятие запроса на прерывание
out 3Dh,al

pop all
восстановление регистров
iret
возврат


































































mov ax,di
ППОП ОТОБРАЖЕНИЯ
sub ax,100h
формирование старшей цифры
inc al
al:=al+1
shl al,4
сдвиг содержимого al на 4 р <-
or al,cl
формирование младшей цифры
inc al
al:=al+1
out 3Ch, al
запись содержимого al в ОЗУИ
ret
возврат из ПП
























































































































































































































































































































































































































































































