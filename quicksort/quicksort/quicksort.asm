.686
.model flat

public _quicksort 
public _partition 
public _swap 


.code

_swap PROC
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp + 8] ;pierwszy element
	mov edx, [ebp + 12] ;drugi element

	mov ecx, [eax]
	mov ebx, [edx]

	mov [eax], ebx
	mov [edx], ecx

	popa
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
	push ecx
	push eax

	mov eax, [ebp + 8] ;adres tablicy
	;[ebp + 12] ;low
	mov edx, [ebp + 16] ;high

	mov ebx, [eax + edx * 4] ;pivot

	mov edi, [ebp+12] ;low - 1
	sub edi, 1 ;indeks elementu mniejszego od pivotu do zamiany

	mov ecx, [ebp + 12] ;indeks petli
petla:
	cmp [eax + ecx * 4], ebx ;porownanie elementu z pivotem
	jge dalej ;jezeli element >= pivot to dalej

	inc edi

	push esi
	lea esi, [eax + edi * 4]
	push esi
	lea esi, [eax + ecx * 4]
	push esi
	call _swap;wymiana elementow, dodatkowe push esi i pop esi zeby zapamietac wartosc
	add esp, 8
	pop esi


dalej:
	mov esi, edx
	dec esi
	cmp ecx, esi ;trzeba sprawdzic czy indeks <= high - 1, esi uzyty jako high - 1
	lea ecx, [ecx + 1] ;zwiekszenie indeksu petli bez zmiany flag
	jle petla

	push esi
	lea esi, [eax + edi * 4 + 4] ;arr[i+1]
	push esi
	lea esi, [eax + edx * 4] ;arr[high]
	push esi
	call _swap ;wymiana elementow, dodatkowe push esi i pop esi zeby zapamietac wartos
	add esp, 8
	pop esi

	mov edx, edi
	add edx, 1 ;zwroc indeks pivotu w edx

	pop eax
	pop ecx
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

	cmp ecx, ebx ;jesli low >= high to koniec
	jge koniec

	push ebx
	push ecx
	push eax
	call _partition ;wywolanie funkcji partition
	add esp, 12 ;pivot w edx

	dec edx
	push edx
	push ecx
	push eax
	call _quicksort ;wywolanie funkcji quicksort dla lewej czesci
	add esp, 12
	inc edx

	inc edx
	push ebx
	push edx
	push eax
	call _quicksort ;wywolanie funkcji quicksort dla prawej czesci
	add esp, 12
	dec edx

koniec:
	pop ebx
	mov esp, ebp
	pop ebp
	ret
_quicksort ENDP
END
