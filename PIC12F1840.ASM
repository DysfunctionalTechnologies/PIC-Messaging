;-------------------------------------------------------;
; Name:      PIC12F1840.ASM
; Use:       PIC12F1840 Routines
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
#DEFINE  _PIC12F1840.ASM_
#INCLUDE Common.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
PIC12F1840_CODE CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
_Initialize_Microcontroller:
;-------------------------------------------------------;
    CALL    _Initialize_Oscillator
    CALL    _Initialize_Miscellaneous
    CALL    _Initialize_Ports
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;
 
;-------------------------------------------------------;
_Initialize_Oscillator:
;-------------------------------------------------------;
    BANKSEL OSCCON      ;
    MOVLW   B'11110000' ; 32Mhz
    MOVWF   OSCCON      ;
    ;---------------------------------------------------;
_IO_WaitOsc:
    ;---------------------------------------------------;
    BANKSEL OSCSTAT     ;
    MOVFW   OSCSTAT     ;
    ANDLW   H'79'       ;
    XORLW   H'59'       ; Is HF Osc Locked and Stable?
    BTFSS   STATUS, Z   ;
    GOTO    _IO_WaitOsc ; No, wait
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Initialize_Ports:
;-------------------------------------------------------;
    BANKSEL ANSELA
    CLRF    ANSELA
    BANKSEL LATA
    CLRF    LATA
    BANKSEL TRISA
    CLRF    TRISA
    BANKSEL PORTA
    CLRF    PORTA
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Initialize_Miscellaneous:
;-------------------------------------------------------;
    ; Set options
    ;---------------------------------------------------;
    ; Bit 7 - /RBPU  - 1=PORTB pull-ups disabled
    ; Bit 6 - INTEDG - 1=Interrupt on rising edge
    ;---------------------------------------------------;
    BANKSEL OPTION_REG
    CLRF    OPTION_REG
    ;---------------------------------------------------;
    BANKSEL INTCON
    CLRF    INTCON
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
    END
;-------------------------------------------------------;
