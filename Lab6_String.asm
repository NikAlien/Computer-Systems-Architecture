bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
    string db 0Ch, 38h, 22h, 38h, 4Eh, 5Ah, 0Ah, 38h, 4Eh, 5Ah, 97h
    len_big equ $ - string
                                                                    
    substring db 38h, 4Eh, 5Ah
    len_small equ $ - substring

segment code use32 class = code
    start:
    ; Being given a string of bytes and a substring of this string,
    ; eliminate all occurrences of this substring from the initial string.
    ; Result --> 0Ch, 38h, 22h, 0Ah, 97h
    
    mov ecx, len_big   ; Nr of iterations for this program
    mov esi, string    ; string index
    mov edi, substring ; substring index
    cld    ; clear direction flag
    
    for_fun:
        dec ecx  ; decrement ecx everytime the program moves esi to the next element
        cmpsb  ; compare byte [edi] and [esi] and increment both
        jne not_while ; if not equal move to next element in string
           
        mov ah, len_small - 1 ; if equal check if whole substring is here    ah = len_substring - 1 (because we already checked the first element)
        while_fun:
            
            dec ecx   ; decrement ecx everytime the program moves esi to the next element
            cmpsb     ;  compare byte [edi] and [esi] and increment both
            jne not_while ; if not equal leave this loop
             
            dec ah
            cmp ah, 0
            
        jne while_fun
        

        ; if the substring is in the string
        mov edx, ecx ; ecx also represents how many elements there are still in the string
        
        ; eax - index of where the substring starts in string, esi - index of where the elemenets after substring are
        mov eax, esi 
        sub eax, 3
        mov edi, eax ; remember for esi
        
        move:
            
            ; move elements 
            mov bl, [esi] 
            mov [eax], bl
            inc eax
            inc esi
            
            dec edx
            cmp edx, 0
        
        jne move
        mov esi, edi ; give esi index in string
        
        not_while:
        mov edi, substring ; give edi initial index for substring
    
    cmp ecx, 0
    jne for_fun

    
    push dword 0
    call [exit]