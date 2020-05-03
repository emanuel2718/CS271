TITLE Program 3     (Program3.asm)

; Author                : Emanuel Ramirez Alsina
; Date Created          : 04/26/2020
; Last Modified:        : 05/03/2020
; OSU email address:    : ramieman@oregonstate.edu
; Course number/section : 271/400
; Project Number        : 03
; Due Date:             : 05/03/2020
; Description           : Prompt the user for a list of negative numbers
;                         Displaye the information regarding the number entered
;                         such as sum, average, max and min.

INCLUDE Irvine32.inc

.const
    lowerLimitA     EQU     -88
    lowerLimitB     EQU     -40

    upperLimitA     EQU     -55
    upperLimitB     EQU     -1

.data
    ; Introduction and instructions of the program
    welcome         BYTE    "Welcome to the Integer Accumulator by Emanuel Ramirez", 0
    askName         BYTE    "What is your name? ", 0
    greetUser       BYTE    "Hello there, ", 0
    instruction     BYTE    "Please enter numbers in [-88, -55] or [-40, -1]", 0
    exitInstruct    BYTE    "Enter a non-negative number when you are finished",
                            " to see results.", 0

    promptNumber    BYTE    "Enter number: ", 0    

    validInput1     BYTE    "You entered ", 0
    validInput2     BYTE    " valid numbers.", 0

    badInput        BYTE    "Number Invalid!", 0

    sumMessage      BYTE    "The sum of your valid numbers is ", 0
    avgMessage      BYTE    "The rounded average is ", 0
    maxMessage      BYTE    "The maximum valid number is ", 0
    minMessage      BYTE    "The minimum valid number is ", 0
    
    exitMessage     BYTE    "We have to stop meeting like this. Farewell, ", 0

    ; Important values variables
    userName        BYTE    64 DUP(0)

    numCounter      DWORD   0
    sum             SDWORD  0
    average         SDWORD  0

    maxNumber       SDWORD  -99
    minNumber       SDWORD  0
    inputNumber     SDWORD  ?



.code
main PROC

    ; Introduction
    mov             edx, OFFSET welcome
    call            WriteString
    call            CRLF

    ; Get user name
    mov             edx, OFFSET askName
    call            WriteString
    mov             ecx, 63
    mov             edx, OFFSET userName
    call            ReadString


    ; Say hello to the user.
    mov             edx, OFFSET greetUser
    call            WriteString
    mov             edx, OFFSET userName
    call            WriteString
    call            CRLF
    call            CRLF

    ; Print instructions
    mov             edx, OFFSET instruction
    call            WriteString
    call            CRLF
    mov             edx, OFFSET exitInstruct
    call            WriteString
    call            CRLF

getNumberInput:
    mov             edx, OFFSET promptNumber
    call            WriteString
    ;call            WriteDec
    ;mov             eax, inputNumber
    call            ReadInt
    mov             inputNumber, eax
    ;;mov             eax, numCounter

    ; Check if it's a positive number
    cmp             inputNumber, upperLimitB
    jg              printResults

    cmp             inputNumber, lowerLimitA
    jl              printInvalidInfo
    cmp             inputNumber, upperLimitA
    jg              checkRangeLimit
    cmp             eax, maxNumber
    jg              changeMaxNumber
    cmp             eax, minNumber
    jl              changeMinNumber

    

incrementCounter:
    mov             eax, inputNumber
    add             sum, eax
    inc             numCounter
    jmp             getNumberInput


checkRangeLimit:
    cmp             inputNumber, lowerLimitB
    jl              printInvalidInfo 
    cmp             eax, maxNumber
    jg              changeMaxNumber
    cmp             eax, minNumber
    jl              changeMinNumber
    ;;jmp             incrementCounter
    jmp             incrementCounter


printResults:
    mov             edx, OFFSET validInput1
    call            WriteString
    mov             eax, numCounter
    call            WriteDec
    mov             edx, OFFSET validInput2
    call            WriteString
    call            CRLF
    mov             edx, OFFSET maxMessage
    call            WriteString
    mov             eax, maxNumber
    call            WriteInt
    call            CRLF
    mov             edx, OFFSET minMessage
    call            WriteString
    mov             eax, minNumber
    call            WriteInt
    call            CRLF
    mov             edx, OFFSET sumMessage
    call            WriteString
    mov             eax, sum
    call            WriteInt
    call            CRLF

    mov             edx, OFFSET avgMessage
    call            WriteString
    mov             eax, sum
    cdq
    mov             ebx, numCounter
    idiv            ebx
    call            WriteInt
    call            CRLF
    jmp             goodbye 

changeMaxNumber:
    mov             eax, inputNumber
    mov             maxNumber, eax
    cmp             eax, minNumber
    jl              changeMinNumber
    jmp             incrementCounter

changeMinNumber:
    mov             eax, inputNumber
    mov             minNumber, eax
    jmp             incrementCounter


checkInsideRange:



; Number is negative and outside of range
printInvalidInfo:
    mov             edx, OFFSET badInput
    call            WriteString
    call            CRLF
    jmp             getNumberInput




goodbye:
    mov             edx, OFFSET exitMessage
    call            WriteString
    call            CRLF




exit
main ENDP

END main
