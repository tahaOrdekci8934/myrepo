; Task 2.4 - Array range sum program
; Extension of 2.3 - lets user specify a range to sum instead of summing all elements
; User enters start and end indices (0-99) and program sums that range

%include "asm_io.inc"

segment .data
    prompt_start   db "Enter start index (0-99): ", 0
    prompt_end     db "Enter end index (0-99): ", 0
    result_msg     db "Sum of range: ", 0
    error_start    db "Error: Start index out of range (must be 0-99).", 0
    error_end      db "Error: End index out of range (must be 0-99).", 0
    error_order    db "Error: Start index must be less than or equal to end index.", 0

segment .bss
    array          resd 100    ; array of 100 dwords
    start_idx      resd 1      ; start of range
    end_idx        resd 1      ; end of range
    sum            resd 1      ; result

segment .text
global asm_main
asm_main:
    enter 0,0
    pusha

    ; Initialize array with values 1 to 100
    mov ecx, 100               ; counter
    mov edi, array             ; pointer to array
    mov eax, 1                 ; starting value

init_array_loop:
    mov [edi], eax             ; store value
    add edi, 4                 ; next position
    inc eax                    ; next value
    loop init_array_loop

get_start_index:
    ; Get start index
    mov eax, prompt_start
    call print_string
    call read_int
    mov [start_idx], eax

    ; Validate start index (0-99)
    cmp eax, 0
    jl invalid_start           ; if < 0, show error and ask again
    cmp eax, 99
    jg invalid_start           ; if > 99, show error and ask again
    jmp get_end_index          ; valid, continue to end index

invalid_start:
    mov eax, error_start
    call print_string
    call print_nl
    jmp get_start_index        ; ask again

get_end_index:
    ; Get end index
    mov eax, prompt_end
    call print_string
    call read_int
    mov [end_idx], eax

    ; Validate end index (0-99)
    cmp eax, 0
    jl invalid_end
    cmp eax, 99
    jg invalid_end
    jmp check_range_order      ; valid, check if start <= end

invalid_end:
    mov eax, error_end
    call print_string
    call print_nl
    jmp get_end_index          ; ask again

check_range_order:
    ; Check that start <= end
    mov eax, [start_idx]
    mov ebx, [end_idx]
    cmp eax, ebx
    jg invalid_order           ; if start > end, show error and ask again
    jmp calculate_sum          ; valid range, proceed to calculation

invalid_order:
    mov eax, error_order
    call print_string
    call print_nl
    jmp get_start_index        ; ask for both indices again

calculate_sum:

    ; Calculate sum of range
    mov dword [sum], 0         ; initialize sum
    mov ecx, [start_idx]       ; current index
    mov edx, [end_idx]         ; end index

sum_loop:
    ; Calculate address: array base + (index * 4)
    mov eax, ecx               ; current index
    shl eax, 2                 ; multiply by 4 (shift left by 2)
    mov ebx, array             ; array base address
    add ebx, eax               ; ebx now points to array[index]

    ; Add element to sum
    mov eax, [ebx]             ; get array[index]
    add [sum], eax             ; add to sum

    ; Move to next index
    inc ecx
    cmp ecx, edx
    jle sum_loop               ; continue if ecx <= end_idx

    ; Print result
    mov eax, result_msg
    call print_string
    mov eax, [sum]
    call print_int
    call print_nl

    jmp end_program

end_program:
    popa
    mov eax, 0
    leave
    ret

; Example: 
; If user enters start=10, end=20
; Sum will be: array[10] + array[11] + ... + array[20]
; Which is: 11 + 12 + ... + 21 = 176