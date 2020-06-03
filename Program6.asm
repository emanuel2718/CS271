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
    ARRAYSIZE               EQU     200

.data
    ;Introduction and program instructions
    programTitle            BYTE    "PROGRAMMING ASSIGNMENT 6: Designing low-level I/O procedures", 0
    programmerName          BYTE    "Written by: Emanuel Ramirez", 0

    programDescription0     BYTE    "Please provide 10 signed decimal integers", 0

    programDescription1     BYTE    "Each number needs to be small enough to fit "
                            BYTE    "inside a 32 bit register", 0

    programDescription2     BYTE    "After you have finished inputting the raw numbers "
                            BYTE    "I will display a list of the integers, "
                            BYTE    "their sum, and their average value", 0

    askForNumber            BYTE    "Please enter a signed number: ", 0

    errorMessage            BYTE    "ERROR: You did not enter a signed number or "
                            BYTE    "your number was too big", 0

    tryAgain                BYTE    "Please try again: ", 0
    
    
    numbersEntered          BYTE    "You entered the following numbers: ", 0

    sumOfNumbers            BYTE    "The sum of these numbers is: ", 0
    averageOfNumbers        BYTE    "The rounded average is: ", 0

    exitMessage             BYTE    "Thanks for playing!", 0


    
    
    



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
