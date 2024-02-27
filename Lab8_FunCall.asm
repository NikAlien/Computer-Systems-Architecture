;Problem statement: Read numbers (in base 10) in a loop until the digit '0' is read from the keyboard. 
;Determine and display the biggest number from those that have been read.

bits 32

global start
extern exit, printf, scanf

import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class = data
    n dd 0
    max dd 0
    
    message1 db "Give number: ", 0
    message2 db "--> ", 0
    message3 db "The biggest number here is %d", 0
    
    format  db "%d", 0

segment code use32 class = code
    start:
        
        ; Print a mssage to the user
        push dword message1
        call [printf]
        add esp, 4 * 1
        
        ; Read numbers until we get '0'
        read:
            
            ; Display a message of a new line
            push dword message2
            call [printf]
            add esp, 4 * 1
            
            ; Reading the number from the keyboard
            push dword n
            push dword format
            call [scanf]
            add esp, 4 * 2
            
            ;Comparing it wiht the current max value
            mov eax, dword [max]
            cmp dword[n], eax
            ; If the current value is not greatr than max than we jump to finish of current loop
            jng finish
            
            ; If number is greater than max than we move the value to max
            mov eax, dword[n]
            mov dword[max], eax
            
            ; Comparing to see if we got '0'
            finish:
            cmp dword[n], 0
            
        jne read
        
        ; Printing the message with the greatest value
        push dword [max]
		push dword message3
        call [printf]
        add esp, 4 * 3
        
    push dword 0
    call [exit]