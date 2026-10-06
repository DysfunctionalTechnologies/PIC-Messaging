;-------------------------------------------------------;
; Name:      Timer_1_For_PIC12F1840.ASM
; Use:       Timer 1 For PIC12F1840 Routines
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
#DEFINE  _TIMER_1_FOR_PIC12F1840.ASM_
#INCLUDE Common.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
TIMER_1_DATA UDATA
;-------------------------------------------------------;
TIMER_1_VALUE_L     RES     1
TIMER_1_VALUE_H     RES     1
;-------------------------------------------------------;

;-------------------------------------------------------;
TIMER_1_CODE CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
; Read the free-running count.
; TMR1L first: that read latches TMR1H.
; Low byte is left in W and in TIMER_1_VALUE_L.
; High byte is left in TIMER_1_VALUE_H.
;-------------------------------------------------------;
_Get_Timer_1:
;-------------------------------------------------------;
    BANKSEL MEMORY ; Variables and Timer 1 regs in Bank 0
    MOVF    TMR1L, W
    MOVWF   TIMER_1_VALUE_L
    MOVF    TMR1H, W
    MOVWF   TIMER_1_VALUE_H
    MOVF    TIMER_1_VALUE_L, W
    ;---------------------------------------------------;
    BANKSEL MEMORY ; Select Bank 0 before return as safeguard
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Init_Timer_1_Subsystem:
;-------------------------------------------------------;
    BANKSEL MEMORY ; Variables and Timer 1 regs in Bank 0
    MOVLW   TIMER_1_T1CON_INIT
    MOVWF   T1CON
    ;---------------------------------------------------;
    ; Clear once. Never write TMR1 from a tick.
    ;---------------------------------------------------;
    CLRF    TMR1H
    CLRF    TMR1L
    ;---------------------------------------------------;
    ; No interrupt. This counter is only sampled.
    ;---------------------------------------------------;
    BANKSEL PIE1  ; Bank 1 <- BE CAREFUL
    BANKSEL PIE1
    BCF     PIE1, TMR1IE
    BANKSEL PIR1  ; Bank 0 <- BE CAREFUL
    BCF     PIR1, TMR1IF
    ;---------------------------------------------------;
    BANKSEL MEMORY
    CLRF    TIMER_1_VALUE_L
    CLRF    TIMER_1_VALUE_H
    ;---------------------------------------------------;
    BANKSEL MEMORY ; Select Bank 0 before return as safeguard
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
    END
;-------------------------------------------------------;
