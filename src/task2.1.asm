; Task 2.1 - Prime number finder
; This program finds all prime numbers up to a limit entered by the user
; A prime number is only divisible by 1 and itself

%include "asm_io.inc"

segment .data
    prompt      db "Find primes up to: ", 0

segment .bss
    limit       resd 1      ; upper limit for finding primes
    candidate   resd 1      ; number being tested
    divisor     resd 1      ; number we divide by

segment .text
    global asm_main

asm_main:
    enter   0,0
    pusha

    ; Get limit from user
    mov     eax, prompt
    call    print_string
    call    read_int
    mov     [limit], eax

    ; Start checking from 2 (first prime number)
    mov     dword [candidate], 2

check_next_number:
    ; Check if we've tested all numbers
    mov     eax, [candidate]
    cmp     eax, [limit]
    jg      finished            ; done if candidate > limit

    ; Try to find if candidate has any divisors
    ; Start testing from 2
    mov     dword [divisor], 2

try_next_divisor:
    ; Have we checked all possible divisors?
    mov     eax, [divisor]
    cmp     eax, [candidate]
    jge     is_prime            ; if divisor >= candidate, no divisors found = prime

    ; Test if candidate is divisible by current divisor
    mov     eax, [candidate]
    mov     edx, 0              ; clear edx for division
    mov     ebx, [divisor]
    div     ebx                 ; eax = candidate / divisor, edx = remainder

    ; Check remainder
    cmp     edx, 0
    je      not_prime           ; if remainder is 0, it's divisible = not prime

    ; Try next divisor
    inc     dword [divisor]
    jmp     try_next_divisor

is_prime:
    ; This number is prime, print it
    mov     eax, [candidate]
    call    print_int
    call    print_nl

    ; Check next number
    inc     dword [candidate]
    jmp     check_next_number

not_prime:
    ; This number is not prime, skip to next
    inc     dword [candidate]
    jmp     check_next_number

finished:
    popa
    mov     eax, 0
    leave
    ret

; How it works:
; For each number from 2 to limit:
;   - Try dividing by all numbers from 2 to (number-1)
;   - If any division has remainder 0, it's not prime
;   - If no division has remainder 0, it's prime!