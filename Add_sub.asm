;Problem statement: a+b-c+d
bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
    a db 89
    b db 10
    c db 59
    d db 11

segment code use32 class = code
    start:
        
        ;a+b
        mov al, byte[a]
        add al, byte[b]   ;a + b ---> al
        
        ;a+b-c
        sub al, byte[c]   ;a + b - c ---> al
        
        ;a+b-c+d
        add al, byte[d]   ;a + b - c + d ---> al
        
        ;Result ---> AL
        
    push dword 0
    call [exit]
