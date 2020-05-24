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
    ; Introduction and program instructions

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

    unsortedTitle   BYTE    "Your unsorted random numbers:",0
    sortedTitle     BYTE    "Your sorted random numbers:",0
    medianTitle     BYTE    "List Median: ", 0
    instanceTitle   BYTE    "Tour list of instances of each generated number", 0




.code

; --------------------
; Main procedure
; --------------------
main PROC

    ; Initialize random number generator
    call            Randomize

    ; Program instroduction
    push            OFFSET programTitle
    push            OFFSET programmerName
    push            OFFSET programInfo
    call            introduction

    exit
main ENDP


introduction PROC
    ; Set stack frame
    push            ebp
    mov             ebp, esp

    ; Print program title
    mov             edx, [ebp + 16]
    call            WriteString
    call            CRLF

    ; Print program author name
    mov             edx, [ebp + 12]
    call            WriteString
    call            CRLF

    ; Print program's description
    mov             edx, [ebp + 8]
    call            WriteString
    call            CRLF


    ; Restore the stack
    pop             ebp

    ret             8
introduction ENDP


END main
