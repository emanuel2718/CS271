TITLE Program 1     (Program1.asm)

; Author                : Emanuel Ramirez Alsina
; Date Created          : 04/06/2020
; Last Modified:        : 04/04/2020
; OSU email address:    : ramieman@oregonstate.edu
; Course number/section : 271/400
; Project Number        : 01
; Due Date:             : 04/12/2020
; Description           : Display name and program title into the display and calculates the sum and differences
;                         of three user supplied numbers.

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data
    ; Introduction of the program and instructions of the program.
    intro           BYTE    "Hello, this is Program 01 made by Emanuel Ramirez Alsina.", 0
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

    showResults     BYTE    "The following are the results of the calculations from the three numbers provided:", 0
    exitMessage     BYTE    "That's all for today, until next time.", 0



; (insert variable definitions here)

.code
main PROC

    ; Introduction
    mov     edx, OFFSET intro           ;Get the address of intro into edx register.
    call    WriteString                 ;Print the introduction to the user.
    call    CrlF
    call    CrlF

    ; Instruction
    mov     edx, OFFSET instruction     ;Get the address of instruction into edx register.
    call    WriteString                 ;Print the instruction of the program to the user.
    call    CrlF


target:    
    mov     edx, OFFSET input1
    call    WriteString
    call    ReadInt
    mov     num1, eax                   ;Assign
    call    CrlF
    mov     edx, OFFSET input2
    call    WriteString
    call    ReadInt    
    mov     num2, eax
    call    CrlF
    mov     edx, OFFSET input3
    call    WriteString
    call    ReadInt
    mov     num3, eax
    call    CrlF


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
    call    CrlF

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
    call    CrlF

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
    call    CrlF

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
    call    CrlF

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
    call    CrlF

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
    call    CrlF

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
    call    CrlF


	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
