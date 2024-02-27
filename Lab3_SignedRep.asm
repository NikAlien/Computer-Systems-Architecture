; Problem statement:  Signed representation
; x-(a*100+b)/(b+c-1)
; a-word
; b-byte
; c-word
; x-qword

bits 32

global start

extern exit 
import exit msvcrt.dll

segment data use32 class = data
    a dw 15
    b db -100
    c dw -30
    x dq 250


segment code use32 class = code
    start:
        
        ;x-(a*100+b)/(b+c-1)
        
        ;a*100
        mov ax, 100
        imul word[a]  ; a * 100 = 15 * 100 = 1500 --> DX:AX

        ;a*100+b
        mov cx, dx
        mov bx, ax    ; a  * 100 --> CX:BX
        
        mov al, [b]
        cbw
        cwd           ; Convert b = -100 --> AL --> AX --> DX:AX
        
        add bx, ax
        adc cx, dx   ; a * 100 + b = 1500 - 100 = 1400--> CX:BX
        
        
        ;b+c
        mov al, [b]
        cbw
        add ax, [c]  ; b + c = -100 - 30 = -130 --> AX
        
        ;b+c-1
        sub ax, 1    ; b + c - 1 = -130 - 1 = -131 --> AX
        
        ;(a*100+b)/(b+c-1)
        xchg ax, bx
        mov dx, cx  ; Exchange DX:AX <==> CX:BX  (just BX)
        
        push dx
        push ax
        pop eax ; Convert DX:AX --> EAX
        idiv bx  ; (a*100+b)/(b+c-1) = 1400 / (-131) = -10 --> AX
                ; %  = 1400 % (-131) = 90 --> DX
                
        ; x-(a*100+b)/(b+c-1)
        cwde
        cdq   ; Convert AX --> EDX:EAX
        
        mov ecx, [x+4]
        mov ebx, [x]  ; Move the value from the address x into ECX:EBX
        
        sub ebx, eax
        sbb ecx, edx
    
        ;Result:  250 - (-10) = 260 --> ECX:EBX
        
    push dword 0
    call [exit]
