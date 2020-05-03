TITLE Program 3     (Program3.asm)

; Author                : Emanuel Ramirez Alsina
; Date Created          : 04/26/2020
; Last Modified:        : 05/02/2020
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

    sum             SDWORD  0
    maxNumber       SDWORD  0
    minNumber       SDWORD  0


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



exit
main ENDP

END main
