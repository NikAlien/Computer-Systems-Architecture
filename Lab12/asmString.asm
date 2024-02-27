bits 32
global _asmString

segment data public data use32

segment code public code use32
_asmString:
       
        push ebp
        mov ebp, esp
       
        mov esi, [ebp + 8]
        mov edi, [ebp + 12]
       
        lower_case:
            
            cmp byte[esi], 'a'
            jl not_low
            
            cmp byte[esi], 'z'
            jg not_low
            
            mov al, byte[esi]
            mov byte[edi], al
            inc edi
            
            not_low:
            inc esi
            
            cmp byte[esi], 0
            je  next
            
        jmp lower_case
        
        next:
        mov byte[edi], 0
        mov esi, [ebp + 8]
        mov edi, [ebp + 16]
       
        upper_case:
            
            cmp byte[esi], 'A'
            jl not_up
            
            cmp byte[esi], 'Z'
            jg not_up
            
            mov al, byte[esi]
            mov byte[edi], al
            inc edi
            
            not_up:
            inc esi
            
            cmp byte[esi], 0
            je  final
            
        jmp upper_case
        
        final:
        mov byte[edi], 0
        mov esp, ebp
        pop ebp
       
ret