.ORIG x3000

LD R6, BOTTOM_OF_STACK
JSR main
HALT
BOTTOM_OF_STACK .FILL xC000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; main
main
    ADD R6, R6, #-1
    STR R7, R6, #0

    ; Test 1
    LEA R0, szMsg1
    PUTS

    LD R0, INPUT11
    JSR subPrintNum
    LD R0, NL
    OUT

    ; Test 2
    LEA R0, szMsg2
    PUTS

    LD R0, INPUT21
    JSR subPrintNum
    LD R0, NL
    OUT

    ; Test 3
    LEA R0, szMsg3
    PUTS

    LD R0, INPUT31
    JSR subPrintNum
    LD R0, NL
    OUT

    ; Test 4
    LEA R0, szMsg4
    PUTS

    LD R0, INPUT41
    JSR subPrintNum
    LD R0, NL
    OUT

    ; Test 5
    LEA R0, szMsg5
    PUTS

    LD R0, INPUT51
    JSR subPrintNum
    LD R0, NL
    OU

    LDR R7, R6, #0
    ADD R6, R6, #1
    RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This subroutine converts each digit of a
; number to ASCII and then prints it to
; the screen.
;
; Input R0: N as a number
; Output: The number
subPrintNum
    ADD R6, R6, #-2
    STR R1, R6, #0
    STR R7, R6, #1

    and R1, R1, #0
    and R2, R2, #0
    and R3, R3, #0
    and R4, R4, #0
    and R5, R5, #0

    ADD R0, R0, #0
    
    BRn SKIPEF
    SKIPPEE

    and R1, R1, #0
    and R2, R2, #0
    LD R1, VAL ;-100
    LD R2, VAL2  ;100

    ADD R0, R0, R1 ;420-100

    SUB_T1 
        Brnz SUB_T2

        ADD R3, R3, #1 ;1++
        ADD R0, R0, R1 ;Repaat

        BR SUB_T1

    SUB_T2
    
    ADD R0, R0, R2

    and R1, R1, #0
    and R2, R2, #0

    LD R1, VAL3 ;-10
    LD R2, VAL4  ;10


    ADD R0, R0, R1

    SUB_T1B
        Brnz SUB_T2B

         ADD R4, R4, #1 ;1++

        ADD R0, R0, R1 ;Repaat

        BR SUB_T1B

    SUB_T2B

    ADD R0, R0, R2

    and R1, R1, #0

    LD R1, VAL5

    ;ADD R5, R5, R1
    ;ADD R3, R3, R1
    ;ADD R4, R4, R1

    ADD R5, R5, R0


    and R0, R0, #0
    ADD R0, R3, #0    

    BRnz SKIP

    ADD R0, R0, R1
    OUT 

    SKIP

    and R0, R0, #0
    ADD R0, R4, #0

    BRnz SKIP2

    ADD R0, R0, R1
    OUT
    SKIP2
    
    and R0, R0, #0
    ADD R0, R5, #0

    ADD R0, R0, R1
    OUT

    BR SKIPEEEE

    SKIPEF

        ADD R2, R0, #0

        LD R1, VAL6
        ADD R0, R1, #0
        OUT

        ADD R0, R2, #0
        
        NOT R0, R0
        ADD R0, R0, #1

        
        BRp SKIPPEE

    SKIPEEEE
    LDR R1, R6, #0
    LDR R7, R6, #1
    ADD R6, R6, #2
    RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Data


NL .FILL #10
OUTPUT .BLKW #2
VAl .FILL #-100
VAL2 .FILL #100
VAL3 .FILL #-10
VAL4 .FILL #10
VAL5 .FILL x30
VAL6 .FILL x2D

INPUT11 .FILL #0
szMsg1 .STRINGZ "Testing 0= "

INPUT21 .FILL #9
szMsg2 .STRINGZ "Testing 9= "

INPUT31 .FILL #15
szMsg3 .STRINGZ "Testing 15= "

INPUT41 .FILL #312
szMsg4 .STRINGZ "Testing 312= "

INPUT51 .FILL #-99
szMsg5 .STRINGZ "Testing -99= "

.END