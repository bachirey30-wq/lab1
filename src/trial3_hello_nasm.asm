; trial3_hello_nasm.asm - prints a message, assembled with NASM into a 16-bit .com file
;
; Assemble with:  nasm -f bin src/trial3_hello_nasm.asm -o hello.com
;
; Author : Mouhammed Al-Bachir Youmbai, Moulay Saaid Reggani
; Group  : Lab group 2 (study groups 1 and 4)

BITS 16
ORG  0x100                               ; .com files load at offset 100h

section .text
    mov  ah, 09h                         ; DOS print-string function
    mov  dx, message                     ; DX = address of the text to print
    int  21h                             ; ask DOS to display it

    mov  ah, 4Ch                         ; terminate program
    int  21h                             ; return control to DOS

section .data
message  db  'Hello from NASM!', 0Dh, 0Ah, '$'
