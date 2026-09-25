;-------------------------------------------------------;
; Name:      EEPROM_For_PIC12F1840.INC
; Use:       EEPROM For PIC12F1840 Routines Header File
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
#DEFINE _EEPROM_FOR_PIC12F1840.INC_
;-------------------------------------------------------;
    
;-------------------------------------------------------;
; Defines
;-------------------------------------------------------;
#DEFINE EE_TEST_ADDR    H'00'
#DEFINE EE_TEST_PATTERN H'5A'

#DEFINE EE_GLASS_BIT    2
#DEFINE EE_GLASS_FLAG   Messaging_Flags, EE_GLASS_BIT
;-------------------------------------------------------;
    
;-------------------------------------------------------;
; Macros
;-------------------------------------------------------;
;-------------------------------------------------------;

;-------------------------------------------------------;
#IFDEF _EEPROM_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
    ; Global Routines
    ;---------------------------------------------------;
    GLOBAL  _Initialize_EEPROM_Subsystem
    GLOBAL  _EE_Read_Byte
    GLOBAL  _EE_Write_Byte
    GLOBAL  _EE_Diag_Write
    GLOBAL  _EE_Diag_Read
;-------------------------------------------------------;
#ELSE ; !_EEPROM_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
    ; External Routines
    ;---------------------------------------------------;
    EXTERN  _Initialize_EEPROM_Subsystem
    EXTERN  _EE_Read_Byte
    EXTERN  _EE_Write_Byte
    EXTERN  _EE_Diag_Write
    EXTERN  _EE_Diag_Read
;-------------------------------------------------------;
#ENDIF ; !_EEPROM_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
