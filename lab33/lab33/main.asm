.686
.model flat
public _main
extern _ExitProcess@4 : PROC

.data
stale DW 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
napis DW 10 dup (3), 2
xd dd 254
	  

.code

_main PROC
mov eax, 000000FFh
xor edx, edx

mov ecx, 32
petla:
shl eax, 1
jnc nie_dodaj
inc edx
nie_dodaj:

loop petla

	

push 0
call _ExitProcess@4
_main ENDP
END