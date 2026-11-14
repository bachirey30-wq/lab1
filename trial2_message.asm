TITLE Display a Message                  (trial2_message.asm)
; Displays a greeting on the screen with DOS function 09h.
; The string must end with '$' and DS must point to the data segment.

.model small
.stack 100h

.data
greeting  DB  'Salam! Computer Architecture - Lab 1, El Oued', 0Dh, 0Ah, '$'

.code
main PROC
    mov  ax, @data                       ; locate the data segment
    mov  ds, ax                          ; DOS reads the string through DS
    mov  dx, OFFSET greeting             ; DX = address of the text to print
    mov  ah, 09h                         ; DOS service: print '$'-ended string
    int  21h                             ; ask DOS to display it

    mov  ax, 4C00h                       ; DOS service: end program, code 0
    int  21h                             ; return control to DOS
main ENDP
END main
