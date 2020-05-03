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


.data
    ; Introduction and instructions of the program
    programName     BYTE    "Fibonacci Numbers", 0
    programmer      BYTE    "Programmed by Emanuel Ramirez Alsina",0
    askName         BYTE    "What's your name? ", 0
    sayHello        BYTE    "Greetings, ", 0
    fibPrompt       BYTE    "Enter the number of Fibonacci terms to display ", 0
    adviseUser      BYTE    "Number must be an integer in the range [1..46]", 0
    askFibTerms     BYTE    "How many Fibonacci terms do you want? ", 0
    errorMessage    BYTE    "Out of range. Enter a number in [1 .. 46]", 0

    ; Useful values initializations
    fiveSpaces      BYTE    "     ", 0
    userName        DWORD   33 DUP(0)
    userNumber      DWORD   ?
    fibNumber       DWORD   ?
    firstFib        DWORD   ?
    secondFib       DWORD   ?
    temp            DWORD   ?
    columns         DWORD   ?
    counter         DWORD   5
    RANGELIMIT      DWORD   46

    ; Goobye messages
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
    mov     eax, userNumber
    mov     ebx, 1
    cmp     eax, ebx
    jge     checkUpperLimit
    jmp     throwError


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


; Set counters and registers value prior entering the calculation loop.
setup:
    mov     ebp, 0
    mov     edx, 1
    mov     ebx, edx
    mov     ecx, userNumber
    jmp     calculate


; If we enter here that means we have arrived to an EOL.
; Open a new line an reset the counter of numbers per line back to 5.
newline:
    mov     counter, 5
    call    CRLF
    Loop    calculate


; Fibonacci calculation main loop. 
calculate:
    mov     eax, edx
    mov     ebp, eax
    mov     edx, ebx
    add     ebx, ebp
    mov     temp, edx
    call    WriteDec

    mov     edx, OFFSET fiveSpaces
    call    WriteString
    mov     edx, temp
    cmp     ecx, 1
    je      finalMessage
    cmp     counter, 1
    jz      newLine
    dec     counter
    Loop    calculate



; We are in the End Game now. Print goodbye message to the user and exit
finalMessage:
    call    CRLF
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
