.686
.model flat

_quicksort public
_partition public
_swap public


.code

_swap PROC
	push ebp
	mov ebp, esp
	push ebx
	
	mov eax, [ebp + 8] ;pierwszy element
	mov edx, [ebp + 12] ;drugi element

	mov ecx, [eax]
	mov ebx, [edx]

	mov [eax], ebx
	mov [edx], ecx

	pop ebx
	mov esp, ebp
	pop ebp
	ret
_swap ENDP


_partition PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov eax, [ebp + 8] ;adres tablicy
	mov ecx, [ebp + 12] ;low
	mov edx, [ebp + 16] ;high

	mov ebx, [eax + edx * 4] ;pivot

	mov edi, ecx
	sub edi, 1 ;indeks elementu mniejszego od pivotu do zamiany

petla:
	cmp [eax + ecx * 4], ebx ;porownanie elementu z pivotem
	jge dalej ;jezeli element >= pivot to dalej

	inc edi
	push [eax + edi * 4]
	push [eax + ecx * 4]
	call swap;wymiana elementow
	add esp, 8


dalej:
	dec edx
	cmp ecx, edx ;trzeba sprawdzic czy low < high - 1, inc i dec nie zmienia flag
	inc edx
	jbe petla

	push [eax + edi * 4 + 4] ;arr[i+1]
	push [eax + edx * 4] ;arr[high]
	call swap ;wymiana elementow
	add esp, 8

	mov edx, edi
	add edx, 1 ;zwroc indeks pivotu w edx


	pop esi
	pop edi
	pop ebx
	mov esp, ebp
	pop ebp
	ret
_partition ENDP

_quicksort PROC
	push ebp
	mov ebp, esp
	push ebx

	mov eax, [ebp + 8] ;adres tablicy
	mov ecx, [ebp + 12] ;low
	mov ebx, [ebp + 16] ;high

	cmp ecx, edx ;jesli low >= high to koniec
	jae end

	push ebx
	push ecx
	push eax
	call partition ;wywolanie funkcji partition
	add esp, 12 ;pivot w edx

	dec edx
	push edx
	push ecx
	push eax
	call quicksort ;wywolanie funkcji quicksort dla lewej czesci
	add esp, 12
	inc edx

	inc edx
	push ebx
	push edx
	push eax
	call quicksort ;wywolanie funkcji quicksort dla prawej czesci
	add esp, 12
	dec edx

end:
	pop ebx
	mov esp, ebp
	pop ebp
	ret
_quicksort ENDP
END