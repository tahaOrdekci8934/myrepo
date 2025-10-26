; Task 1.1 - Adding two numbers
; This program adds two numbers stored in memory and prints the result

%include "asm_io.inc"

segment .data
    num1        dd 10               ; first number
    num2        dd 25               ; second number
    result_msg  db "The sum is: ", 0

segment .bss
    result      resd 1              ; variable to store the sum

segment .text
    global asm_main

asm_main:
    enter   0,0
    pusha

    ; Load first number into EAX
    mov     eax, [num1]
    
    ; Add second number to EAX
    add     eax, [num2]             ; EAX now has num1 + num2
    
    ; Save result in memory
    mov     [result], eax

    ; Print message
    mov     eax, result_msg
    call    print_string
    
    ; Print the sum
    mov     eax, [result]
    call    print_int
    call    print_nl                ; newline

    ; Clean up and return
    popa
    mov     eax, 0
    leave
    ret