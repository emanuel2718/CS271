TITLE Program 6     (Program4.asm)

; Author                : Emanuel Ramirez Alsina
; Date Created          : 05/30/2020
; Last Modified:        : 06/03/2020
; OSU email address:    : ramieman@oregonstate.edu
; Course number/section : 271/400
; Project Number        : 06
; Due Date:             : 06/07/2020
; Description           : Designing low-level I/O procedures


INCLUDE Irvine32.inc

.const

    ;Size of the array
    ARRAYSIZE       EQU     200

.data
    ;Introduction and program instructions
    programTitle    BYTE    "PROGRAMMING ASSIGNMENT 6: Designing low-level I/O procedures", 0
    programmerName  BYTE    "Written by: Emanuel Ramirez", 0



.code

;------------------------------------------------------------
; Procedure: main
; Description: program driver
; Receives: none
; Returns: none
; Requires: 
; Registers changed: none
;------------------------------------------------------------
main PROC


    exit
main ENDP


;------------------------------------------------------------
; Procedure: introduction
; Description: 
; Receives: 
; Returns: 
; Requires: 
; Registers changed: 
;------------------------------------------------------------
introduction PROC
introduction ENDP




END main
