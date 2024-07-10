.386
.model	flat
	extrn		GetKeyboardType:		dword
	extern	MessageBoxA:		dword
	extern	ExitProcess:		dword
.code
_start:
	push	offset	nTypeFlag
	push	0
	call	GetKeyboardType
	push	40h
	push	offset	App
	push	offset	msg
	push	offset	nTypeFlag
	push	0
	call	MessageBoxA
	push	0
	call	ExitProcess
.data
	App	db	'PE Linker Test',	0
	msg	db	'Type:',	0
	nTypeFlag	dw	0
end	_start
	