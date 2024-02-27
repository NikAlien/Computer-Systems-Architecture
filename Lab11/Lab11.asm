bits 32

global start
extern exit, printf, gets
extern letter_counter

import exit msvcrt.dll
import printf msvcrt.dll
import gets msvcrt.dll

segment data use32 class = data
    len equ 100
    string times len db 0
    w times len db 0
    n dd 0
    
    format_print db "%d ", 0   
    comp equ ' '

segment code use32 class = code
    start:
        
        ; Reading the words from the console  
        
            push dword string
            call [gets]
            add esp, 4
            mov esi, string
            
        read_write:    
            
            mov edi, w
            
            loop_w:
                movsb

                cmp byte[esi], comp
                je next
                
                cmp byte[esi], 0
                je next
            jmp loop_w
            
            next:
            
            movsb
            mov byte[edi], 0
            
            push dword w
            push dword[n]
            call letter_counter
            pop eax
            add esp, 4
            
            push eax
            push dword format_print
            call [printf]
            add esp, 4 * 2
            
            dec edi
            cmp byte[edi], 0
            je final
            
        jmp read_write    
        
    
    final:
    push dword 0
    call [exit]