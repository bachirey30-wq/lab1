TITLE Registers and Flags                (trial1_registers.asm)
; Moves values between registers, performs simple arithmetic, and
; produces specific results so the effect on the flags (ZF, SF, CF,
; OF, PF, AF) can be observed by single-stepping in EMU8086 (F8).

.model small
.stack 100h

.code
main PROC
    mov  ax, 5                           ; first operand of the sum
    mov  bx, 3                           ; second operand of the sum
    add  ax, bx                          ; AX = 8, a small positive result
    sub  ax, 8                           ; AX = 0, should raise the zero flag

    mov  al, 0FFh                        ; largest unsigned byte value
    add  al, 1                           ; overflow past 255 wraps AL to 0

    mov  al, 7Fh                         ; largest positive signed byte (+127)
    add  al, 1                           ; +128 does not fit a signed byte

    mov  cl, 3                           ; minuend smaller than subtrahend
    sub  cl, 5                           ; 3 - 5 needs a borrow, CL = FEh (-2)

    mov  dx, ax                          ; keep a copy of the result in DX

    mov  ax, 4C00h                       ; DOS service: end program, code 0
    int  21h                             ; return control to DOS
main ENDP
END main
