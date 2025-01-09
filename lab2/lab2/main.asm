.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
extern __read : PROC
public _main

.data
slowo db 'PRACA'
tekst_output db 10,'Pierwsze slowo: PRACA',10
koniec_tekstu db ?
magazyn db 6 dup (?)
liczba_znakow dd ?
roznice_liter dd 0
zapamietaj_indeks dd 0
digit_msg db '0', 10, 0              

.code
_main proc
    ; liczba znakow tekstu
    mov ecx, (OFFSET koniec_tekstu) - (OFFSET tekst_output)
    
    ; tekst output
    push ecx
    push OFFSET tekst_output
    push 1
    call __write
    add esp, 12
jeszcze_raz:
    ; tekst input
    push 6
    push OFFSET magazyn
    push 0
    call __read
    add esp, 12

    mov liczba_znakow, eax

    mov ecx, eax
    mov ebx, 0 ; indeks pocz¹tkowy inputu
    mov edi, 0;indeks poczatkowy slowa
    mov edx, 0;eax-liczenie ile liter sie rozni
    mov al, 0;-przepisywanie liter slowa

ptl: 
    mov al, slowo[edi]
    cmp al, magazyn[ebx]
     je dalej
     mov zapamietaj_indeks, edi

     inc edi
     cmp 

     inc edx
    dalej: inc ebx ; inkrementacja indeksu
            inc edi;
 loop ptl ; sterowanie pêtl¹

    add dl, 30H
    mov digit_msg, dl
    mov BYTE PTR [digit_msg + 1], 0Ah ;enter

 push 2
 push OFFSET digit_msg
 push 1
 call __write ; wyœwietlenie przekszta³conego
 add esp, 12 ; usuniecie parametrów ze stosu


 mov esi, OFFSET magazyn   ; WskaŸnik na magazyn (Ÿród³o)
    mov edi, OFFSET slowo     ; WskaŸnik na slowo (cel)
    mov ecx, 5                ; Liczba bajtów do skopiowania (5 liter)

kopiuj:
    mov al, [esi]             ; Pobierz bajt z magazyn
    mov [edi], al             ; Zapisz bajt do slowo
    inc esi                   ; PrzejdŸ do kolejnego bajtu w magazyn
    inc edi                   ; PrzejdŸ do kolejnego bajtu w slowo
    loop kopiuj               ; Powtarzaj a¿ ecx == 0

 jmp jeszcze_raz

    ; zakonczenie programu
    push 0
    call _ExitProcess@4

_main endp
END
