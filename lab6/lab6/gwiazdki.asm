.386
rozkazy SEGMENT use16
		ASSUME cs:rozkazy
		apple_x dw ? ; Pozycja jab³ka (x)
apple_y db ? ; Pozycja jab³ka (y)

		generate_apple PROC
    ; Losowanie X
    mov ah, 2
    int 1Ah
    mov al, dl ; Losowa wartoœæ w DL
    and al, 157 ; Ograniczenie szerokoœci planszy (0-157)
    mov cs:apple_x, ax

    ; Losowanie Y
    mov ah, 2
    int 1Ah
    mov al, dl
    and al, 25 ; Ograniczenie wysokoœci planszy (0-25)
    mov cs:apple_y, al

    ; Wyœwietlanie jab³ka w pamiêci wideo
    mov ax, 0B800h
    mov es, ax
    mov bx, cs:apple_x
    mov al, cs:apple_y
    mov cl, 160
    mul cl
    add bx, ax

    mov al, 'A' ; Symbol jab³ka
    mov BYTE PTR es:[bx], al
    mov BYTE PTR es:[bx+1], 01000100b ; Kolor czerwony
    ret
generate_apple ENDP



wyswietl_AL PROC

ret
wyswietl_AL ENDP

obsluga_zegara PROC
	push ax
	push bx
	push dx
	push es
	mov dx, 0
	mov ax, 0B800h
	mov es,ax
	mov bx,0
	sub cs:timer,DWORD PTR 1
	jnz wysw_dalej
	mov cs:timer,DWORD PTR 3

	mov ax,cs:pos_x
	mov cl,2
	div cl
	mov bx,0
	call generate_apple
	call wyswietl_AL
	mov al,cs:pos_y
	mov bx,8
	call wyswietl_AL

	mov bx,cs:pos_x
	mov al,cs:pos_y
	mov cl,160
	mul cl
	add bx,ax

	cmp cs:pos_y,0
	jbe stop
	cmp cs:pos_y,25
	jae stop
	cmp cs:pos_x,0
	jbe stop
	cmp cs:pos_x,157
	jae stop
	
	jmp nie_stop
	stop:
	mov cs:exit,1
	nie_stop:

	mov al,' '
	mov BYTE ptr es:[bx],al
	mov BYTE PTR es:[bx+1], 00100000b
	
	mov bx,0
	mov ax,cs:pos_x
	add ax,cs:d_x
	mov cs:pos_x,ax

	mov al,cs:pos_y
	add al,cs:d_y
	mov cs:pos_y,al

	mov dx, cs:apple_x
	cmp cs:pos_x, dx
	jne no_apple
	mov dx, cs:apple_y
	cmp cs:pos_y, dx
	jne no_apple
	mov ax, 0B800h
    mov es, ax
    mov bx, cs:apple_x
    mov al, cs:apple_y
    mov cl, 160
    mul cl
    add bx, ax
	mov al, ' '
	mov BYTE ptr es:[bx],al
	mov BYTE PTR es:[bx+1], 00100000b
	no_apple:

wysw_dalej:

	pop es
	pop dx
	pop bx
	pop ax

	jmp dword PTR cs:wektor8

	pos_x dw 50;pozycja ogolna x
	pos_y db 10;pozycja ogolna y
	d_x dw 0;zmiana pozycji x 
	d_y db 0;zmiana pozycji y
	timer dw 18
	wektor8 dd ?
obsluga_zegara ENDP

obsluga_klawiatury PROC
	push ax
	push bx
	push es
	mov ax, 0B800h
	mov es,ax
	mov bx,0
	in al,60h
	cmp al,72
	jne nie_gora
	mov cs:d_x,0
	mov cs:d_y,-1
	nie_gora:
	cmp al,80
	jne nie_dol
	mov cs:d_x,0
	mov cs:d_y,1
	nie_dol:
	cmp al,75
	jne nie_lewo
	mov cs:d_x,-2
	mov cs:d_y,0
	nie_lewo:
	cmp al,77
	jne nie_prawo
	mov cs:d_x,2
	mov cs:d_y,0
	nie_prawo:
	cmp al,1
	jne obs_dalej
	mov cs:exit, DWORD PTR 1
obs_dalej:
	pop es
	pop bx
	pop ax
	jmp dword PTR cs:wektor9
	wektor9 dd ?
	exit dw 0
obsluga_klawiatury ENDP

zacznij:
mov al,0
mov ah,5
int 10

mov ax,03h
int 10h

;obsluga przerwan zegara
mov ax,0
mov ds,ax

mov eax,ds:[32]
mov cs:wektor8, eax

mov ax,SEG obsluga_zegara
mov bx,OFFSET obsluga_zegara
cli

mov ds:[32],bx
mov ds:[34],ax
sti
;obsluga przerwan klawiatury
mov ax,0
mov ds,ax
mov eax,ds:[36]
mov cs:wektor9,eax

mov ax,SEG obsluga_klawiatury
mov bx,OFFSET obsluga_klawiatury
cli
mov ds:[36],bx
mov ds:[38],ax
sti

ptl: 
cmp cs:exit,1
jnz ptl
;koniec programu
mov eax,cs:wektor9
cli
mov ds:[36],eax
sti

mov eax,cs:wektor8
cli
mov ds:[32],eax
sti

mov ax,03h
int 10h

mov al,0
mov ah,4Ch
int 21h
rozkazy ENDS

nasz_stos SEGMENT stack
	db 128 dup (?)
nasz_stos ENDS

END zacznij