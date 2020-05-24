TITLE Program 5     (Program4.asm)

; Author                : Emanuel Ramirez Alsina
; Date Created          : 05/20/2020
; Last Modified:        : 05/23/2020
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
    programTitle    BYTE    "Sorting and Counting Random Integers", 0
    programmerName  BYTE    "                Programmed by Emanuel Ramirez", 0
    programInfo     BYTE    "This program generates 200 random numbers in "
                    BYTE    "the range [10 ... 29], displays the original "
                    BYTE    "list, sorts the list, displays the median "
                    BYTE    "value, displays the lsit sorted in ascending "
                    BYTE    "order, then displays the number of instances "
                    BYTE    "of each generated value", 0


.code

; --------------------
; Main procedure
; --------------------
main PROC
    call            introduction
    exit
main ENDP


introduction PROC
    mov             edx, OFFSET programTitle
    call            WriteString
    mov             edx, OFFSET programmerName
    call            WriteString
    call            CRLF
    mov             edx, OFFSET programInfo
    call            WriteString
    call            CRLF
    ret
introduction ENDP


END main
