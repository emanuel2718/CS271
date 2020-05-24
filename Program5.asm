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


.code

; --------------------
; Main procedure
; --------------------
main PROC

    call            Randomize
    call            introduction

    exit
main ENDP


introduction PROC
    mov             edx, OFFSET programTitle
    call            WriteString
    call            CRLF
    mov             edx, OFFSET programmerName
    call            WriteString
    call            CRLF
    mov             edx, OFFSET programInfo
    call            WriteString
    call            CRLF
    ret
introduction ENDP


END main
