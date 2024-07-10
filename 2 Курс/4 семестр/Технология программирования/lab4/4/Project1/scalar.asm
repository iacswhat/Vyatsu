.MODEL FLAT, C

.DATA


.CODE

;слмнфемхе
multy proc mas: dword, n: dword, num: dword


push esi
push edx
push eax

mov esi, dword ptr [ebp + 8]
mov eax, dword ptr [ebp + 16]
mul eax
mov ecx, eax
mov eax, 0

l1:
mov eax, [esi]
mov edx, dword ptr [ebp + 12]
imul edx
mov [esi], eax
add esi, 4
dec ecx
cmp ecx, 0
jne l1

pop eax
pop edx
pop esi



;mov esi, mas
;mov eax, num
;mul eax
;mov ecx, eax
;mov eax, 0

;l1:
;mov eax, [esi]
;mov edx, n
;imul edx
;mov [esi], eax
;add esi, type mas
;dec ecx
;cmp ecx, 0
;jne l1



ret
multy endp

;декемхе
divide proc mas: dword, n: dword, num: dword

push esi
push edx
push eax


mov esi, dword ptr [ebp + 8]
mov eax, dword ptr [ebp + 16]
mul eax
mov ecx, eax
mov eax, 0
mov ebx, dword ptr [ebp + 12]

l1:
mov eax, [esi]

bt eax, 31
jc ll1
jnc ll2

ll2:
mov edx, 0
jmp ll3

ll1:
mov edx, 4294967295

ll3:
idiv ebx
mov [esi], eax
add esi, 4
dec ecx
cmp ecx, 0
jne l1



pop eax
pop edx
pop esi


;mov esi, mas
;mov eax, num
;mul eax
;mov ecx, eax
;mov eax, 0
;mov ebx, n

;l1:

;mov eax, [esi]
;mov edx, 4294967295

;bt eax, 31
;jc ll1
;jnc ll2

;ll2:
;mov edx, 0
;jmp ll3

;ll1:
;mov edx, 4294967295

;ll3:
;idiv ebx
;mov [esi], eax
;add esi, type mas
;dec ecx
;cmp ecx, 0
;jne l1

ret
divide endp

end