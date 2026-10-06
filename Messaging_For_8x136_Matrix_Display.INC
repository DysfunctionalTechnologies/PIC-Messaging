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
MIN_DISPLAY            EQU 1
MAX_DISPLAY            EQU 6
DISPLAY_MASK           EQU 0x07
NUM_MATRIX_MODULES     EQU 17
    ;---------------------------------------------------;
TIMER_100MS_RELOAD     EQU 20   ; * 5ms = 100ms
TIMER_250MS_RELOAD     EQU 50   ; * 5ms = 250ms
TIMER_1SEC_RELOAD      EQU 200  ; * 5ms =   1S
TIMER_2SEC_RELOAD      EQU 400  ; * 5ms =   2S
TIMER_3SEC_RELOAD      EQU 600  ; * 5ms =   3S
TIMER_4SEC_RELOAD      EQU 800  ; * 5ms =   4S
TIMER_5SEC_RELOAD      EQU 1000 ; * 5ms =   5S
TIMER_10SEC_RELOAD     EQU 2000 ; * 5ms =  10S
TIMER_15SEC_RELOAD     EQU 3000 ; * 5ms =  15S
    ;---------------------------------------------------;
INIT_FLAG_BYTE         EQU H'01'
INIT_FLAG_BIT          EQU 0
#DEFINE INIT_FLAG          Messaging_Flags, INIT_FLAG_BIT
	;---------------------------------------------------;
UPDATE_FLAG_BYTE       EQU H'02'
UPDATE_FLAG_BIT        EQU 1
#DEFINE UPDATE_FLAG        Messaging_Flags, UPDATE_FLAG_BIT
	;---------------------------------------------------;
EE_GLASS_BYTE          EQU H'04'
EE_GLASS_BIT           EQU 2
#DEFINE EE_GLASS_FLAG      Messaging_Flags, EE_GLASS_BIT
	;---------------------------------------------------;
MSGS_ENABLED_BYTE      EQU H'08'
MSGS_ENABLED_BIT       EQU 3
#DEFINE MSGS_ENABLED_FLAG Messaging_Flags, MSGS_ENABLED_BIT
	;---------------------------------------------------;
EDIT_FLAG_BYTE         EQU H'10'
EDIT_FLAG_BIT          EQU 4
#DEFINE EDIT_FLAG      Messaging_Flags, EDIT_FLAG_BIT
;-------------------------------------------------------;

;-------------------------------------------------------;
; Macros
;-------------------------------------------------------;
TOGGLE_MSGS_ENABLED_FLAG_M MACRO
    MOVLW   MSGS_ENABLED_BYTE
    XORWF   Messaging_Flags, F
    ENDM
    ;---------------------------------------------------;
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
	; Global Data
	;---------------------------------------------------;
	GLOBAL Char_To_Print
	GLOBAL Current_Display
	GLOBAL Saved_Display
	GLOBAL Update_Timer_HI
	GLOBAL Update_Timer_LO
	GLOBAL Display_Timer_HI
	GLOBAL Display_Timer_LO
	GLOBAL Messaging_Flags
    ;---------------------------------------------------;

	;---------------------------------------------------;
    ; Global Routines
    ;---------------------------------------------------;
    GLOBAL _Init_Messaging_Subsystem
    ;---------------------------------------------------;
    GLOBAL _Update_Messaging
    GLOBAL _Load_Msgs_Enabled_Flag
    GLOBAL _Print_Msgs_Disabled
    GLOBAL _Print_No_Enabled
    GLOBAL _Paint_Enable_Prompt
    GLOBAL _Edit_Enter
    GLOBAL _Edit_Yes
    GLOBAL _Edit_No
    GLOBAL _Edit_Next
    GLOBAL _Edit_Exit
;-------------------------------------------------------;
#ELSE ; !_MESSAGING.ASM_
;-------------------------------------------------------;
	; External Data
	;---------------------------------------------------;
	EXTERN Char_To_Print
	EXTERN Current_Display
	EXTERN Saved_Display
	EXTERN Update_Timer_HI
	EXTERN Update_Timer_LO
	EXTERN Display_Timer_HI
	EXTERN Display_Timer_LO
	EXTERN Messaging_Flags
    ;---------------------------------------------------;

    ;---------------------------------------------------;
    ; External Routines
    ;---------------------------------------------------;
    EXTERN _Init_Messaging_Subsystem
    ;---------------------------------------------------;
    EXTERN _Update_Messaging
    EXTERN _Load_Msgs_Enabled_Flag
    EXTERN _Print_Msgs_Disabled
    EXTERN _Print_No_Enabled
    EXTERN _Paint_Enable_Prompt
    EXTERN _Edit_Enter
    EXTERN _Edit_Yes
    EXTERN _Edit_No
    EXTERN _Edit_Next
    EXTERN _Edit_Exit
;-------------------------------------------------------;
#ENDIF ; !_MESSAGING.ASM_
;-------------------------------------------------------;
