.386
.model	flat
	extrn		GetLogicalDriveStringsA:	dword
	extern	MessageBoxA:			dword
	extern	ExitProcess:			dword
.code
_start:
	mov	eax,	offset	uSize
	mov	eax,	260
	push	offset	lpBuffer
	push	offset	uSize
	call	GetLogicalDriveStringsA
	push	40h
	push	offset	App
	push	offset	lpBuffer
	push	0
	call	MessageBoxA
	push	0
	call	ExitProcess
.data
	App		db	'PE Linker Test',	0
	lpBuffer	db	260	dup(0)
	uSize		dw	0
end	_start
	