TITLE Register Warm-Up                   (Trial1.asm)
; Demonstrates data transfer and arithmetic between 16-bit registers.
; Run under EMU8086 and single-step with F8 to watch each change.
;
; Author : Mouhammed Al-Bachir Youmbai, Moulay Saaid Reggani
; Group  : Lab group 2 (study groups 1 and 4)

.MODEL SMALL
.STACK 100h
.CODE
main PROC
    mov  ax, 0005h                       ; first operand of the sum
    mov  bx, 0003h                       ; second operand, reused by the SUB
    add  ax, bx                          ; AX = 8, the sum of both operands
    mov  cx, ax                          ; keep a copy of the sum in CX
    sub  cx, bx                          ; CX = 5, takes the second operand back out

    mov  ah, 4Ch                         ; DOS terminate-program function
    int  21h                             ; return control to the OS
main ENDP
END main
