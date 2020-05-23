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
    ; Range [1 .. 400]
    LOWER_RANGE     EQU     1
    UPPER_RANGE     EQU     400

.data
    ; Introduction and program instructions
    welcome         BYTE    "Composite Numbers   Programmed by Emanuel Ramirez", 0
    programInfo     BYTE    "Enter the number of composites numbers you would "
                    BYTE    "like to see.", 0


.code

; --------------------
; Main procedure
; --------------------
main PROC
    call            introduction
    exit
main ENDP


introduction PROC
    ret
introduction ENDP


END main
