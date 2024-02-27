; Problem statement:
; Given the quadword A, obtain the integer number N represented on the bits 17-19 of A. Then obtain the the doubleword B by rotating the high doubleword of A, N positions to the left. Obtain the byte C as follows:
; the bits 0-2 of C are the same as the bits 9-11 of B
; the bits 3-7 of C are the same as the bits 20-24 of B
bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
    a dq 8525EA15A25Eh  ;1000 0101(a+5) 0010 0101(a+4) 1110 1010(a+3) 0001 {010}1(a+2) 1010 0010(a+1) 0101 1110b(a) 
    n db 0
    b dd 0
    c db 0

segment code use32 class = code
    start:
        
        ; A is a quadword 
        ; We obtain N - int, that is represented on the 17-19 bits of A
        
        
        ; we only work with the low dword(32) -> high word(16) -> low byte(8)
        
        mov al, [a + 2] ; we get 15h in AL (0001 0101b)
        and al, 00001110b ; we isolate the 17-19 bits of A -> 0000 0100b (04h)
        shr al, 1 ; we shift our result by 1 bit to right so we get 0000 0010b (02h)
        mov [n], al ; we got the int nr. N       
        
        
        ; we obtain the the doubleword B by rotating the high doubleword of A, N positions to the left
        
        ; high dword of A starts at [a + 4]  --> 0000 0000 0000 0000 1000 0101 0010 0101b (00008525h)
        mov eax, [a + 4]
        mov cl, [n] ; we move n in cl as we can't use a memory location with rol
        rol eax, cl ; we rotate eax to the left --> 0000 0000 0000 0010 0001 0100 1001 0100b (00021494h)
        mov [b], eax ; we got the dword B
        
        
        ; we obtain byte C
        
        ; the bits 0-2 of C are the same as the bits 9-11 of B
        ; 0000 0000 0000 0010 0001 {010}0 1001 0100b (00021494h)
        mov bx, 0 ; we inatialyze BX because we're gonna work with it later
        
        mov al, [b + 1] ; we take the high byte of the low word -> 0001 0100b (14h)
        and al, 00001110b; we isolate the neede bits -> 0000 0100b (04h)
        shr al, 1 ; we shift left to get the bits on their right positions in the byte -> 0000 0010b (02h)
        mov bl, al ; we move al in bl to store the curent result
        
        ; the bits 3-7 of C are the same as the bits 20-24 of B
        ; 0000 000{0 0000} 0010 0001 0100 1001 0100b (00021494h)
        mov ax, [b + 2] ; we take the high word -> 0000 0000 0000 0010b (0002h)
        and ax, 000000011110000b; we isolate the needed bits -> 0000 0000 0000 0000b (0000h)
        shr ax, 1; we shift them by 1 bit to put them in the right positions 
        or ax, bx; we put all the neccessary bits together 
        mov [c], al; we obtain byte C
        
        
    
    push dword 0
    call [exit]