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
    LEA R0, INPUT11
    JSR subConvASCII3

    LD R1, EXPECT1
    NOT R1, R1
    ADD R1, R1, #1
    ADD R2, R0, R1

    BRz SAME1
        LEA R0, szNOT_EQ1
        PUTS
        LD R0, NL
        OUT
        BR END1
    SAME1
        LEA R0, szEQ1
        PUTS
        LD R0, NL
        OUT
    END1

    ; Test 2
    LEA R0, INPUT21
    JSR subConvASCII3

    LD R1, EXPECT2
    NOT R1, R1
    ADD R1, R1, #1
    ADD R2, R0, R1

    BRz SAME2
        LEA R0, szNOT_EQ2
        PUTS
        LD R0, NL
        OUT
        BR END2
    SAME2
        LEA R0, szEQ2
        PUTS
        LD R0, NL
        OUT
    END2

    ; Test 3
    LEA R0, INPUT31
    JSR subConvASCII3

    LD R1, EXPECT3
    NOT R1, R1
    ADD R1, R1, #1
    ADD R2, R0, R1

    BRz SAME3
        LEA R0, szNOT_EQ3
        PUTS
        LD R0, NL
        OUT
        BR END3
    SAME3
        LEA R0, szEQ3
        PUTS
        LD R0, NL
        OUT
    END3

    LDR R7, R6, #0
    ADD R6, R6, #1
    RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Input R0: Address of ARRAY that contains a number
;       in ASCII format
; Returns: The number

subConvASCII3

    ADD R6, R6, #-2
    STR R1, R6, #0
    STR R7, R6, #1

    and R4, R4, #0
    and R3, R3, #0   

    ;R4 = -30

    LD R4, VAL
    NOT R4, R4
    ADD R4, R4, #1

    LDR R1, R0, #0
    LDR R2, R0, #1
    LDR R3, R0, #2

    
    ADD R1, R1, R4
    ADD R2, R2, R4
    ADD R3, R3, R4

    and R4, R4, #0
    LD R4, DUB

    main_loop
        BRz main_loopB

        ADD R5, R5, R1

        ADD R4, R4, #-1       

        BR main_loop
    main_loopB

    ADD R1, R5, #0
    and R5, R5, #0

    and R4, R4, #0
    LD R4, DUB2

    main_loop2
        BRz main_loopB2

        ADD R5, R5, R2

        ADD R4, R4, #-1       

        BR main_loop2
    main_loopB2

    ADD R2, R5, #0
    

    ADD R0, R1, R2
    ADD R0, R0, R3

  
    LDR R7, R6, #1
    ADD R6, R6, #2
    RET

    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Data
NL .FILL #10
VAL .FILL x30
DUB .FILL #100
DUB2 .FILL #10


INPUT11 .FILL x30
        .FILL x30
        .FILL x33
        .FILL x0
EXPECT1 .FILL #3
szNOT_EQ1 .STRINGZ "Test 1 failed (should be x3)"
szEQ1 .STRINGZ "Test 1 success"

INPUT21 .FILL x30
        .FILL x30
        .FILL x30
        .FILL x0
EXPECT2 .FILL #0
szNOT_EQ2 .STRINGZ "Test 2 failed (should be x0)"
szEQ2 .STRINGZ "Test 2 success"

INPUT31 .FILL x35
        .FILL x31
        .FILL x32
        .FILL x0
EXPECT3 .FILL #512
szNOT_EQ3 .STRINGZ "Test 3 failed (should be x200)"
szEQ3 .STRINGZ "Test 3 success"

.END
