.386
.model	flat, stdcall
	extrn	MessageBoxA:	dword
	extrn	ExitProcess:	dword
	extrn	GetKeyboardType:	dword
.code
_start:
	push	offset	nTypeFlag
	call	GetKeyboardType
	push	40h
	push	offset	msg
	push	00h
	call	MessageBoxA
	push	00h
	call	ExitProcess
.data
	nTypeFlag	dd	?
	msg db 'Type: ',	0
end _start