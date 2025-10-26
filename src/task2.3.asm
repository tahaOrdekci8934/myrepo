; Task 2.3 - Array sum program
; Creates an array of 100 elements (values 1 to 100) and calculates the sum

%include "asm_io.inc"

segment .data
    result_msg  db "The sum of numbers from 1 to 100 is: ", 0

segment .bss
    array_size equ 100
    my_array   resd array_size     ; array of 100 dwords
    total_sum  resd 1              ; stores the final sum

segment .text
global asm_main
asm_main:
    enter 0,0
    pusha

    ; Initialize the array with values 1 to 100
    mov ecx, array_size            ; loop counter = 100
    mov ebx, 1                     ; value to store (starts at 1)
    mov esi, my_array              ; esi points to array start

init_loop:
    mov [esi], ebx                 ; store value in current array position
    add esi, 4                     ; move to next dword (4 bytes)
    inc ebx                        ; next value (2, 3, 4...)
    loop init_loop                 ; repeat 100 times

    ; Sum all elements in the array
    mov ecx, array_size            ; reset counter to 100
    mov esi, my_array              ; reset pointer to array start
    mov edx, 0                     ; edx will hold the sum (start at 0)

sum_loop:
    mov eax, [esi]                 ; load current element
    add edx, eax                   ; add to running total
    add esi, 4                     ; move to next element
    loop sum_loop                  ; repeat for all elements

    mov [total_sum], edx           ; save final sum

    ; Print result
    mov eax, result_msg
    call print_string
    
    mov eax, edx                   ; move sum to eax for printing
    call print_int                 ; should print 5050
    call print_nl

    popa
    mov eax, 0
    leave
    ret

; Expected output: The sum of numbers from 1 to 100 is: 5050
; Formula check: sum = n(n+1)/2 = 100(101)/2 = 5050