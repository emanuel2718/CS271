TITLE Program 4     (Program4.asm)

; Author                : Emanuel Ramirez Alsina
; Date Created          : 05/04/2020
; Last Modified:        : 05/08/2020
; OSU email address:    : ramieman@oregonstate.edu
; Course number/section : 271/400
; Project Number        : 04
; Due Date:             : 05/10/2020
; Description           : Program to calculate composite numbers. The number
;                         must be in the range [1 .. 400]. The program will
;                         display all the composite numbers up to the given
;                         number.

INCLUDE Irvine32.inc

.const
    LOWER_RANGE     EQU     1
    UPPER_RANGE     EQU     400

.data
    ; Introduction, user information and instructions of the program variables
    welcome         BYTE    "Composite Numbers   Programmed by Emanuel Ramirez", 0
    programInfo     BYTE    "Enter the number of composites numbers you would "
                    BYTE    "like to see.", 0
    programInfo2    BYTE    "I'll accept orders for up to 400 composites", 0

    promptNumber    BYTE    "Enter the number of composites [1 .. 400]: ", 0
    
    outOfRange      BYTE    "Out of range. Try again", 0

    goodbye         BYTE    "Results certified by Emanuel Ramirez. Farewell", 0


.code
main PROC

    call            introduction
    call            getUserData
    call            farewell



    exit
main ENDP

introduction PROC
    mov             edx, OFFSET welcome
    call            WriteString
    call            CRLF
    mov             edx, OFFSET programInfo
    call            WriteString
    call            CRLF
    mov             edx, OFFSET programInfo2
    call            WriteString
    call            CRLF
    ret

introduction ENDP


getUserData PROC
    mov             edx, OFFSET promptNumber
    call            WriteString
    jmp             getInput

getInput:
    call            ReadInt
    call            ValidateUserInput
    ret

    validateUserInput PROC
        cmp             eax, LOWER_RANGE
        jl              invalidInput
        cmp             eax, UPPER_RANGE
        jg              invalidInput
        ret

    invalidInput:
        mov             edx, OFFSET outOfRange
        call            WriteString
        call            CRLF
        call            getUserData
        ret
    
    validateUserInput ENDP



getUserData ENDP



farewell PROC
    mov             edx, OFFSET goodbye
    call            WriteString
    call            CRLF
    ret
farewell ENDP

END main
