;-------------------------------------------------------;
; Name:      Font.INC
; Use:       Font Routines Header File
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
#DEFINE _FONT.INC_
;-------------------------------------------------------;

;-------------------------------------------------------;
; Defines
;-------------------------------------------------------;
;-------------------------------------------------------;
    
;-------------------------------------------------------;
; Macros
;-------------------------------------------------------;
;-------------------------------------------------------;

;-------------------------------------------------------;
#IFDEF _FONT.ASM_
;-------------------------------------------------------;
    ; Global Routines
    ;---------------------------------------------------;
    GLOBAL  _Initialize_Font_Subsystem
    ;---------------------------------------------------;
    GLOBAL  _Reset_Font
    ;---------------------------------------------------;
    GLOBAL  _Reset_Font_Ptr
    GLOBAL  _Set_Font_Ptr
    GLOBAL  _Set_Font_Line_Ptr
    ;---------------------------------------------------;
    GLOBAL  _Next_Font_Char
    GLOBAL  _Next_Font_Line
    GLOBAL  _Set_Font_Line
    ;---------------------------------------------------;
    GLOBAL  _Get_Data_From_Font
    GLOBAL  _Find_Char_In_Font
;-------------------------------------------------------;
#ELSE ; !_FONT.ASM_
;-------------------------------------------------------;
    ; External Routines
    ;---------------------------------------------------;
    EXTERN  _Initialize_Font_Subsystem
    ;---------------------------------------------------;
    EXTERN  _Reset_Font
    ;---------------------------------------------------;
    EXTERN  _Reset_Font_Ptr
    EXTERN  _Set_Font_Ptr
    EXTERN  _Set_Font_Line_Ptr
    ;---------------------------------------------------;
    EXTERN  _Next_Font_Char
    EXTERN  _Next_Font_Line
    EXTERN  _Set_Font_Line
    ;---------------------------------------------------;
    EXTERN  _Get_Data_From_Font
    EXTERN  _Find_Char_In_Font
;-------------------------------------------------------;
#ENDIF ; !_FONT.ASM_
;-------------------------------------------------------;
