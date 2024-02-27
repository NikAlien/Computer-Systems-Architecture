;Problem statement: d-(a+b)+(c+c)
;a - byte, b - word, c - double word, d - qword 
;Unsigned representation

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    d dq 200
    a db 12
    b dw 156
    c dd 160

; our code starts here
segment code use32 class=code
    start:
        ;a+b
        mov al, [a]
        mov ah, 0
        add ax, [b]
        
        ;d-(a+b)
        mov ecx, [d+4]
        mov ebx, [d]
        
        mov dx, ax
        mov eax, 0
        mov ax, dx
        mov edx, 0
        
        sub ebx, eax
        sbb ecx, edx
        
        ;c+c
        mov eax, [c]
        add eax, [c]
        
        ;d-(a+b)+(c+c)
        mov edx, 0
        
        add ebx, eax
        adc ecx, edx
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
