.686
.model flat

public _objetosc

.data
dwa dd 2.0

.code
_objetosc PROC;program liczy objetosc akwarium
	push ebp
	mov ebp, esp
	finit
	;[ebp+24] - margines
	;[ebp+20] - grubosc
	;[ebp+16] - dlugosc
	;[ebp+12] - wysokosc
	;[ebp+8] - szerokosc


	fld dword ptr [ebp+16];pomniejsz dlugosc o grubosc szkla
	fld dword ptr [ebp+20]
	fld dword ptr dwa
	fmulp st(1), st(0)
	fsubp st(1), st(0)
	fstp dword ptr [ebp+16];odsylanie gotowej wartosci

	fld dword ptr [ebp+12];pomniejsz wysokosc o grubosc szkla i margines
	fld dword ptr [ebp+20]
	fsubp st(1), st(0)
	fld dword ptr [ebp+24]
	fsubp st(1), st(0)
	fstp dword ptr [ebp+12];odsylanie gotowej wartosci

	fld dword ptr [ebp+8];pomniejsz szerokosc o grubosc szkla
	fld dword ptr [ebp+20]
	fld dword ptr dwa
	fmulp st(1), st(0)
	fsubp st(1), st(0)
	fstp dword ptr [ebp+8];odsylanie gotowej wartosci

	fld dword ptr [ebp+16]
	fld dword ptr [ebp+12]
	fld dword ptr [ebp+8]

	fmulp st(1), st(0);liczenie objetosci
	fmulp st(1), st(0)

	

	pop ebp
	ret


_objetosc ENDP

end


