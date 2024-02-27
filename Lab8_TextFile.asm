;Problem statement: A file name (defined in data segment) is given. Create a file with the given name, then read words from the keyboard until character '$' is read. Write only the words that contain at least one lowercase letter to file.

bits 32

global start
extern exit, fopen, fclose, fprintf, scanf

import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class = data
    file db "Laboratory 8.txt", 0
    access_mode db "w", 0
    file_descriptor dd -1
    
    len equ 20
    n times len db 0
    format db "%s", 0
    
    mess db "%s,  ", 0
    comp equ "$"

segment code use32 class = code
    start:
        
        ; Creating the file with the indicated name
        push dword access_mode
        push dword file
        call [fopen]
        
        add esp, 4 * 2
        
        mov [file_descriptor], eax
        cmp eax, 0
        je final
        
        ; Reading the words from the console
        read_write:
            
            push dword n
            push dword format
            call [scanf]
            add esp, 4 * 2
            
            ; Checking if it is "$" if yes leave loop
            cmp word[n], comp
            je close_file
            
            ; Else check fro lowercase letters
            mov ecx, len
            mov esi, 0
            lower_case:
                
                ; If smaller than "a" jump to next element of the word
                cmp byte[n + esi], "a"
                jnge next
                
                ; If greater than "z" jump to next element of the word
                cmp byte[n + esi], "z"
                jnle next
                
                ; If lowercase letter found print it in the file and jump to reading the next word
                push dword n
                push dword mess
                push dword [file_descriptor]
                call [fprintf]
                add esp, 4 * 2
                jmp next2
                
                ; Next letter in the word
                next:
                inc esi
                
            loop lower_case
            
        next2:    
        jmp read_write
        
        ; Close file 
        close_file:
        push dword [file_descriptor]
        call[fclose]
        add esp, 4
        
    
    final:
    push dword 0
    call [exit]