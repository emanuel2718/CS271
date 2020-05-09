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
    ; Range [1 .. 400]
    LOWER_RANGE     EQU     1
    UPPER_RANGE     EQU     400

.data
    ; Introduction and program instructions
    welcome         BYTE    "Composite Numbers   Programmed by Emanuel Ramirez", 0
    programInfo     BYTE    "Enter the number of composites numbers you would "
                    BYTE    "like to see.", 0
    programInfo2    BYTE    "I'll accept orders for up to 400 composites", 0

    ; Prompt the user for a number inside the range
    promptNumber    BYTE    "Enter the number of composites [1 .. 400]: ", 0

    ; Error. Number is out of range
    outOfRange      BYTE    "Out of range. Try again", 0

    ; Variables
    userNumber      DWORD   ?
    numbersTotal    DWORD   0
    currentNumber   DWORD   3
    space           BYTE    "    ", 0
    amountOfNumber  DWORD   0
    numbersPerLine  DWORD   10

    ; Exit message
    goodbye         BYTE    "Results certified by Emanuel Ramirez. Farewell", 0


.code

; --------------------
; Main procedure
; --------------------
main PROC

    call            introduction
    call            getUserData
    call            showComposites
    call            farewell
    exit
main ENDP


; --------------------
; Introduction procedure
; --------------------
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

; --------------------
; Get the data from the user
; --------------------

getUserData PROC
    mov             edx, OFFSET promptNumber
    call            WriteString
    jmp             getInput

getInput:
    call            ReadInt
    call            ValidateUserInput
    mov             userNumber, eax
    ret

    ; --------------------
    ; Validate user data
    ; --------------------
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


; --------------------
; Show Composite numbers 
; --------------------
showComposites PROC
    mov             ecx, eax

checkNext:
    call            nextComposite
    call            printNumber
    loop            checkNext
    ret

    nextComposite PROC

    analyzeNext:
        inc             currentNumber
        mov             eax, currentNumber
        call            isComposite
        jnz             analyzeNext
        ret
    nextComposite ENDP

    ; --------------------
    ; Check composite number
    ; --------------------
    isComposite PROC
        mov             ebx, 2

    next:
        mov             esi, eax
        cmp             eax, ebx
        je              notComposite

        xor             edx, edx
        div             ebx
        cmp             edx, 0
        je              finish

        inc             ebx
        mov             eax, esi
        jmp             next

    notComposite:
        cmp             edx, 0

    finish:
        ret
    isComposite ENDP
    
    ret
showComposites ENDP


; --------------------
; Print number to console
; --------------------
printNumber PROC
    pushad
    mov             eax, currentNumber
    mov             ebx, amountOfNumber
    cmp             numbersPerLine, ebx
    jg              writeNumber
    mov             amountOfNumber, 0
    call            CRLF

writeNumber:
    call            WriteDec
    mov             edx, OFFSET space
    call            WriteString
    inc             amountOfNumber
    popad
    ret

printNumber ENDP



farewell PROC
    call            CRLF
    call            CRLF
    mov             edx, OFFSET goodbye
    call            WriteString
    call            CRLF
    ret
farewell ENDP

END main
