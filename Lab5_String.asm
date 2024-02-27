bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
    s1 db '+', '4', '2', 'a', '8', '4', 'X', '5'
    lens1 equ $ - s1
    
    s2 db 'a', '4', '5'
    lens2 equ $ - s2
    
    three db 3  
    d times lens1 + lens2 db 0    
    
segment code use32 class = code
    start:
    
    mov ecx, lens1 ; ecx = length of first string
    mov esi, 0 ; s1 index
    mov edi, 0 ; d index
    jecxz end_loop ; in case ecx is 0
    add_s1:
        
        mov eax, esi ; move our index into eax (index fits into a byte)
        div byte[three] ; AX / 3 --> remainder in AH
        
        cmp ah, 0 ; compaire remainder to 0
        jne next ; if not equal jump to next
        
        ; else move the element from s1 to d
        mov al, byte[s1 + esi] 
        mov byte[d + edi], al 
        inc edi
        
        next:
        inc esi ; move to next element of s1
        
    loop add_s1
    end_loop:
    
    mov ecx, lens2 ; ecx = length of s2
    mov esi, lens2 - 1 ; s2 index
    jecxz end_loop2
    add_s2:
        
        ; we start from end 
        mov al, byte[s2 + esi] 
        mov byte[d + edi], al
        inc edi
        dec esi
        
    loop add_s2
    end_loop2:
    
    push dword 0
    call [exit]