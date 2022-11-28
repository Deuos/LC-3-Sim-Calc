.ORIG x3000

LD R6, BOTTOM_OF_STACK
JSR main
HALT
BOTTOM_OF_STACK .FILL xC000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; main
main
    ; Push R1, R2 and R7
    ADD R6, R6, #-3
    STR R1, R6, #0
    STR R2, R6, #1
    STR R7, R6, #2

    LEA R0, strMsgBefore
    PUTS
    LD R0, NL
    OUT

    LEA R0, ARRAY
    JSR subRead3

    LEA R0, strMsgAfter
    PUTS
    LEA R0, ARRAY
    PUTS

    ; Pop R1, R2 and R7
    LDR R1, R6, #0
    LDR R2, R6, #1
    LDR R7, R6, #2
    ADD R6, R6, #3
    RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Read 3 digits from the keyboard, and copy
; them to the array pointed to by R0.
;
; R0: Address of the array
; Return: 0
subRead3
    
    ADD R6, R6, #-2
    STR R1, R6, #0
    STR R7, R6, #1
    ; TODO 2: Identify registers to save
    ;   and complete prologue

    LEA R1, ARRAY

    GETC 
    STR R0, R1, #0

    GETC
    STR R0, R1, #1

    GETC
    STR R0, R1, #2

    LEA R0, ARRAY

    ADD R0, R0, #0
    
    ; TODO 1: Complete body first
    LDR R1, R6, #0
    LDR R7, R6, #1
    ADD R6, R6, #2
    RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Data
NL .FILL #10
strMsgBefore .STRINGZ "Enter a 3-digit number: "
strMsgAfter .STRINGZ "You typed: "

ARRAY .FILL #0
    .FILL #0
    .FILL #0
    .FILL #0

.END
