TITLE Program 4     (Program4.asm)

; Author                : Emanuel Ramirez Alsina
; Date Created          : 05/04/2020
; Last Modified:        : 05/10/2020
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


; --------------------------------------------
; Introduction procedure
; Prints program information and instructions.
; register changed: EDX
; --------------------------------------------
introduction PROC
    mov             edx, OFFSET welcome
    call            WriteString
    call            CRLF
    call            CRLF
    mov             edx, OFFSET programInfo
    call            WriteString
    call            CRLF
    mov             edx, OFFSET programInfo2
    call            WriteString
    call            CRLF
    call            CRLF
    ret
introduction ENDP

; ----------------------------------------------------
; Prompts the user for a number in the range [1 .. 400]
; to calculate composite numbers.
; If number was out of the given range; prompt again
;
; return: EAX = valid number
; ----------------------------------------------------

getUserData PROC
    mov             edx, OFFSET promptNumber
    call            WriteString
    jmp             getInput

; Get the number from the user
getInput:
    call            ReadInt
    call            ValidateUserInput
    mov             userNumber, eax
    ret

    ; --------------------------------
    ; Procedure to validate user input
    ; return: if number is a valid input or not
    ; registers changed: EAX, EDX
    ; --------------------------------
    validateUserInput PROC
        cmp             eax, LOWER_RANGE
        jl              invalidInput
        cmp             eax, UPPER_RANGE
        jg              invalidInput
        call            CRLF
        ret

    ; Number is out of range
    invalidInput:
        mov             edx, OFFSET outOfRange
        call            WriteString
        call            CRLF
        call            getUserData
        ret
    
    validateUserInput ENDP

getUserData ENDP


; --------------------------------------------------------------
; Uses ECX as a counter with the number entered by the user.
; Will loop until ECX = 0. Meaning all the composite number has been
; printed on the screen.
; register changed: ECX
; --------------------------------------------------------------
showComposites PROC
    mov             ecx, eax

; Loop until n number has been checked
checkNext:
    call            nextComposite
    call            printNumber
    loop            checkNext
    ret

    ; ---------------------------------------------------------------
    ; Procedure that assign current number to eax for it to be checked
    ; In charge of iterating through the numbers and updating
    ; currentNumber
    ; register changed: EAX
    ; ---------------------------------------------------------------
    nextComposite PROC
    ; Go through numbers in range
    analyzeNext:
        inc             currentNumber
        mov             eax, currentNumber
        call            isComposite
        jnz             analyzeNext
        ret
    nextComposite ENDP

    ;-------------------------------------------------------------------------
    ; Procedure to check if number inside EAX (currentNumber) is composite or not.
    ; receives: current number
    ; return: ZF = 0 number is not Composite
    ; return: ZF = 1 number is Cmposite
    ; registers changed: EAX, EBX, ECX, EDX
    ;-------------------------------------------------------------------------
    isComposite PROC
        mov             ebx, 2

    ; Check if number is composite or not
    next:
        mov             esi, eax
        cmp             eax, ebx
        je              notComposite
        xor             edx, edx
        div             ebx
        cmp             edx, 0
        je              finish ; Number is composite
        inc             ebx
        mov             eax, esi
        jmp             next

    ; Number is not composite
    notComposite:
        cmp             edx, 0

    finish:
        ret
    isComposite ENDP

    ret
showComposites ENDP


; ----------------------------------------------------------------------
; Procedure to print number to console adding spaces and printing 10 numbers per line
; registers changed: EAX, EBX
; ----------------------------------------------------------------------
printNumber PROC
    pushad
    mov             eax, currentNumber
    mov             ebx, amountOfNumber
    cmp             numbersPerLine, ebx
    jg              writeNumber

    ; Move to the new line
    mov             amountOfNumber, 0
    call            CRLF

; Still in the same line
writeNumber:
    call            WriteDec
    mov             edx, OFFSET space
    call            WriteString
    inc             amountOfNumber
    popad
    ret

printNumber ENDP



; --------------------
; Exit procedure
; --------------------
farewell PROC
    call            CRLF
    call            CRLF
    mov             edx, OFFSET goodbye
    call            WriteString
    call            CRLF
    ret
farewell ENDP

END main
