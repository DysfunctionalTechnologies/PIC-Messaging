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
#DEFINE IDLE_BITMAP_0            240
#DEFINE IDLE_BITMAP_1            241
#DEFINE IDLE_BITMAP_2            242
#DEFINE IDLE_BITMAP_3            243
#DEFINE IDLE_BITMAP_4            244
#DEFINE IDLE_BITMAP_5            245
#DEFINE IDLE_BITMAP_6            246
#DEFINE IDLE_BITMAP_7            247
    ;---------------------------------------------------;
#DEFINE EOF_MARKER               255
;-------------------------------------------------------;

;-------------------------------------------------------;
; Macros
;-------------------------------------------------------;
;-------------------------------------------------------;

;-------------------------------------------------------;
#IFDEF _HIMEM_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
    ; Global Data
    ;---------------------------------------------------;
    GLOBAL _Str_No_Enabled
    GLOBAL _Str_Msgs_Disabled
    GLOBAL _Str_Version
    GLOBAL _Font_Table
    ;---------------------------------------------------;

    ;---------------------------------------------------;
    ; Global Routines
    ;---------------------------------------------------;
    GLOBAL _Init_Himem_Subsystem
;-------------------------------------------------------;
#ELSE ; !_HIMEM_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
    ; External Data
    ;---------------------------------------------------;
    EXTERN _Str_No_Enabled
    EXTERN _Str_Msgs_Disabled
    EXTERN _Str_Version
    EXTERN _Font_Table
    ;---------------------------------------------------;

    ;---------------------------------------------------;
    ; External Routines
    ;---------------------------------------------------;
    EXTERN _Init_Himem_Subsystem
;-------------------------------------------------------;
#ENDIF ; !_HIMEM_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
