TITLE Sum of Three Integers              (Trial4.asm)
; Reads three integers from the keyboard and displays their sum.
; Demonstrates the Irvine32 library procedures and a counted loop.
;
; Author : Mouhammed Al-Bachir Youmbai, Moulay Saaid Reggani
; Group  : Lab group 2 (study groups 1 and 4)

INCLUDE Irvine32.inc

.data
prompt   BYTE "Enter an integer: ",0
result   BYTE "The sum is: ",0
total    SDWORD ?

.code
main PROC
    mov  ecx, 3                          ; how many numbers to read
    mov  ebx, 0                          ; running total starts at zero

ReadLoop:
    mov  edx, OFFSET prompt              ; ask the user for a number
    call WriteString
    call ReadInt                         ; EAX = value typed by the user
    add  ebx, eax                        ; add it to the running total
    loop ReadLoop                        ; ECX - 1, repeat until it reaches zero

    mov  total, ebx                      ; save the final sum in memory
    mov  edx, OFFSET result              ; label the result on screen
    call WriteString
    mov  eax, total                      ; WriteInt displays the value in EAX
    call WriteInt
    call Crlf                            ; move to the next line

    exit
main ENDP
END main

; Extension: to read five integers instead of three, change only the
; first line of main to  mov ecx, 5
