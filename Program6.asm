TITLE Program 6     (Program4.asm)

; Author                : Emanuel Ramirez Alsina
; Date Created          : 05/30/2020
; Last Modified:        : 06/05/2020
; OSU email address:    : ramieman@oregonstate.edu
; Course number/section : 271/400
; Project Number        : 06
; Due Date:             : 06/07/2020
; Description           : Designing low-level I/O procedures


INCLUDE Irvine32.inc

.const

    ;Size of the array
    ARRAYSIZE               EQU     10

    ;Range of signed 32 integers values
    MAX_NEG_NUMBER          EQU     2147483648
    MAX_POS_NUMBER          EQU     2147483647

    ;ASCII codes for 0 and 9
    ZERO_ASCII              EQU     48
    NINE_ASCII              EQU     57

    ;ASCII codes for + and - signs
    MINUS_ASCII             EQU     45
    PLUS_ASCII              EQU     43



.data

    ;Introduction and program instructions
    programTitle            BYTE    "PROGRAMMING ASSIGNMENT 6: Designing low-level I/O procedures", 0
    programmerName          BYTE    "Written by: Emanuel Ramirez", 0

    programDescription0     BYTE    "Please provide 10 signed decimal integers", 0

    programDescription1     BYTE    "Each number needs to be small enough to fit "
                            BYTE    "inside a 32 bit register.", 0

    programDescription2     BYTE    "After you have finished inputting the raw numbers "
                            BYTE    "I will display a list ", 0

    programDescription3     BYTE    "of the integers their sum, and their average value", 0

    askForNumber            BYTE    "Please enter a signed number: ", 0

    errorMessage            BYTE    "ERROR: You did not enter a signed number or "
                            BYTE    "your number was too big", 0

    tryAgain                BYTE    "Please try again: ", 0

    commaCharacter          BYTE    ", ", 0
    numbersEntered          BYTE    "You entered the following numbers: ", 0
    sumOfNumbers            BYTE    "The sum of these numbers is: ", 0
    averageOfNumbers        BYTE    "The rounded average is: ", 0
    exitMessage             BYTE    "Thanks for playing!", 0
    negativeSign            BYTE    "-", 0


    ; Array and input variables
    array                   SDWORD  ARRAYSIZE DUP(?)
    userInput               SDWORD  20  DUP (0)
    inputLength             DWORD   0
    counter                 DWORD   0
    sum                     SDWORD  0
    average                 SDWORD  0
    sign                    BYTE    ?


    
;--------------------------------------
; Macro: Display message to the console
; Receives: a string
; Returns: outputs the string to the console
;--------------------------------------
macroDisplayString   MACRO   string

    push                    edx
    mov                     edx, OFFSET string
    call                    WriteString
    pop                     edx

ENDM


;--------------------------------------
; Macro: Get number from user
; Receives: var, string
; Registers changed: ecx, edx
;--------------------------------------
macroGetString      MACRO   var, string

    push                    ecx
    push                    edx
    macroDisplayString      string
    mov                     edx, OFFSET var
    mov                     ecx, (SIZEOF var) - 1
    call                    ReadString
    pop                     edx
    pop                     ecx

ENDM
    
    



.code

;------------------------------------------------------------
; Procedure: main
; Description: program driver
; Receives: none
; Returns: none
; Registers changed: none
;------------------------------------------------------------
main PROC

    call                    introduction
    mov                     ecx, ARRAYSIZE

    fillArray:
    push                    OFFSET array
    push                    counter
    call                    readVal
    inc                     counter
    loop                    fillArray
    call                    CRLF

    macroDisplayString      numbersEntered

    push                    OFFSET array
    push                    ARRAYSIZE
    call                    writeVal
    call                    CRLF

    push                    OFFSET array
    push                    ARRAYSIZE
    push                    sum
    call                    calculateSum


    push                    average
    push                    sum
    call                    calculateAverage

    call                    CRLF
    call                    CRLF

    macroDisplayString      exitMessage

    call                    CRLF

    exit
main ENDP


;------------------------------------------------------------
; Procedure: introduction
; Description: introduces the program to the user
; Registers changed: edx
;------------------------------------------------------------
introduction PROC
    macroDisplayString      programTitle
    call                    CRLF
    macroDisplayString      programmerName
    call                    CRLF
    call                    CRLF
    macroDisplayString      programDescription0
    call                    CRLF
    macroDisplayString      programDescription1
    call                    CRLF
    macroDisplayString      programDescription2
    call                    CRLF
    macroDisplayString      programDescription3
    call                    CRLF
    call                    CRLF


    ret
introduction ENDP


;--------------------------------------------------------------------------------------
; Procedure: readVal
; Description: will read valid signed integers from the user and load them into an array
; Receives: array and counter variable
; Returns: raeds the values into the array
; Registers changed: eax, ecx, edi, esi, ebp, ebx, al
;--------------------------------------------------------------------------------------
readVal PROC
    pushad ;Save registers

    mov                     ebp, esp

    goTop:
    macroGetString          userInput, askForNumber 

    jmp                     validateNumber

    getNumber:
    macroDisplayString      errorMessage
    call                    CRLF
    macroGetString          userInput, tryAgain


    validateNumber:
    mov                     inputLength, eax
    mov                     ecx, eax
    mov                     esi, OFFSET userInput
    mov                     edi, OFFSET numbersEntered


    count:
    lodsb
    cmp                     al, MINUS_ASCII     ;Check for negative sign
    je                      negativeNumber
    cmp                     al, PLUS_ASCII      ;Check for positive sign
    je                      positiveNumber
    cmp                     al, ZERO_ASCII
    jl                      badInput
    cmp                     al, NINE_ASCII
    jg                      badInput
    loop                    count
    jmp                     goodInput

    negativeNumber:
    cmp                     ecx, inputLength    ;If found a (-) after first element
    jne                     badInput
    mov                     sign, MINUS_ASCII
    loop                    count
    jmp                     goodInput

    positiveNumber:
    cmp                     ecx, inputLength    ;If found a (+) after first element
    jne                     badInput
    loop                    count
    jmp                     goodInput



    badInput:
    jmp                     getNumber           ;If input is not valid; try again


    ;The input number is valid
    goodInput:
    mov                     edx, OFFSET userInput
    mov                     ecx, inputLength
    cmp                     al, MINUS_ASCII
    call                    ParseInteger32


    jo                      badInput            ;If doenst' fit inside 32 bit register
    .IF                     CARRY?
    jmp                     badInput
    .ENDIF


    ; Convert to absolute value (positive) number if it was negative
    cdq
    xor                     eax, edx
    sub                     eax, edx

    cmp                     sign, MINUS_ASCII
    je                      negate
    jmp                     finish

    negate:
    neg                     eax

    finish:
    mov                     sign, 0
    mov                     edx, [ebp + 40]
    mov                     ebx, [ebp + 36]
    imul                    ebx, 4
    mov                     [edx + ebx], eax


    finishReading:
    popad
    ret                     12

readVal ENDP


;------------------------------------------------------------------------------------
; Procedure: writeVal
; Description: convert numbers into string of digits and display them on the console
; Receives: array of values and size of the array
; Returns: write of 10 valid signed integers inputted from user to the console
; Registers changed: eax, ecx, edi, ebp, al
;------------------------------------------------------------------------------------
writeVal PROC
    push                    ebp
    mov                     ebp, esp
    mov                     edi, [ebp + 12]
    mov                     ecx, [ebp + 8]

    writer:
    mov                     eax, [edi]
    cmp                     eax, 0
    jl                      negative

    positive:
    call                    WriteDec
    jmp                     comma

    negative:
    push                    eax
    mov                     al, MINUS_ASCII
    call                    WriteChar
    pop                     eax
    cdq
    xor                     eax, edx
    sub                     eax, edx
    call                    WriteDec



    comma:
    cmp                     ecx, 1
    je                      finish
    macroDisplayString      commaCharacter
    add                     edi, 4

    ; No comma needed
    looper:
    loop                    writer


    finish:
    pop                     ebp
    ret                     8


writeVal ENDP


;----------------------------------------------------------------------
; Procedure: calculateSum
; Description: calculate the sum of the 10 signed integers in the array
; Receives: array, arraySize and the sum variable
; Returns: the calculated sum of the 10 signed integers
; Registers changed: eax, ebx, ecx, edi, ebp
;----------------------------------------------------------------------
calculateSum PROC
    push                    ebp
    mov                     ebp, esp
    mov                     edi, [ebp + 16]         ;OFFSET of array
    mov                     ecx, [ebp + 12]         ;ARRAYSIZE
    mov                     ebx, [ebp + 8]          ;Sum

    looper:
    mov                     eax, [edi]
    add                     ebx, eax
    add                     edi, 4

    loop                    looper


    macroDisplayString      sumOfNumbers

    mov                     eax, ebx
    cmp                     eax, 0
    jl                      negativeSum
    call                    WriteDec                ;Write unsigned if positive
    jmp                     continue

    negativeSum:
    call                    WriteInt                ;Write signed if negative

    continue:
    call                    CRLF
    mov                     sum, ebx

    pop                     ebp
    ret                     8

calculateSum ENDP


;------------------------------------------------------------
; Procedure: calculateAverage
; Description: calculates the average of the 10 signed integers
; Receives: avergage and sum variables
; Returns: the average of the numbers
; Registers changed: eax, ebx, edx, ebp, al
;------------------------------------------------------------
calculateAverage PROC
    push                    ebp
    mov                     ebp, esp

    macroDisplayString      averageOfNumbers

    mov                     eax, [ebp + 8]
    mov                     ebx, ARRAYSIZE
    mov                     edx, 0 ;Will hold remainder

    cmp                     eax, 0
    jl                      convertToPositive
    jmp                     dontConvert

    convertToPositive:
    mov                     sign, MINUS_ASCII
    mov                     edx, OFFSET negativeSign
    call                    WriteString
    mov                     edx, 0
    neg                     eax

    dontConvert:
    cdq
    div                     ebx
    cmp                     al, 0
    je                      zeroed
    jmp                     continue

    zeroed:
    add                     eax, 1
    call                    WriteDec
    jmp                     finish



    continue:
    cmp                     eax, 0
    jl                      negativeAverage
    call                    WriteDec
    jmp                     finish


    negativeAverage:
    call                    WriteInt


    finish:
    pop                     ebp
    ret                     8

calculateAverage ENDP


END main
