TITLE Program 1     (Program1.asm)

; Author                : Emanuel Ramirez Alsina
; Date Created          : 04/06/2020
; Last Modified:        : 04/10/2020
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
    num1            DWORD   ?           ;User input: Integer #1
    num2            DWORD   ?           ;User input: Integer #2
    num3            DWORD   ?           ;User input: Integer #3

    ; Calculation variables
    sumAB           DWORD   ?           ;Calculates the result of (A + B)
    sumAC           DWORD   ?           ;Calculates the result of (A + C)
    sumBC           DWORD   ?           ;Calculates the result of (B + C)

    diffAB          DWORD   ?           ;Calculates the result of (A - B)
    diffAC          DWORD   ?           ;Calculates the result of (A - C)
    diffBC          DWORD   ?           ;Calculates the result of (B - C)

    sumABC          DWORD   ?           ;Calculates the result of (B - C)

    ; Extra Credit 1
    EC1desc         BYTE    "**EC1: Will repeat until the user decides to quit", 0
    EC1prompt       BYTE    "Would you like to continue using this program? Press 1 for [YES]. Press 0 for [NO]: ", 0
    EC1response     DWORD   ?           ;Will store the user decision (1 as 'YES' or 0 as 'NO')

    ; Extra Credit 2
    ;EC2desc         BYTE    "**EC2: Will check if the numbers are in non-descending order", 0


    exitMessage     BYTE    "That's all for today, until next time.", 0



.code
main PROC

    ; Program's Introduction
    mov     edx, OFFSET intro           ;Get the address of intro into edx register.
    call    WriteString                 ;Print the introduction to the user.
    call    CrlF

    ; Extra credit
    mov     edx, OFFSET EC1desc         ;Get the extra credit #1 description message
    call    WriteString                 ;Extra Credit #1 Message
    call    CrlF
    call    CrlF


    ; Program's Instructions:
    mov     edx, OFFSET instruction     ;Get the address of instruction into edx register.
    call    WriteString                 ;Print the instruction of the program to the user.
    call    CrlF


init:

    ; Get the first number from the user and asign it to the num1 variable
    call    CrlF
    mov     edx, OFFSET input1
    call    WriteString
    call    ReadInt
    mov     num1, eax
    call    CrlF

    ; Get the second number from the user and asign it to the num2 variable
    mov     edx, OFFSET input2
    call    WriteString
    call    ReadInt    
    mov     num2, eax
    call    CrlF

    ; Get the third number from the user and asign it to the num3 variable
    mov     edx, OFFSET input3
    call    WriteString
    call    ReadInt
    mov     num3, eax
    call    CrlF
    call    CrlF


calculations:

    ; Calculate the sum (A + B)
    mov     eax, num1                   ;Move num1 into eax register
    add     eax, num2                   ;num1 + num 2
    mov     sumAB, eax                  ;Save the result of the sum in (sumAB)

    ; Calculate the difference (A - B)
    mov     eax, num1                   ;Move num1 into eax register
    sub     eax, num2                   ;num1 - num 2
    mov     diffAB, eax                 ;Save the result of the difference in (diffAB)

    ; Calculate the sum (A + C)
    mov     eax, num1                   ;Move num1 into eax register
    add     eax, num3                   ;num1 + num3
    mov     sumAC, eax                  ;Save the result of the sum in (sumAC)

    ; Calculate the difference (A - C)
    mov     eax, num1                   ;Move num1 into eax register
    sub     eax, num3                   ;num1 - num3
    mov     diffAC, eax                 ;Save the result of the difference in (diffAC)

    ; Calculate the sum (B + C)
    mov     eax, num2                   ;Move num2 into eax register
    add     eax, num3                   ;num2 + num3
    mov     sumBC, eax                  ;Save the result of the sum in (sumBC)

    ; Calculate the difference (B - C)
    mov     eax, num2                   ;Move num2 into eax register
    sub     eax, num3                   ;num2 + num3
    mov     diffBC, eax                 ;Save the result of the difference in (diffBC)

    ; Calculate the sum (A + B + C)
    mov     eax, num1                   ;Move num1 into eax register
    add     eax, num2                   ;num1 + num2
    add     eax, num3                   ;(num1 + num2) + num3
    mov     sumABC, eax                 ;Save the result of the sum in (sumABC)



    ; Print the (A + B) result to the user.
    mov     eax, num1                   ;Move num1 into eax register
    call    WriteDec                    ;Print num1 into the console
    mov     edx, OFFSET addSign         ;Move the offset of "+" into edx
    call    WriteString                 ;Print "+" into the console
    mov     eax, num2                   ;Move num2 into eax register
    call    WriteDec                    ;Print num2 into the console
    mov     edx, OFFSET eqSign          ;Move the offset of "=" into edx
    call    WriteString                 ;Print "=" into the console
    mov     eax, sumAB                  ;Move the value of sumAB into eax
    call    WriteDec                    ;Print the value of sumAB
    call    CrlF

    ; Print the (A - B) result to the user.
    mov     eax, num1                   ;Move num1 into eax register
    call    WriteDec                    ;Print num1 into the console
    mov     edx, OFFSET subSign         ;Move the offset of "-" into edx
    call    WriteString                 ;Print "-" into the console
    mov     eax, num2                   ;Move num2 into eax register
    call    WriteDec                    ;Print num2 into the console
    mov     edx, OFFSET eqSign          ;Move the offset of "=" into edx
    call    WriteString                 
    mov     eax, diffAB                 ;Move the value of diffAB into eax
    call    WriteDec                    ;Print the value of diffAB
    call    CrlF

    ; Print the (A + C) result to the user.
    mov     eax, num1                   ;Move num1 into eax register
    call    WriteDec                    ;Print num1 into the console
    mov     edx, OFFSET addSign         ;Move the offset of "+" into edx
    call    WriteString                 ;Print "+" into the console
    mov     eax, num3                   ;Move num3 into eax register
    call    WriteDec                    ;Print num3 into the console
    mov     edx, OFFSET eqSign          ;Move the offset of "=" into edx
    call    WriteString                 ;Print "=" into the console
    mov     eax, sumAC                  ;Move the value of sumAC into eax
    call    WriteDec                    ;Print the value of sumAC
    call    CrlF

    ; Print the (A - C) result to the user.
    mov     eax, num1                   ;Move num1 into eax register
    call    WriteDec                    ;Print num1 into the console
    mov     edx, OFFSET subSign         ;Move the offset of "-" into edx
    call    WriteString                 ;Print "-" into the console
    mov     eax, num3                   ;Move num3 into eax register
    call    WriteDec                    ;Print num3 into the console
    mov     edx, OFFSET eqSign          ;Move the offset of "=" into edx
    call    WriteString                 ;Print "=" into the console
    mov     eax, diffAC                 ;Move the value of diffAC into eax
    call    WriteDec                    ;Print the value of diffAC
    call    CrlF

    ; Print the (B + C) result to the user.
    mov     eax, num2                   ;Move num2 into eax register
    call    WriteDec                    ;Print num2 into the console
    mov     edx, OFFSET addSign         ;Move the offset of "+" into edx
    call    WriteString                 ;Print "+" into the console
    mov     eax, num3                   ;Move num3 into eax register
    call    WriteDec                    ;Print num3 into the console
    mov     edx, OFFSET eqSign          ;Move the offset of "=" into edx
    call    WriteString                 ;Print "=" into the console
    mov     eax,sumBC                   ;Move the value of sumBC into eax
    call    WriteDec                    ;Print the value of sumBC
    call    CrlF

    ; Print the (B - C) result to the user.
    mov     eax, num2                   ;Move num2 into eax register
    call    WriteDec                    ;Print num2 into the console
    mov     edx, OFFSET subSign         ;Move the offset of "-" into edx
    call    WriteString                 ;Print "-" into the console
    mov     eax, num3                   ;Move num3 into eax register
    call    WriteDec                    ;Print num3 into the console
    mov     edx, OFFSET eqSign          ;Move the offset of "=" into edx
    call    WriteString                 ;Print "=" into the console
    mov     eax, diffBC                 ;Move the value of diffBC into eax
    call    WriteDec                    ;Print the value of diffBC
    call    CrlF

    ; Print the (A + B + C) result to the user.
    mov     eax, num1                   ;Move num1 into eax register
    call    WriteDec                    ;Print num1 into the console
    mov     edx, OFFSET addSign         ;Move the offset of "+" into edx
    call    WriteString                 ;Print "+" into the console
    mov     eax, num2                   ;Move num2 into eax register
    call    WriteDec                    ;Print num2 into the console
    mov     edx, OFFSET addSign         ;Move the offset of "+" into edx
    call    WriteString                 ;Print "+" into the console
    mov     eax, num3                   ;Move num3 into eax register
    call    WriteDec                    ;Print num3 into the console
    mov     edx, OFFSET eqSign          ;Move the offset of "=" into edx
    call    WriteString                 ;Print "=" into the console
    mov     eax, sumABC                 ;Move the value of sumABC into eax
    call    WriteDec                    ;Print the value of sumABC 
    call    CrlF
    call    CrlF


jumpTOinit:

    ; Prompt the user to decide whether to continue or quit the program.
    mov     edx, OFFSET EC1prompt
    call    WriteString
    call    ReadInt
    mov     EC1response, eax
    cmp     eax, 1
    je      init                        ;Jump back to the top; User chose to continue. JumpEqual is true.


    ; Exit the program with a message; User chose to quit the program.
    call    CrlF
    mov     edx, OFFSET exitMessage
    call    WriteString
    call    CrlF
    call    CrlF


	exit	; exit to operating system
main ENDP

END main
