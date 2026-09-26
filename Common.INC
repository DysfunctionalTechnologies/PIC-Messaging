;-------------------------------------------------------;
; Name:      Common.INC
; Use:       Common Stuffs Header File
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
#DEFINE  _COMMON.INC_
#INCLUDE PIC12F1840.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
; Firmware Version Numbers
;-------------------------------------------------------;
#DEFINE	VERSION_MAJOR            H'01'
#DEFINE	VERSION_MINOR            H'00'
;-------------------------------------------------------;

;-------------------------------------------------------;
; Build Flags
;-------------------------------------------------------;
#DEFINE _LEFT_TO_RIGHT_          TRUE
    ;---------------------------------------------------;
#DEFINE _IR_ENABLED_             TRUE
	;---------------------------------------------------;
#DEFINE _EEPROM_DIAG_ENABLED_    FALSE
;-------------------------------------------------------;

;-------------------------------------------------------;
; System Defines
;-------------------------------------------------------;
    ; SYSTEM_Flags1 Bits
    ;---------------------------------------------------;
#DEFINE TIMER_0_INT_BYTE         H'01'
#DEFINE TIMER_0_INT_BIT          0
#DEFINE	TIMER_0_INT_FLAG         SYSTEM_Flags1, TIMER_0_INT_BIT
    ;---------------------------------------------------;
#DEFINE TIMER_1_INT_BYTE         H'02'
#DEFINE TIMER_1_INT_BIT          1
#DEFINE	TIMER_1_INT_FLAG         SYSTEM_Flags1, TIMER_1_INT_BIT
    ;---------------------------------------------------;
#DEFINE TIMER_2_INT_BYTE         H'04'
#DEFINE TIMER_2_INT_BIT          2
#DEFINE TIMER_2_INT_FLAG         SYSTEM_Flags1, TIMER_2_INT_BIT
    ;---------------------------------------------------;
#DEFINE SAVED_GIE_BYTE           H'08'
#DEFINE SAVED_GIE_BIT            3
#DEFINE SAVED_GIE_FLAG           SYSTEM_Flags1, SAVED_GIE_BIT
    ;---------------------------------------------------;
#DEFINE POWER_BYTE               H'10'
#DEFINE POWER_BIT                4
#DEFINE	POWER_FLAG               SYSTEM_Flags1, POWER_BIT
;-------------------------------------------------------;

;-------------------------------------------------------;
; Macros
;-------------------------------------------------------;
TOGGLE_POWER_FLAG_M MACRO
    MOVLW   POWER_BYTE
    XORWF   SYSTEM_Flags1, F
    ENDM
    ;---------------------------------------------------;
TOGGLE_SAVED_GIE_FLAG_M MACRO
    MOVLW   SAVED_GIE_BYTE
    XORWF   SYSTEM_Flags1, F
    ENDM
    ;---------------------------------------------------;
    ;---------------------------------------------------;
SAVE_GIE_M MACRO
    BCF	    SAVED_GIE_FLAG
    BTFSC   INTCON, GIE
    BSF	    SAVED_GIE_FLAG
    ENDM
    ;---------------------------------------------------;
RESTORE_GIE_M MACRO
    BCF	    INTCON, GIE
    BTFSC   SAVED_GIE_FLAG
    BSF	    INTCON, GIE
    ENDM
    ;---------------------------------------------------;
    ;---------------------------------------------------;
TURN_OFF_INTS_M MACRO
    BCF     INTCON, GIE
    ENDM
    ;---------------------------------------------------;
TURN_ON_INTS_M MACRO
    BSF	    INTCON, GIE
    ENDM
    ;---------------------------------------------------;
    ;---------------------------------------------------;
CRASH_AND_BURN_M MACRO
    GOTO    $-2
    ENDM
;-------------------------------------------------------;

;-------------------------------------------------------;
#IFDEF _MAIN.ASM_
;-------------------------------------------------------;
    ; Global Data
    ;---------------------------------------------------;
	GLOBAL SYSTEM_Flags1
	GLOBAL SYSTEM_Flags2
	GLOBAL Temp1
	GLOBAL Temp2
;-------------------------------------------------------;
#ELSE ; !_MAIN.ASM_
;-------------------------------------------------------;
    ; External Data
    ;---------------------------------------------------;
	EXTERN SYSTEM_Flags1
	EXTERN SYSTEM_Flags2
	EXTERN Temp1
	EXTERN Temp2
;-------------------------------------------------------;
#ENDIF ; !_MAIN.ASM_
;-------------------------------------------------------;

;-------------------------------------------------------;
#INCLUDE Himem_For_PIC12F1840.INC
    ;---------------------------------------------------;
#INCLUDE EEPROM_For_PIC12F1840.INC
    ;---------------------------------------------------;
#INCLUDE Timer_0_For_PIC12F1840.INC
#INCLUDE MAX7219.INC
    ;---------------------------------------------------;
#INCLUDE I2C.INC
    ;---------------------------------------------------;
#IF _IR_ENABLED_    
    ;---------------------------------------------------;
#INCLUDE Timer_2_For_PIC12F1840.INC
#INCLUDE IR_For_PIC12F1840.INC
#INCLUDE Remote.INC
    ;---------------------------------------------------;
#ENDIF ; _IR_ENABLED_    
    ;---------------------------------------------------;
#INCLUDE Font.INC
#INCLUDE Messaging_For_8x136_Matrix_Display.INC
;-------------------------------------------------------;
