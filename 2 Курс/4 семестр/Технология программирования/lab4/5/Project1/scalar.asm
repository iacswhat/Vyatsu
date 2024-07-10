

.MODEL FLAT, C

.DATA


.CODE

sc proc C mas: dword, n: dword, num: dword

mov esi, mas
mov eax, num
mul eax
mov ecx, eax

mov eax, 0

l1:
mov eax, [esi]
mov edx, n
imul edx
mov [esi], eax
add esi, type mas
dec ecx
cmp ecx, 0
jne l1


ret
sc endp


end