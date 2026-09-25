;-------------------------------------------------------;
; Name:      Timer_2_For_PIC12F1840.ASM
; Use:       Timer 2 For PIC12F1840 Routines
;-------------------------------------------------------;
; Copyright: (C)2026 DTP
;            Dysfunctional Technologies, Philippines
;            All Rights Reserved
;-------------------------------------------------------;
; Author:    Timothy S. Carlson
;            Owner, CEO, and CTO
;            Dysfunctional Technologies, Philippines
;-------------------------------------------------------;
; Project:   PIC-Messaging
;            - PIC12F1840 (microcontroller)
;            - EEPROM     (data storage)
;            - MAX7219    (8x8 display)
;            - I2C        (peripherals)
;            - IR Remote  (user control & input)
;-------------------------------------------------------;
#DEFINE  _TIMER_2_FOR_PIC12F1840.ASM_
#INCLUDE Common.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
#IF _IR_ENABLED_
;-------------------------------------------------------;

;-------------------------------------------------------;
TIMER_2_CODE CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
_Timer_2_INT_Handler:
;-------------------------------------------------------;
    BANKSEL PIR1
    BTFSC   PIR1, TMR2IF
    GOTO    _Timer_2_INT_Entry
    BANKSEL STATUS
    BCF     STATUS, C
    RETURN
    ;---------------------------------------------------;
_Timer_2_INT_Entry:
    ;---------------------------------------------------;
    BANKSEL TMR2
    MOVLW   TIMER_2_LOAD_VALUE
    MOVWF   TMR2
    BANKSEL MEMORY
    MOVLW   H'FF'
    XORWF   TMR2O, W
    SKPZ
    GOTO    _Timer_2_INT_Increment
    BANKSEL MEMORY
    ;---------------------------------------------------;
#IF _IR_ENABLED_    
    ;---------------------------------------------------;
    BCF     IR_BLOCK_FLAG
    ;---------------------------------------------------;
#ENDIF ; _IR_ENABLED_    
    ;---------------------------------------------------;
    GOTO    _Timer_2_INT_Exit
    ;---------------------------------------------------;
_Timer_2_INT_Increment:
    ;---------------------------------------------------;
    BANKSEL MEMORY
    INCF    TMR2O, F
    ;---------------------------------------------------;
_Timer_2_INT_Exit:
    ;---------------------------------------------------;
    BANKSEL MEMORY
    BSF     TIMER_2_INT_FLAG
    BANKSEL PIR1
    BCF     PIR1, TMR2IF
    BANKSEL STATUS
    BSF     STATUS, C
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Save_And_Reset_Timer_2:
;-------------------------------------------------------;
    BANKSEL T2CON
    BCF     T2CON, TMR2ON      ; Timer off
    MOVLW   TIMER_2_LOAD_VALUE
    MOVWF   TMR2               ; Reset Timer
    MOVFW   TMR2O              ; Save Timer overflow count
    MOVWF   Timer_2_Overflow
    CLRF    TMR2O              ; Clear Timer overflow
    BCF     PIR1, TMR2IF       ; Clear Timer (Overflow) interrupt flag
    BSF     T2CON, TMR2ON      ; Timer on (start timing next pulse)
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Initialize_Timer_2_Subsystem:
;-------------------------------------------------------;
    ; Initialize Timer 2
    ;---------------------------------------------------;
    BANKSEL T2CON
    BCF     T2CON, TMR2ON ; disable timer 2
    ;---------------------------------------------------;
    ; 1111 - 1:16 Postscaler
    ; 1110 - 1:15 Postscaler
    ; 1101 - 1:14 Postscaler
    ; 1100 - 1:13 Postscaler
    ; 1011 - 1:12 Postscaler
    ; 1010 - 1:11 Postscaler
    ; 1001 - 1:10 Postscaler
    ; 1000 - 1:9  Postscaler
    ; 0111 - 1:8  Postscaler
    ; 0110 - 1:7  Postscaler
    ; 0101 - 1:6  Postscaler
    ; 0100 - 1:5  Postscaler
    ; 0011 - 1:4  Postscaler
    ; 0010 - 1:3  Postscaler
    ; 0001 - 1:2  Postscaler
    ; 0000 - 1:1  Postscaler
    ;---------------------------------------------------;
    BANKSEL T2CON
    BCF     T2CON, T2OUTPS3
    BCF     T2CON, T2OUTPS2
    BCF     T2CON, T2OUTPS1
    BSF     T2CON, T2OUTPS0 ; 1:2 Postscale
    ;---------------------------------------------------;
    ; 31.25ns (32Mhz) * 4 = 125ns (8Mhz)
    ; 125ns * 256 = 32us (31,250hz)
    ; 32us * 4 = 128us (7,182hz)
    ;---------------------------------------------------;
    ; 11 - 1:64 Prescaler - Every 2ms
    ; 10 - 1:16 Prescaler - Every 512us
    ; 01 - 1:4  Prescaler - Every 128us
    ; 00 - 1:1  Prescaler - Every 32us
    ;---------------------------------------------------;
    BANKSEL T2CON
    BCF     T2CON, T2CKPS1
    BCF     T2CON, T2CKPS0 ; 1:1 Prescale - 32us
    ;---------------------------------------------------;
    ; Enable Interrupts
    ;---------------------------------------------------;
    BANKSEL PIR1
    BCF     PIR1, TMR2IF  ; Clear overflow bit flag
    BANKSEL PIE1
    BSF     PIE1, TMR2IE  ; Enable Timer2 Interrupt
    BANKSEL INTCON
    BSF     INTCON, PEIE  ; Turn on peripheral (Timer2) interrupt
    BANKSEL TMR2
    CLRF    TMR2
    BANKSEL T2CON
    BSF     T2CON, TMR2ON ; enable timer 2
    ;---------------------------------------------------;
    ; Initialize Variables
    ;---------------------------------------------------;
    BANKSEL MEMORY
    CLRF    Timer_2_Overflow
    CLRF    TMR2O
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
#ENDIF ; _IR_ENABLED_
;-------------------------------------------------------;

;-------------------------------------------------------;
    END
;-------------------------------------------------------;
