; Task 1.2 - Interactive addition program
; Gets two numbers from user, adds them and displays result

%include "asm_io.inc"

segment .data
    prompt1     db "Enter a number: ", 0
    prompt2     db "Enter second number: ", 0
    message1    db "You entered ", 0
    message2    db " and ", 0
    message3    db ", sum of these: ", 0

segment .bss
    input1      resd 1      ; stores first number
    input2      resd 1      ; stores second number

segment .text
    global asm_main

asm_main:
    enter   0,0
    pusha

    ; Get first number
    mov     eax, prompt1
    call    print_string
    call    read_int
    mov     [input1], eax       ; save in memory

    ; Get second number
    mov     eax, prompt2
    call    print_string
    call    read_int
    mov     [input2], eax       ; save in memory

    ; Calculate sum
    mov     eax, [input1]
    add     eax, [input2]       ; eax = input1 + input2
    mov     ebx, eax            ; keep sum in ebx

    ; Debug output - shows register and memory state
    dump_regs 1
    dump_mem 2, message1, 1

    ; Display results
    mov     eax, message1
    call    print_string
    
    mov     eax, [input1]       ; print first number
    call    print_int
    
    mov     eax, message2
    call    print_string
    
    mov     eax, [input2]       ; print second number
    call    print_int
    
    mov     eax, message3
    call    print_string
    
    mov     eax, ebx            ; print sum
    call    print_int
    call    print_nl

    popa
    mov     eax, 0
    leave
    ret