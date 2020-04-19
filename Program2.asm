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

RANGELIMIT EQU <46>

.data
    ; Introduction and instructions of the program
    programName     BYTE    "Fibonacci Numbers", 0
    programmer      BYTE    "Programmed by Emanuel Ramirez Alsina",0
    
    ;intro          BYTE    "This is Program 02 made by Emanuel Ramirez", 0
    ;instruction    BYTE    "This program will calculate Fibonacci numbers", 0

    askName         BYTE    "What's your name? ", 0
    sayHello        BYTE    "Greetings, ", 0

    fibPrompt       BYTE    "Enter the number of Fibonacci terms to display ", 0
    adviseUser      BYTE    "Number must be an integer in the range [1..46]", 0

    askFibTerms     BYTE    "How many Fibonacci terms do you want? ", 0

    errorMessage    BYTE    "Out of range. Enter a number in [1 .. 46]", 0


    fiveSpaces      BYTE    "     ", 0
    userName        DWORD   33 DUP(0)
    userNumber      DWORD   ?
    fibNumber       DWORD   ?
    firstFib        DWORD   ?
    secondFib       DWORD   ?
    columns         DWORD   ?


    ;number         DWORD   ? 
    ;finalNumber    DWORD   ?
    ;increaseCount  DWORD   100




    certified       BYTE    "Results certified by Emanuel Ramirez", 0
    exitMessage     BYTE    "Goodbye, ", 0


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
    call    CRLF


    ;Prompt user for Fibonacci terms to be displayed.
    mov     edx, OFFSET fibPrompt
    call    WriteString
    call    CRLF
    mov     edx, OFFSET adviseUser
    call    WriteString
    call    CRLF
    call    CRLF
    jmp     userInput


; Gets and validates user input
userInput:

    mov     edx, OFFSET askFibTerms
    call    WriteString
    call    ReadInt
    call    CRLF
    mov     userNumber, eax
    jmp     checkLowerLimit
    
; Checks the lower limit in the fibonacci range of [1 .. 46]
checkLowerLimit:
    
    ;TODO:  Check this mov     ebx, 1

    mov     eax, userNumber
    mov     ebx, 1
    cmp     eax, ebx
    jge     checkUpperLimit
    jmp throwError


; Checks the upper limit in the fibonacci range of [1 .. 46]
checkUpperLimit:
    mov     eax, userNumber
    mov     ebx, RANGELIMIT
    cmp     eax, ebx
    jg      throwError
    jmp     setup




; Display Error message to the user.
throwError:

    mov     edx, OFFSET errorMessage
    call    WriteString
    call    CRLF
    call    CRLF
    jmp     userInput


setup:
    mov     ebp, 0
    mov     edx, 1
    mov     ebx, edx
    mov     ecx, userNumber

calculate:
    mov     eax, edx
    mov     ebp, eax
    mov     edx, ebx
    add     ebx, ebp
    call    WriteDec
    call    CRLF
    Loop    calculate




; Display Fibonacci numbers
;displayFibs:
;
;    ; Display the first term
;    mov     eax, 1
;    mov     firstFib, eax
;    call    WriteDec
;    mov     edx, OFFSET fiveSpaces
;    call    WriteString
;    jmp     checkIfOver
;
;    ; Display the second term
;    mov     eax, 1
;    mov     secondFib, eax
;    call    WriteDec
;    mov     edx, OFFSET fiveSpaces
;    call    WriteString
;    jmp     checkIfOver
;
;


checkIfOver:
    mov     eax, 1
    cmp     eax, userNumber
    jz      finalMessage



    



finalMessage:
    call    CRLF
    mov     edx, OFFSET certified
    call    WriteString
    call    CRLF
    mov     edx, OFFSET exitMessage
    call    WriteString
    mov     edx, OFFSET userName
    call    WriteString
    call    CRLF







	exit	; exit to operating system
main ENDP

END main
