;-------------------------------------------------------;
; Name:      Messaging_For_8x136_Matrix_Display.INC
; Use:       Messaging For 8x136 Matrix Display Routines Header File
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
#DEFINE _MESSAGING.INC_
;-------------------------------------------------------;

;-------------------------------------------------------;
; Defines
;-------------------------------------------------------;
#DEFINE MAX_DISPLAY          6
#DEFINE MIN_DISPLAY          1
#DEFINE DISPLAY_MASK         H'0F'
    ;---------------------------------------------------;
#DEFINE TIMER_100MS_RELOAD     20 ; * 5ms = 100ms
#DEFINE TIMER_250MS_RELOAD     50 ; * 5ms = 250ms
#DEFINE TIMER_1SEC_RELOAD     200 ; * 5ms =   1S
#DEFINE TIMER_2SEC_RELOAD     400 ; * 5ms =   2S
#DEFINE TIMER_3SEC_RELOAD     600 ; * 5ms =   2S
#DEFINE TIMER_4SEC_RELOAD     800 ; * 5ms =   2S
#DEFINE TIMER_5SEC_RELOAD    1000 ; * 5ms =   5S
#DEFINE TIMER_10SEC_RELOAD   2000 ; * 5ms =  15S
#DEFINE TIMER_15SEC_RELOAD   3000 ; * 5ms =  15S
    ;---------------------------------------------------;
#DEFINE INIT_FLAG_BIT        0
#DEFINE INIT_FLAG            Messaging_Flags, INIT_FLAG_BIT
#DEFINE UPDATE_FLAG_BIT      1
#DEFINE UPDATE_FLAG          Messaging_Flags, UPDATE_FLAG_BIT

;-------------------------------------------------------;

;-------------------------------------------------------;
; Macros
;-------------------------------------------------------;
SET_CURSOR_M MACRO position
    MOVLW   position
    MOVWF   Buffer_Digit_Ptr
    ENDM
    ;---------------------------------------------------;
PRINT_CHAR_M MACRO character
    MOVLW   character
    CALL    _Print_Char
    ENDM
;-------------------------------------------------------;

;-------------------------------------------------------;
#IFDEF _MESSAGING.ASM_
;-------------------------------------------------------;
    ; Global Routines
    ;---------------------------------------------------;
    GLOBAL  _Initialize_Messaging_Subsystem
    ;---------------------------------------------------;
    GLOBAL  _Update_Messaging
;-------------------------------------------------------;
#ELSE ; !_MESSAGING.ASM_
;-------------------------------------------------------;
    ; External Routines
    ;---------------------------------------------------;
    EXTERN  _Initialize_Messaging_Subsystem
    ;---------------------------------------------------;
    EXTERN  _Update_Messaging
;-------------------------------------------------------;
#ENDIF ; !_MESSAGING.ASM_
;-------------------------------------------------------;
