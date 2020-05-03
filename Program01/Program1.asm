TITLE Program 1     (Program1.asm)

; Author                : Emanuel Ramirez Alsina
; Date Created          : 04/06/2020
; Last Modified:        : 04/11/2020
; OSU email address:    : ramieman@oregonstate.edu
; Course number/section : 271/400
; Project Number        : 01
; Due Date:             : 04/12/2020
; Description           : Display name and program title into the display and calculates the sum and differences
;                         of three user supplied numbers.

INCLUDE Irvine32.inc


.data
    ; Introduction of the program and instructions of the program.
    intro           BYTE    "Hello. This is Program 01 made by Emanuel Ramirez Alsina:", 0
    instruction     BYTE    "Enter 3 numbers A > B > C, and I'll show you the sums and differences.", 0

    addSign         BYTE    " + ",0
    subSign         BYTE    " - ",0
    eqSign          BYTE    " = ",0
                                
    ; Prompt user input (three numbers in descending order)
    input1          BYTE    "First number: ", 0
    input2          BYTE    "Second number: ", 0
    input3          BYTE    "Third number: ", 0

    ; User input numbers.
    num1            DWORD   ?
    num2            DWORD   ?
    num3            DWORD   ?

    ; Calculation variables
    sumAB           DWORD   ?           ;Calculates the result of (A + B)
    sumAC           DWORD   ?           ;Calculates the result of (A + C)
    sumBC           DWORD   ?           ;Calculates the result of (B + C)

    diffAB          DWORD   ?           ;Calculates the result of (A - B)
    diffAC          DWORD   ?           ;Calculates the result of (A - C)
    diffBC          DWORD   ?           ;Calculates the result of (B - C)

    sumABC          DWORD   ?           ;Calculates the result of (B - C)

    ; Extra Credit 1
    EC1desc         BYTE    "**EC: Will repeat until the user decides to quit", 0
    EC1prompt       BYTE    "Would you like to continue using this program? Press 1 for [YES]. Press 0 for [NO]: ", 0
    EC1response     DWORD   ?           ;Will store the user decision (1 as 'YES' or 0 as 'NO')

    ; Extra Credit 2
    EC2desc         BYTE    "**EC: Program will check if the numbers are in descending order", 0
    EC2warning      BYTE    "ERROR: Numbers must be provided in descending order (A > B > C).", 0

    ; Extra Credit 3
    EC3desc         BYTE    "**EC3: The program will be able to handle negative results (B-A, C-A, C-B, C-B-A)", 0

    exitMessage     BYTE    "That's all for today, until next time.", 0



.code
main PROC

    ; Program's Introduction
    mov     edx, OFFSET intro
    call    WriteString
    call    CRLF

    ; Extra credit 1
    mov     edx, OFFSET EC1desc
    call    WriteString
    call    CRLF

    ; Extra credit 2
    mov     edx, OFFSET EC2desc
    call    WriteString
    call    CRLF
    call    CRLF


    ; Program's Instructions:
    mov     edx, OFFSET instruction
    call    WriteString
    call    CRLF


init:

    ; Get the first number from the user and asign it to the num1 variable
    call    CRLF
    mov     edx, OFFSET input1
    call    WriteString
    call    ReadInt
    mov     num1, eax

    ; Get the second number from the user and asign it to the num2 variable
    call    CRLF
    mov     edx, OFFSET input2
    call    WriteString
    call    ReadInt    
    mov     num2, eax
    mov     eax, num2
    cmp     eax, num1
    jg      numberWarning               ;Jump to numberWarning if num2 > num1

    ; Get the third number from the user and asign it to the num3 variable
    call    CRLF
    mov     edx, OFFSET input3
    call    WriteString
    call    ReadInt
    mov     num3, eax
    mov     eax, num3
    cmp     eax, num2
    jg      numberWarning               ;Jump to numberWarning if num3 > num2
    jle     calculations


calculations:

    ; Calculate the sum (A + B)
    mov     eax, num1
    add     eax, num2
    mov     sumAB, eax

    ; Calculate the difference (A - B)
    mov     eax, num1
    sub     eax, num2
    mov     diffAB, eax

    ; Calculate the sum (A + C)
    mov     eax, num1
    add     eax, num3
    mov     sumAC, eax

    ; Calculate the difference (A - C)
    mov     eax, num1
    sub     eax, num3
    mov     diffAC, eax

    ; Calculate the sum (B + C)
    mov     eax, num2
    add     eax, num3
    mov     sumBC, eax

    ; Calculate the difference (B - C)
    mov     eax, num2
    sub     eax, num3
    mov     diffBC, eax

    ; Calculate the sum (A + B + C)
    mov     eax, num1
    add     eax, num2
    add     eax, num3
    mov     sumABC, eax



    ; Print the (A + B) result to the user.
    mov     eax, num1
    call    WriteDec
    mov     edx, OFFSET addSign
    call    WriteString
    mov     eax, num2
    call    WriteDec
    mov     edx, OFFSET eqSign
    call    WriteString
    mov     eax, sumAB
    call    WriteDec
    call    CRLF

    ; Print the (A - B) result to the user.
    mov     eax, num1
    call    WriteDec
    mov     edx, OFFSET subSign
    call    WriteString
    mov     eax, num2
    call    WriteDec
    mov     edx, OFFSET eqSign
    call    WriteString
    mov     eax, diffAB
    call    WriteDec
    call    CRLF

    ; Print the (A + C) result to the user.
    mov     eax, num1
    call    WriteDec
    mov     edx, OFFSET addSign
    call    WriteString
    mov     eax, num3
    call    WriteDec
    mov     edx, OFFSET eqSign
    call    WriteString
    mov     eax, sumAC
    call    WriteDec
    call    CRLF

    ; Print the (A - C) result to the user.
    mov     eax, num1
    call    WriteDec
    mov     edx, OFFSET subSign
    call    WriteString
    mov     eax, num3
    call    WriteDec
    mov     edx, OFFSET eqSign
    call    WriteString
    mov     eax, diffAC
    call    WriteDec
    call    CRLF

    ; Print the (B + C) result to the user.
    mov     eax, num2
    call    WriteDec
    mov     edx, OFFSET addSign
    call    WriteString
    mov     eax, num3
    call    WriteDec
    mov     edx, OFFSET eqSign
    call    WriteString
    mov     eax,sumBC
    call    WriteDec
    call    CRLF

    ; Print the (B - C) result to the user.
    mov     eax, num2
    call    WriteDec
    mov     edx, OFFSET subSign
    call    WriteString
    mov     eax, num3
    call    WriteDec
    mov     edx, OFFSET eqSign
    call    WriteString
    mov     eax, diffBC
    call    WriteDec
    call    CRLF

    ; Print the (A + B + C) result to the user.
    mov     eax, num1
    call    WriteDec
    mov     edx, OFFSET addSign
    call    WriteString
    mov     eax, num2
    call    WriteDec
    mov     edx, OFFSET addSign
    call    WriteString
    mov     eax, num3
    call    WriteDec
    mov     edx, OFFSET eqSign
    call    WriteString
    mov     eax, sumABC
    call    WriteDec
    call    CRLF
    call    CRLF
    jmp     finalMessage


numberWarning:
    ;Prompt the error message to the user (numbers must be in descending order)
    call    CRLF
    mov     edx, OFFSET EC2warning
    call    WriteString
    call    CRLF
    call    CRLF
    jmp     finalMessage



finalMessage:

    ; Prompt the user to decide whether to continue or quit the program.
    mov     edx, OFFSET EC1prompt
    call    WriteString
    call    ReadInt
    mov     EC1response, eax
    cmp     eax, 1
    je      init


    ; Exit the program with a message; User chose to quit the program.
    call    CRLF
    mov     edx, OFFSET exitMessage
    call    WriteString
    call    CRLF
    call    CRLF



	exit	; exit to operating system
main ENDP

END main
