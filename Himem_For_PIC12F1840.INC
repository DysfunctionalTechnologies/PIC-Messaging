;-------------------------------------------------------;
; Name:      Himem_For_PIC12F1840.INC
; Use:       High Memory For PIC12F1840 Header File
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
#DEFINE _HIMEM_FOR_PIC12F1840.INC_
;-------------------------------------------------------;

;-------------------------------------------------------;
; Defines
;-------------------------------------------------------;
#DEFINE SPECIAL_DEGREE           250
#DEFINE SPECIAL_AM_PM            251
#DEFINE SPECIAL_DOT              252
#DEFINE SPECIAL_COLON            253
#DEFINE SPECIAL_SLASH            254
    ;---------------------------------------------------;
#DEFINE EOF_MARKER               255
    ;---------------------------------------------------;
#DEFINE STRING_LENGTH            17
#DEFINE VERSION_STRING_PTR       (STRING_LENGTH * 0)
#DEFINE WELCOME_TO_STRING_PTR    (STRING_LENGTH * 1)
#DEFINE DYSFUNCTIONAL_STRING_PTR (STRING_LENGTH * 2)
#DEFINE TECHNOLOGIES_STRING_PTR  (STRING_LENGTH * 3)
#DEFINE PHILIPPINES_STRING_PTR   (STRING_LENGTH * 4)
#DEFINE GOD_BLESS_USA_STRING_PTR (STRING_LENGTH * 5)
    ;---------------------------------------------------;
#DEFINE DOW_LENGTH               3
#DEFINE DOW_STRING_PTR           (STRING_LENGTH * 6)
;-------------------------------------------------------;

;-------------------------------------------------------;
; Macros
;-------------------------------------------------------;
;-------------------------------------------------------;

;-------------------------------------------------------;
#IFDEF _HIMEM_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
    ; Global Routines
    ;---------------------------------------------------;
    GLOBAL  _String_Table
    GLOBAL  _Font_Table
;-------------------------------------------------------;
#ELSE ; !_HIMEM_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
    ; External Routines
    ;---------------------------------------------------;
    EXTERN  _String_Table
    EXTERN  _Font_Table
;-------------------------------------------------------;
#ENDIF ; !_HIMEM_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
