;Problem statement: d+10*a-b*c
bits 32 

global start        

extern exit               
import exit msvcrt.dll    

segment data use32 class=data
    a db 25
    b db 16
    c db 10
    d dw 54

segment code use32 class=code
    start:
        ;10*a
        mov AL, 10
        mul byte [a] ;AL * a = 10 * 25 = 250 --> AX
        mov BX, AX ;10 * a --> BX
        
        ;b*c
        mov AL, byte [b]
        mul byte [c] ;AL * c = b * c = 16 * 10 = 160 --> AX
        
        ;d+10*a = 54 + 250 = 304 --> BX
        add BX, word [d]
        
        ;d+10*a-b*c = 304 - 160 = 144 --> BX
        sub BX, AX   
        
        ;result in BX
        push    dword 0      
        call    [exit]       
