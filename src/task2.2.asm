; Task 2.2 - Personalized welcome message program
; Gets user's name and a number, then prints welcome message that many times
; The number must be between 51 and 99

%include "asm_io.inc"

segment .data
    prompt_name    db "Enter your name: ", 0
    prompt_count   db "Enter repeat count (between 51 and 99): ", 0
    welcome_msg1   db ". Welcome to the program, ", 0
    welcome_msg2   db "!", 0
    error_msg_low  db "Error: Count is less than or equal to 50. Termination.", 0
    error_msg_high db "Error: Count is greater than or equal to 100. Termination.", 0

segment .bss
    repeat_count   resd 1      ; stores how many times to print
    user_name      resb 100    ; buffer for the user's name

segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha

get_name:
    ; Get user's name
    mov     eax, prompt_name
    call    print_string

    ; Read name character by character until Enter is pressed
    mov     edi, user_name         ; edi points to start of name buffer

read_name_loop:
    call    read_char              ; read one character into al
    cmp     al, 10                 ; check if it's newline (Enter key = ASCII 10)
    je      name_done              ; if Enter, stop reading

    mov     [edi], al              ; store character in buffer
    inc     edi                    ; move to next position
    jmp     read_name_loop         ; read next character

name_done:
    mov     byte [edi], 0          ; add null terminator at end of string
    
    ; Check if name is empty (user just pressed Enter without typing)
    mov     eax, user_name
    cmp     byte [eax], 0          ; check if first character is null terminator
    je      get_name               ; if empty, ask for name again

    ; Get repeat count
    mov     eax, prompt_count
    call    print_string
    call    read_int               ; read number into eax
    mov     [repeat_count], eax

    ; Validate the count - must be between 51 and 99
    ; Check if count <= 50
    mov     eax, [repeat_count]
    cmp     eax, 50
    jle     error_low              ; jump to error if too low

    ; Check if count >= 100
    mov     eax, [repeat_count]
    cmp     eax, 100
    jge     error_high             ; jump to error if too high

    ; Count is valid - print messages
    mov     ecx, [repeat_count]    ; ecx is loop counter (counts down)
    mov     ebx, 1                 ; ebx is message number (counts up: 1, 2, 3...)

print_loop:
    ; Print message number
    mov     eax, ebx
    call    print_int

    ; Print ". Welcome to the program, "
    mov     eax, welcome_msg1
    call    print_string

    ; Print user's name
    mov     eax, user_name
    call    print_string

    ; Print "!"
    mov     eax, welcome_msg2
    call    print_string

    ; New line
    call    print_nl

    ; Increment message number for next iteration
    inc     ebx

    ; Loop decrements ecx and jumps back if ecx != 0
    loop    print_loop

    jmp     end_program            ; all done

error_low:
    mov     eax, error_msg_low
    call    print_string
    call    print_nl
    jmp     end_program

error_high:
    mov     eax, error_msg_high
    call    print_string
    call    print_nl
    jmp     end_program

end_program:
    popa
    mov     eax, 0
    leave
    ret

; Example output:
; Enter your name: Alice
; Enter repeat count (between 51 and 99): 53
; 1. Welcome to the program, Alice!
; 2. Welcome to the program, Alice!
; ... (continues 53 times)