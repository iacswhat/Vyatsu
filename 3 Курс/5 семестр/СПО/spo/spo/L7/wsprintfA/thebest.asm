.386

.model flat, stdcall

	extrn MessageBoxA:	dword
	extrn ExitProcess:	dword
	extrn  wsprintfA:DWORD

.data
	App		db 'PE Linker Test', 0
	msg1		db 'Type: %u', 0
	nTypeFlag	dd 100


	Result db 50 dup(?)


.code

_start:
	push	nTypeFlag
	push	offset msg1
	push	offset Result
	CALL wsprintfA 
	
	push	40h
	push 	offset App
	push	offset Result
	push	0h
	call	MessageBoxA

	push	0
	call	ExitProcess

end _start