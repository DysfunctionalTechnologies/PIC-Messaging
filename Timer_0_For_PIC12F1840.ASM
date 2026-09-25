;-------------------------------------------------------;
; Name:      Timer_0_For_PIC12F1840.ASM
; Use:       Timer 0 For PIC12F1840 Routines
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
#DEFINE  _TIMER_0_FOR_PIC12F1840.ASM_
#INCLUDE Common.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
TIMER_0_CODE CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
_Timer_0_INT_Handler:
;-------------------------------------------------------;
    BTFSC   INTCON, TMR0IF
    GOTO    _Timer_0_INT_Entry
    BCF     STATUS, C
    RETURN
    ;---------------------------------------------------;
_Timer_0_INT_Entry:
    ;---------------------------------------------------;
    MOVLW   TIMER_0_LOAD_VALUE
    MOVWF   TMR0
    ;---------------------------------------------------;
_Timer_0_INT_Exit:
    ;---------------------------------------------------;
    BSF     TIMER_0_INT_FLAG
    BCF     INTCON, TMR0IF
    BSF     STATUS, C
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Wait_For_Timer_0_INT_Flag:
;-------------------------------------------------------;
    BTFSS   TIMER_0_INT_FLAG
    GOTO    _Wait_For_Timer_0_INT_Flag
    BCF	    TIMER_0_INT_FLAG
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Initialize_Timer_0_Subsystem:
;-------------------------------------------------------;
    BANKSEL OPTION_REG
    ;---------------------------------------------------;
    ; This is what the CLRF does to the register
    ;---------------------------------------------------;
    ; BCF OPTION_REG, TMR0CS ;
    ; BCF OPTION_REG, PSA    ; prescaler to timer0
    ; BCF OPTION_REG, PS2    ;
    ; BCF OPTION_REG, PS1    ; 000 - 250ns
    ; BCF OPTION_REG, PS0    ;
    ;---------------------------------------------------;
    BCF     OPTION_REG, TMR0CS
    BCF     OPTION_REG, PSA
    BSF     OPTION_REG, PS2
    BSF     OPTION_REG, PS1
    BSF     OPTION_REG, PS0
    BANKSEL INTCON
    BCF     INTCON, TMR0IF
    BSF     INTCON, TMR0IE
    BANKSEL TMR0
    MOVLW   TIMER_0_LOAD_VALUE
    MOVWF   TMR0
    ;---------------------------------------------------;
    ; Initialize Memory
    ;---------------------------------------------------;
    BANKSEL MEMORY
    BCF     TIMER_0_INT_FLAG
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
    END
;-------------------------------------------------------;
