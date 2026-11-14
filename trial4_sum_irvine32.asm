TITLE Sum of Integers                    (trial4_sum_irvine32.asm)
; Reads COUNT integers from the keyboard, adds them with a counted
; loop, and displays the total. Uses the Irvine32 library for I/O.

INCLUDE Irvine32.inc

COUNT = 3                                ; how many integers to read

.data
prompt     BYTE    "Enter an integer: ", 0
resultMsg  BYTE    "The sum is: ", 0
total      SDWORD  0                     ; running total (signed)

.code
main PROC
    mov  total, 0                        ; start the total from zero
    mov  ecx, COUNT                      ; one loop pass per integer

readNext:
    mov  edx, OFFSET prompt              ; ask the user for a number
    call WriteString
    call ReadInt                         ; EAX = number typed by the user
    add  total, eax                      ; add it to the running total
    loop readNext                        ; ECX - 1, repeat while not zero

    mov  edx, OFFSET resultMsg           ; label the result on screen
    call WriteString
    mov  eax, total                      ; WriteInt displays the value in EAX
    call WriteInt
    call Crlf                            ; move to a new line

    exit                                 ; return to the operating system
main ENDP
END main
