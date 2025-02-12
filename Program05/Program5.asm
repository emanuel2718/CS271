TITLE Program 5     (Program4.asm)

; Author                : Emanuel Ramirez Alsina
; Date Created          : 05/20/2020
; Last Modified:        : 05/24/2020
; OSU email address:    : ramieman@oregonstate.edu
; Course number/section : 271/400
; Project Number        : 05
; Due Date:             : 05/24/2020
; Description           : Sorting random numbers and counting instances.


INCLUDE Irvine32.inc

.const
    ;Range [10 .. 20]
    LO              EQU     10
    HI              EQU     29

    ;Size of the array
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

    ;Array of numbers
    array           DWORD   ARRAYSIZE DUP(0)
    tempArray       DWORD   ARRAYSIZE DUP(0)

    ;Keep track of the current amount of number on current line
    numbersInLine   DWORD   0

    ;Output formatting
    spaces          BYTE    "    ", 0

    ;Section titles outputs
    unsortedTitle   BYTE    "Your unsorted random numbers:",0
    sortedTitle     BYTE    "Your sorted random numbers:",0
    medianTitle     BYTE    "List Median: ", 0
    instanceTitle   BYTE    "Your list of instances of each generated number:", 0

    ;Keeps track of the current number to count the instances
    counter         DWORD   0

    ;Temp variable for the eax register
    temp            DWORD   0

    ;Farewell message
    exitMessage     BYTE    "Goodbye, and thanks for using my program!", 0


.code

;------------------------------------------------------------
; Procedure: main
; Description: program driver
; Receives: none
; Returns: none
; Requires: Randomize
; Registers changed: none
;------------------------------------------------------------
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
    push            OFFSET numbersInLine
    push            OFFSET unsortedTitle
    push            OFFSET ARRAYSIZE
    push            OFFSET array
    call            displayList

    ;Sort list in ascending order
    push            OFFSET array
    push            OFFSET ARRAYSIZE
    call            sortList

    ;Find median of list
    push            OFFSET medianTitle
    push            OFFSET array
    push            OFFSET ARRAYSIZE
    call            displayMedian

    ;Display sorted array to the console
    push            OFFSET sortedTitle
    push            OFFSET ARRAYSIZE
    push            OFFSET array
    call            displayList

    ;Count the instances of each number in the sorted array
    push            OFFSET counter
    push            OFFSET instanceTitle
    push            OFFSET LO
    push            OFFSET array
    push            OFFSET ARRAYSIZE
    call            countList

    ; Display exit message
    push            OFFSET exitMessage
    call            farewell

    exit
main ENDP


;------------------------------------------------------------
; Procedure: introduction
; Description: prints program header and description
; Receives: programTitle, programmerName, programInfo
; Returns: none
; Requires: none
; Registers changed: edx, ebp, esp
;------------------------------------------------------------
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


;------------------------------------------------------------
; Procedure: fillArray
; Description: fills array with random integers
; Receives: array, LO, HI, array size
; Returns: array filled with random integers
; Requires: array size and initialized array
; Registers changed: eax, ebp, ecx, esi, esp
;------------------------------------------------------------
fillArray PROC

    ;Set stack frame
    push            ebp
    mov             ebp, esp

    mov             ecx, [ebp + 8]  ;Array size
    mov             esi, [ebp + 20] ;Acutal array

    ;Loop to the next number
    nextNum:

        ;Generate the random numbers
        mov             eax, [ebp + 12] ; HI -> eax
        sub             eax, [ebp + 16] ; eax - LO
        inc             eax
        call            RandomRange
        add             eax, [ebp + 16] ; eax + LO

        ;Add the random number to the array
        mov             [esi], eax
        add             esi, 4
        loop            nextNum

    pop             ebp
    ret             12
fillArray ENDP


;------------------------------------------------------------
; Procedure: displayList
; Description: display the list integers to the console
; Receives: numbersInLine, unsortedTitle, ARRAYSIZE, array
; Returns: prints the list to the console
; Requires: array must be filled with integers
; Registers changed: eax, ebp, edx, esi, esp
;------------------------------------------------------------
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
    mov             edx, [ebp + 20] ;numbersInLine

    mov             edx, 0

    beginLoop:

        ;Display the number and account for spaces
        mov             eax, [esi]
        call            WriteDec
        mov             edx, OFFSET spaces
        call            WriteString
        inc             edx

        ;Check if new line is needed. If 10 number in the line already
        mov             edx, 0
        mov             eax, edx
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
    ret             16
displayList ENDP


;------------------------------------------------------------
; Procedure: sortList
; Description: sorts the given list of numbers
; Receives: array, size of array
; Returns: sorted list of numbers
; Requires: array must be filled with integers
; Registers changed: eax, ebp, ecx, edx, esi, esp
;------------------------------------------------------------
sortList PROC

    ;Set stack frame
    push            ebp
    mov             ebp, esp

    mov             ecx, [ebp + 8] ;ARRAYSIZE
    mov             esi, [ebp + 12] ;List
    dec             ecx

    ;Start nested loops
    outerLoop:
        
        mov             eax, [esi]
        mov             edx, esi
        push            ecx

        innerLoop:
            
            mov             ebx, [esi + 4]
            mov             eax, [edx]
            cmp             eax, ebx

            ;If eax <= ebx. Jump to swap the numbers
            jle              dontExchange

            ;Else, no need to swap.
            add             esi, 4
            push            esi
            push            edx
            push            ecx
            call            exchange
            sub             esi, 4

            dontExchange:
                add             esi, 4
                loop            innerLoop
        pop             ecx
        mov             esi, edx
        add             esi, 4
        loop            outerLoop

    pop             ebp
    ret             8
sortList ENDP


;------------------------------------------------------------
; Procedure: exchange
; Description: swaps the receved parameters location in the array
; Receives: array[i], array[j]
; Returns: swap the numbers
; Requires: two numbers to be swapped
; Registers changed: eax, ebp, ecx, edx, esi, esp
;------------------------------------------------------------
exchange PROC
    
    ;Set stack frame
    push            ebp
    mov             ebp, esp

    ;Save variables and registers
    pushad

    mov             eax, [ebp + 16] ;array[j]
    mov             ebx, [ebp + 12] ;array[i]
    mov             edx, eax
    sub             edx, ebx

    ;Swap numbers and insert them into the array
    mov             esi, ebx
    mov             ecx, [ebx]
    mov             eax, [eax]
    mov             [esi], eax
    add             esi, edx
    mov             [esi], ecx

    ;Restore
    popad
    pop             ebp
    ret             12
exchange ENDP



;------------------------------------------------------------
; Procedure: displayMedian
; Description: Prints the median value of the array
; Receives: median title, array, size of array
; Returns: median value of the array
; Requires: array must contains sorted integers
; Registers changed: ebp, esp, eax, ebx, ecx, edx
;------------------------------------------------------------
displayMedian PROC


    ;Set stack fram
    push            ebp
    mov             ebp, esp

    mov             eax, [ebp + 8] ;ARRAYSIZE
    mov             edi, [ebp + 12] ;Array

    mov             edx, [ebp + 16]
    call            WriteString

    ;Divide the array size by 2 to find the middle
    mov             ecx, 2
    cdq
    div             ecx

    mov             ecx, 4  ;Size of array TYPE
    mul             ecx
    add             edi, eax ;Add the product to edi
    mov             eax, [edi]
    sub             edi, ecx
    add             eax, [edi]
    mov             ecx, 2

    cdq
    div             ecx

    ;Print the median to the console
    call            WriteDec
    call            CRLF


    pop             ebp
    ret             12
displayMedian ENDP


;------------------------------------------------------------
; Procedure: countList
; Description: counts the instances of each number in the array
; Receives: counter, instanceTitle, LO, array, size of array
; Returns: instances of each number in the array
; Requires: array must contains sorted integers
; Registers changed: eax, ebx, ecx, edx, ebp, esp, esi
;------------------------------------------------------------
countList PROC

    ;Set stack frame
    push            ebp
    mov             ebp, esp

    mov             ecx, [ebp + 8] ;ARRAYSIZE
    mov             esi, [ebp + 12] ;Array
    mov             ebx, [ebp + 16] ;LO

    ; Print Instance title
    mov             edx, [ebp + 20] ;Instance Title
    call            WriteString
    call            CRLF


    nextNumber:
        mov             eax, [esi]
        
        cmp             ebx, eax
        je              increaseCounter


        cmp             ebx, [ebp + 16]
        jg              addOne
        jmp             printCounter

        ;If not first element then add one to the counter
        addOne:
            inc             counter

        ;Print the current number instance counter
        printCounter:

            mov             ebx, eax
            add             esi, 4
            mov             temp, eax
            mov             eax, counter
            mov             edx, OFFSET counter
            call            WriteDec
            mov             eax, temp



            mov             edx, OFFSET spaces
            call            WriteString
            mov             counter, 0

        ;Increase the current number instance counter
        increaseCounter:
            mov             ebx, eax
            inc             counter
            add             esi, 4

        loop            nextNumber


    call            CRLF
    call            CRLF
    pop             ebp
    ret             20
countList ENDP

;------------------------------------------------------------
; Procedure: farewell
; Description: display exit message to the screen
; Receives: exitMessage
; Returns: exits the program
; Requires: none
; Registers changed: edx, ebp
;------------------------------------------------------------
farewell PROC
    ;Set stack frame
    push            ebp
    mov             ebp, esp

    mov             edx, [ebp + 8]
    call            WriteString
    call            CRLF
    exit
farewell ENDP


END main
