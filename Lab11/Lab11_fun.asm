bits 32

global letter_counter
extern start

segment data use32 class = data

segment code use32 class = code
letter_counter:

    ; Else check for lowercase letters
            mov ecx, 100
            mov ebx, [esp + 8]
            mov eax, [esp + 4]
            letter:
                
                cmp byte[ebx], 0
                je next
                
                cmp byte[ebx], ' '
                je next
                
                inc eax
                inc ebx
                
            loop letter
        next:    
        mov dword[esp + 4], eax

ret