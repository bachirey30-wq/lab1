TITLE Display a Message                  (Trial2.asm)
; Prints a single line of text using DOS interrupt 21h, function 09h.
;
; Author : Mouhammed Al-Bachir Youmbai, Moulay Saaid Reggani
; Group  : Lab group 2 (study groups 1 and 4)

.MODEL SMALL
.STACK 100h
.DATA
message  DB 'Hi, I am Mouhammed Al-Bachir Youmbai, Computer Architecture student.', 0Dh, 0Ah, '$'

.CODE
main PROC
    mov  ax, @DATA                       ; load the data segment address
    mov  ds, ax                          ; DS must point at our data

    mov  ah, 09h                         ; DOS print-string function
    lea  dx, message                     ; DX = address of the text to print
    int  21h                             ; ask DOS to display it

    mov  ah, 4Ch                         ; terminate program
    int  21h                             ; return control to the OS
main ENDP
END main
