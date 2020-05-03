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
    ; Range of valid user input [-88, -55] or [-40, -1] inclusive
    lowerLimitA     EQU     -88
    lowerLimitB     EQU     -40

    upperLimitA     EQU     -55
    upperLimitB     EQU     -1

.data
    ; Introduction, user information and instructions of the program variables
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

    noInputMessage  BYTE    "I received no input from human. Sad machine is sad", 0
    exitMessage     BYTE    "We have to stop meeting like this. Farewell, ", 0

    ; Extra Credit 1
    extraCredit     BYTE    "**EC: Number the lines during user input", 0
    lineDot         BYTE    ". ", 0

    ; User name variable
    userName        BYTE    64 DUP(0)

    numCounter      DWORD   0 ; Keep track of No. valid inputs from the user
    
    sum             SDWORD  0 ; Keep track of the sum of all valid inputs
    average         SDWORD  0

    maxNumber       SDWORD  -99
    minNumber       SDWORD  0
    inputNumber     SDWORD  ? ; The current user input
    


.code
main PROC

    ; Introduction
    mov             edx, OFFSET welcome
    call            WriteString
    call            CRLF
    mov             edx, OFFSET extraCredit
    call            WriteString
    call            CRLF
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

; Get the number from the user and delegate work
getNumberInput:

    ; Prompt the user for a number plus Extra Credit
    mov             eax, numCounter
    call            WriteDec
    mov             edx, OFFSET lineDot
    call            WriteString
    mov             edx, OFFSET promptNumber
    call            WriteString
    call            ReadInt
    mov             inputNumber, eax

    ; Check for a positive number
    cmp             inputNumber, 0
    jns              printResults ; SIGN flag

    ; Verify input range validity
    cmp             inputNumber, lowerLimitA
    jl              printInvalidInfo
    cmp             inputNumber, upperLimitA
    jg              checkRangeLimit

    ; Change Maximum or Minimum number value if neccesary
    cmp             eax, maxNumber
    jg              changeMaxNumber
    cmp             eax, minNumber
    jl              changeMinNumber

    

; Increment the number of valid user inputs
incrementCounter:
    mov             eax, inputNumber
    add             sum, eax
    inc             numCounter
    jmp             getNumberInput


; Verify if user input lies inside the specified range
checkRangeLimit:
    cmp             inputNumber, lowerLimitB
    jl              printInvalidInfo
    cmp             eax, maxNumber
    jg              changeMaxNumber
    cmp             eax, minNumber
    jl              changeMinNumber
    jmp             incrementCounter


; Display all the results back to the user
printResults:
    cmp             numCounter, 0
    je              specialMessage

    ; How many number were received from user
    mov             edx, OFFSET validInput1
    call            WriteString
    mov             eax, numCounter
    call            WriteDec
    mov             edx, OFFSET validInput2
    call            WriteString
    call            CRLF

    ; Maximum number information
    mov             edx, OFFSET maxMessage
    call            WriteString
    mov             eax, maxNumber
    call            WriteInt
    call            CRLF

    ; Minimum number information
    mov             edx, OFFSET minMessage
    call            WriteString
    mov             eax, minNumber
    call            WriteInt
    call            CRLF

    ; Sum of number information
    mov             edx, OFFSET sumMessage
    call            WriteString
    mov             eax, sum
    call            WriteInt
    call            CRLF

    ; Rounded average number information
    mov             edx, OFFSET avgMessage
    call            WriteString
    mov             eax, sum
    cdq
    mov             ebx, numCounter
    idiv            ebx
    call            WriteInt
    call            CRLF

    jmp             goodbye 

; Update maximum number
changeMaxNumber:
    mov             eax, inputNumber
    mov             maxNumber, eax
    cmp             eax, minNumber
    jl              changeMinNumber
    jmp             incrementCounter

; Update minimum number
changeMinNumber:
    mov             eax, inputNumber
    mov             minNumber, eax
    jmp             incrementCounter


; Number is negative and outside of range
printInvalidInfo:
    mov             edx, OFFSET badInput
    call            WriteString
    call            CRLF
    jmp             getNumberInput

; Display special message to the user if no number was received
specialMessage:
    call            CRLF
    mov             edx, OFFSET noInputMessage
    call            WriteString
    call            CRLF
    jmp             goodbye

; Display goodbye message to the user
goodbye:
    mov             edx, OFFSET exitMessage
    call            WriteString
    mov             edx, OFFSET userName
    call            WriteString
    call            CRLF


exit
main ENDP

END main
