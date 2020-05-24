TITLE Program 5     (Program4.asm)

; Author                : Emanuel Ramirez Alsina
; Date Created          : 05/20/2020
; Last Modified:        : 05/24/2020
; OSU email address:    : ramieman@oregonstate.edu
; Course number/section : 271/400
; Project Number        : 05
; Due Date:             : 05/24/2020
; Description           : Sorting random numbers.


INCLUDE Irvine32.inc

.const
    ; Range [10 .. 20]
    LO              EQU     10
    HI              EQU     29

    ARRAYSIZE       EQU     200

.data
    ;Introduction and program instructions
    programTitle    BYTE    "Program: Sorting and Counting Random Integers", 0
    programmerName  BYTE    "Author: Emanuel Ramirez", 0
    programInfo     BYTE    "Description: A program that generates 200 random"
                    BYTE    " numbers in the range [10 ... 29]."
                    BYTE    " It displays the list of random numbers and"
                    BYTE    " then sorts in ascending order. Finally it"
                    BYTE    " then displays the number of instances of each"
                    BYTE    " generated value.", 0

    array           DWORD   ARRAYSIZE DUP(0)
    tempArray       DWORD   ARRAYSIZE DUP(0)

    ;Keep track of the current amount of number on current line
    numbersInLine   DWORD   0

    ;Output formatting
    spaces          BYTE    "    ", 0

    unsortedTitle   BYTE    "Your unsorted random numbers:",0
    sortedTitle     BYTE    "Your sorted random numbers:",0
    medianTitle     BYTE    "List Median: ", 0
    instanceTitle   BYTE    "Tour list of instances of each generated number", 0




.code

; --------------------
; Main procedure
; --------------------
main PROC

    ;Initialize random number generator
    call            Randomize

    ;Program instroduction
    push            OFFSET programTitle
    push            OFFSET programmerName
    push            OFFSET programInfo
    call            introduction

    ;Fill array with randomly generated numbers
    push            OFFSET array
    push            OFFSET LO
    push            OFFSET HI
    push            OFFSET ARRAYSIZE
    call            fillArray

    ;Display unsorted array to the console
    push            OFFSET unsortedTitle
    push            OFFSET ARRAYSIZE
    push            OFFSET array
    call            displayList

    ;Find median of list
    push            OFFSET array
    push            OFFSET ARRAYSIZE
    call            displayMedian



    exit
main ENDP


introduction PROC
    ;Set stack frame
    push            ebp
    mov             ebp, esp

    ;Print program title
    mov             edx, [ebp + 16]
    call            WriteString
    call            CRLF

    ;Print program author name
    mov             edx, [ebp + 12]
    call            WriteString
    call            CRLF

    ;Print program's description
    mov             edx, [ebp + 8]
    call            WriteString
    call            CRLF


    ;Restore the stack
    pop             ebp

    ret             12
introduction ENDP


fillArray PROC
    ;Set stack frame
    push            ebp
    mov             ebp, esp

    mov             ecx, [ebp + 8]  ;Array size
    mov             esi, [ebp + 20] ;Acutal array

    nextNum:

        ;Generate the random numbers
        mov             eax, [ebp + 12]
        sub             eax, [ebp + 16]
        inc             eax
        call            RandomRange
        add             eax, [ebp + 16]

        ;Add the random number to the array
        mov             [esi], eax
        add             esi, 4
        loop            nextNum


    pop             ebp
    ret             12
fillArray ENDP

displayList PROC

    ;Set stack frame
    push            ebp
    mov             ebp, esp

    ; Display section title
    mov             edx, [ebp + 16] ;Title
    call            CRLF
    call            WriteString
    call            CRLF

    mov             ecx, [ebp + 12] ;ArraySize
    mov             esi, [ebp + 8] ;List

    mov             numbersInLine, 0

    beginLoop:

        ;Display the number and account for spaces
        mov             eax, [esi]
        call            WriteDec
        mov             edx, OFFSET spaces
        call            WriteString
        inc             numbersInLine

        ;Check if new line is needed. If 10 number in the line already
        mov             edx, 0
        mov             eax, numbersInLine
        mov             ebx, 10
        div             ebx
        cmp             ebx, 0

        jne             endLoop
        
        call            CRLF

    endLoop:
        add             esi, 4
        loop            beginLoop

    call            CRLF
    call            CRLF

    pop             ebp
    ret             12


displayList ENDP

displayMedian PROC


    ;Set stack fram
    push            ebp
    mov             ebp, esp



    mov             eax, [ebp + 8] ;ARRAYSIZE
    mov             esi, [ebp + 12] ;Array

    mov             ebx, 4
    mul             ebx
    add             esi, eax
    mov             eax, [esi]
    add             eax, [esi - 4]
    mov             edx, 0
    mov             ebx, 2
    div             ebx

    mov             edx, OFFSET medianTitle
    call            WriteString
    call            WriteDec
    call            CRLF

    pop             ebp
    ret             8

displayMedian ENDP


END main
