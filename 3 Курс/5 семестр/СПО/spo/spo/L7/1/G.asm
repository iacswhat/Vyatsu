.386

.model flat, stdcall
	extrn MessageBoxA:	dword
	extrn ExitProcess:	dword
	extrn GetKeyboardType:	dword
	extrn  wsprintfA:DWORD

.data
	App		db 'PE Linker Test', 0
	msg1		db 'Type: %u', 0
	MsgErr	db 'Error!', 0
	nTypeFlag	dd ?


	Result db 50 dup<?>


.code

_start:

	push	offset nTypeFlag
	call	GetKeyboardType
	cmp	eax, 0h
	je err

	push	nTypeFlag
	push	offset msg1
	push	offest Result
	CALL wsprintfA 
	
	push	40h
	push	offset App
	push	offset Result
	push	0h
	call	MessageBoxA
	jmp	exit


err:
	push	0h
	push	offest App
	push	offset MsgErr
	push	0h
	call	MessageBoxA
exit:
	push	0
	call	ExitProcess

end _start