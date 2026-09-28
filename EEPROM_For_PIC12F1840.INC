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
EE_TEST_ADDR      EQU H'FF'
EE_TEST_PATTERN   EQU H'5A'
EE_FLAGS          EQU H'FE'
EE_FLAG_MSG_ON    EQU 0
;-------------------------------------------------------;
    
;-------------------------------------------------------;
; Macros
;-------------------------------------------------------;
;-------------------------------------------------------;

;-------------------------------------------------------;
#IFDEF _EEPROM_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
    ; Global Data
    ;---------------------------------------------------;
	GLOBAL EE_Addr
	GLOBAL EE_Data
	GLOBAL Slot_Dwell
    ;---------------------------------------------------;

    ;---------------------------------------------------;
    ; Global Routines
    ;---------------------------------------------------;
    GLOBAL _Init_EEPROM_Subsystem
    ;---------------------------------------------------;
    GLOBAL _EE_Read_Byte
    GLOBAL _EE_Write_Byte
#IF _EEPROM_DIAG_ENABLED_
    GLOBAL _EE_Diag_Write
    GLOBAL _EE_Diag_Read
#ENDIF ; _EEPROM_DIAG_ENABLED_
    GLOBAL _EE_Print_Slot
    GLOBAL _Load_Dwell_Timer
;-------------------------------------------------------;
#ELSE ; !_EEPROM_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
    ; External Data
    ;---------------------------------------------------;
	EXTERN EE_Addr
	EXTERN EE_Data
	EXTERN Slot_Dwell
    ;---------------------------------------------------;

    ;---------------------------------------------------;
    ; External Routines
    ;---------------------------------------------------;
    EXTERN _Init_EEPROM_Subsystem
    ;---------------------------------------------------;
    EXTERN _EE_Read_Byte
    EXTERN _EE_Write_Byte
#IF _EEPROM_DIAG_ENABLED_
    EXTERN _EE_Diag_Write
    EXTERN _EE_Diag_Read
#ENDIF ; _EEPROM_DIAG_ENABLED_
    EXTERN _EE_Print_Slot
    EXTERN _Load_Dwell_Timer
;-------------------------------------------------------;
#ENDIF ; !_EEPROM_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
