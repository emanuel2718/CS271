TITLE Program 2     (Program2.asm)

; Author                : Emanuel Ramirez Alsina
; Date Created          : 04/15/2020
; Last Modified:        : 04/18/2020
; OSU email address:    : ramieman@oregonstate.edu
; Course number/section : 271/400
; Project Number        : 02
; Due Date:             : 04/19/2020
; Description           : Calculate Fibonacci numbers

INCLUDE Irvine32.inc

LIMIT EQU <46>

.data
    ; Introduction and instructions of the program
    programName     BYTE    "Fibonacci Numbers", 0
    programmer      BYTE    "Programmed by Emanuel Ramirez Alsina",0
    
    ;intro          BYTE    "This is Program 02 made by Emanuel Ramirez", 0
    ;instruction    BYTE    "This program will calculate Fibonacci numbers", 0

    askName         BYTE    "What's your name?", 0
    sayHello        BYTE    "Greetings, ", 0

    askFibTerms     BYTE    "How many Fibonacci terms do you want?", 0
    adviseUser      BYTE    "Number must be an integer in the range [1..46]", 0

    error           BYTE    "Out of range. Enter a number in [1 .. 46]", 0


    userName        DWORD   33 DUP(0)
    userNumber      DWORD   ?
    fibNumber       DWORD   ?
    fib1            DWORD   ?
    fib2            DWORD   ?
    columns         DWORD   ?


    ;number         DWORD   ? 
    ;finalNumber    DWORD   ?
    ;increaseCount  DWORD   100



    exitMessage     BYTE    "Until the next one, goodbye.", 0



.code
main PROC

    ;Display the program title
    mov     edx, OFFSET programName
    call    WriteString
    call    CRLF

    ;Display the programmer name
    mov     edx, OFFSET programmer
    call    WriteString
    call    CRLF
    call    CRLF

    ;Get the user name
    mov     edx, OFFSET askName
    call    WriteString
    mov     edx, OFFSET userName
    mov     ecx, 32
    call    ReadString

    ;Greet user
    mov     edx, OFFSET sayHello
    call    WriteString
    mov     edx, OFFSET userName
    call    WriteString
    call    CRLF







	exit	; exit to operating system
main ENDP

END main
