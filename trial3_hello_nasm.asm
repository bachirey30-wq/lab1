; TITLE Hello from NASM                  (trial3_hello_nasm.asm)
; Prints a greeting with DOS function 09h. Assembled as a flat .COM file:
;   nasm -f bin src/trial3_hello_nasm.asm -o hello.com
; (NASM has no TITLE directive, so the title is written as a comment.)

org 100h                                 ; .COM programs are loaded at offset 100h

section .text
start:
    mov  dx, message                     ; DX = address of the text to print
    mov  ah, 09h                         ; DOS service: print '$'-ended string
    int  21h                             ; ask DOS to display it

    mov  ax, 4C00h                       ; DOS service: end program, code 0
    int  21h                             ; return control to DOS

section .data
message  db  'Hello from NASM!', 0Dh, 0Ah, '$'
