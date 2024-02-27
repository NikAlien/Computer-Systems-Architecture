; Problem statement:  Unsigned representation
; x-(a*100+b)/(b+c-1)
;  z=(a*3+b*b*5)/(a*a+a*b)-a-b
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
    b db 200
    c dw 30
    x dq 250


segment code use32 class = code
    start:
    
        ;x-(a*100+b)/(b+c-1)
        
        ;a*100
        mov ax, 100
        mul word[a]  ; a * 100 = 15 * 100 = 1500 --> DX:AX

        ;a*100+b
        mov bl, [b]
        mov bh, 0
        mov cx, 0    ; convert BL --> CX:BX
        
        add ax, bx
        adc dx, cx   ; a * 100 + b = 1500 + 200 = 1700--> DX:AX
        
        ;b+c
        add bx, [c]  ; b + c = 200 + 30 = 230 --> BX
        
        ;b+c-1
        sub bx, 1    ; b + c - 1 = 230 - 1 = 229 --> BX
        
        ;(a*100+b)/(b+c-1)
        push dx
        push ax
        pop eax ; Convert DX:AX --> EAX
        div bx  ; (a*100+b)/(b+c-1) = 1700 / 229 = 7 --> AX
                ; %  = 1700 % 229 = 97 --> DX
                
        ; x-(a*100+b)/(b+c-1)
        mov bx, ax
        mov eax, 0
        mov ax, bx
        mov edx, 0  ; Convert AX --> EDX:EAX
        
        mov ebx, [x]
        mov ecx, [x+4]  ; Move the value from the address x into ECX:EBX
        
        sub ebx, eax
        sbb ecx, edx
    
        ;Result:  250 - 7 = 243 --> ECX:EBX
        
    push dword 0
    call [exit]
