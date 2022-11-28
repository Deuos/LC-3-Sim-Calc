.ORIG x3000

LD R6, BOTTOM_OF_STACK
JSR main
HALT
BOTTOM_OF_STACK .FILL xC000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; main
main
    ADD R6, R6, #-3
    STR R7, R6, #0
    STR R2, R6, #1
    STR R3, R6, #2

    ADD R2, R2, #0
    ADD R3, R3, #0
    
    ;NUMBER 1
    LEA R0, szMsgA
    PUTS
    LEA R1, ARRAY
    GETC
    STR R0, R1, #0      ;Inputs first 3 numbers
    GETC
    STR R0, R1, #1
    GETC
    STR R0, R1, #2
    LEA R0, ARRAY    
    PUTS
    JSR subConvASCII3
    ADD R2, R0, #0


    ;OPERATION   
    LEA R0, szMsgOp
    PUTS
    LEA R1, OPERATION
    GETC
    STR R0, R1, #0    ;getting the sign
    LEA R0, OPERATION
    PUTS
    
    
    ;NUMBER 2
    LEA R0, szMsgB
    PUTS
    LEA R1, ARRAY2 
    GETC
    STR R0, R1, #0      ;Inputs another 3 numbers
    GETC
    STR R0, R1, #1
    GETC
    STR R0, R1, #2
    LEA R0, ARRAY2
    PUTS
    JSR SUBCONVASCII3
    ADD R3, R0, #0   ;Stores second into R3
    

    ;RESULT
    LEA R0, szMsgR       
    PUTS

    ;INPUT BRANCH TO CHECK - or +
    LD R0, OPERATION    ;sign
    LD R1, POSITIVESIGN ;PLUS
    NOT R1, R1
    ADD R1, R1, #1
    ADD R5, R0, R1
    BRz END
    NOT R3, R3
    ADD R3, R3, #1
    ADD R0, R2, R3
    BR FINISH
    END
    ADD R0, R2, R3
    FINISH
    JSR SUBPRINTNUM 
    

    
    LDR R7, R6, #0
    LDR R2, R6, #1
    LDR R3, R6, #2
    ADD R6, R6, #3
    RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This subroutine converts each digit of a
; number to ASCII and then prints it to
; the screen.
;
; Input R0: N as a number
; Output: The number
subPrintNum
    ADD R6, R6, #-3
    STR R7, R6, #0
    STR R2, R6, #1
    STR R3, R6, #2

    and R2, R2, #0  
    and R3, R3, #0    ;Counter Variable
    and R4, R4, #0    
    and R5, R5, #0    

    ADD R5, R0, #0  ;R5 is R0

    BRn NEGATIVE
    START
    LD R1, NEGHUN
    LD R2, POSHUN
    ADD R0, R0, #0
    
    ADD R0, R0, R1
    CHECK     
    BRn LOOP   
    ADD R3, R3, #1
    ADD R0, R0, R1 
    BR CHECK
    LOOP
    ADD R0, R0, R2
    ADD R5, R0, #0
    ADD R0, R3, #0
    BRz SKIP
    LD R1, VALUE ;R1 = x30
    ADD R0, R0, R1    
    OUT
    ADD R4, R0, #0
    SKIP
    


    LD R1, NEGTEN
    LD R2, POSTEN
    and R3, R3, #0
    ADD R0, R5, R1
    CHECK1     
    BRn LOOP1   
    ADD R3, R3, #1
    ADD R0, R0, R1
    BR CHECK1
    LOOP1
    ADD R0, R0, R2
    ADD R5, R0, #0
    ADD R0, R3, #0
    BRz SKIP1
    JUMP
    LD R1, VALUE ;R1 = x30
    ADD R0, R0, R1
    OUT
    BR EXIT
    SKIP1
    ADD R4, R4, #0
    BRp JUMP
    EXIT

    and R3, R3, #0
    ADD R0, R5, #-1
    CHECK2     
    BRn LOOP2   
    ADD R3, R3, #1
    ADD R0, R0, #-1
    BR CHECK2
    LOOP2
    ADD R5, R0, #0
    ADD R0, R3, #0
    LD R1, VALUE ;R1 = x30
    ADD R0, R0, R1
    OUT
    BR DONE

    NEGATIVE
    LD R1, NEGATIVESIGN
    ADD R0, R1, #0
    OUT
    ADD R0, R5, #0
    NOT R0, R0
    ADD R0, R0 #1
    BR START

    DONE
    LDR R7, R6, #0
    LDR R2, R6, #1
    LDR R3, R6, #2
    ADD R6, R6, #3
    RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Data

subConvASCII3

    ADD R6, R6, #-3
    STR R7, R6, #0
    STR R2, R6, #1
    STR R3, R6, #2
    ; TODO 2: Identify registers to save
    ;   and complete prologue

    ; TODO 1: Complete body first
    and R2, R2, #0
    and R3, R3, #0
    and R4, R4, #0
    and R5, R5, #0

    LD R1, VALUE
    NOT R1, R1
    ADD R1, R1, #1    

    LDR R2, R0, #0
    ADD R2, R2, R1    

    LDR R3, R0, #1
    ADD R3, R3, R1    


    LDR R4, R0, #2
    ADD R4, R4, R1
    
    LD R1, HUN
    
    ZERO
    BRz ENDLOOP
    ADD R5, R5, R1
    ADD R2, R2, -1
    BR ZERO
    ENDLOOP 
    and R2, R2, #0
    ADD R2, R5, #0

    and R5, R5, #0
    LD R1, TEN
    ZERO1
    BRz ENDLOOP1
    ADD R5, R5, R1
    ADD R3, R3, -1
    BR ZERO1
    ENDLOOP1 
    and R3, R3, #0
    ADD R3, R5, #0

    ADD R3, R3, R4
    ADD R0, R2, R3
  
    ; TODO 3: Mirror the prologue and complete epilogue
    
    LDR R7, R6, #0
    LDR R2, R6, #1
    LDR R3, R6, #2
    ADD R6, R6, #3
    RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NL .FILL #10
OUTPUT .BLKW #2

OPERATION .FILL #0
          .FILL #0

ARRAY .FILL #0
    .FILL #0
    .FILL #0
    .FILL #0
    
ARRAY2 .FILL #0
    .FILL #0
    .FILL #0
    .FILL #0

VALUE .FILL x30
HUN .FILL 100 ;PART B
TEN .FILL 10 ;PART B


NEGHUN .FILL #-100 ;PART C
POSHUN .FILL #100 ;PART C
NEGTEN .FILL #-10 ;PART C
POSTEN .FILL #10  ;PART C
ONE .FILL #-1
NEGATIVESIGN .FILL x2d
POSITIVESIGN .FILL x2b
          
szMsgA .STRINGZ " A: "
szMsgOp .STRINGZ " Operation: "
szMsgB .STRINGZ " B: "
szMsgR .STRINGZ " Result: "

.END
