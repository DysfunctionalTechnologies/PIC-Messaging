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
	; MAIN
	;---------------------------------------------------;
	GLOBAL SYSTEM_Flags1
	GLOBAL SYSTEM_Flags2
	GLOBAL Temp1
	GLOBAL Temp2
	;---------------------------------------------------;
	; Clock_For_8x136_Matrix_Display
	;---------------------------------------------------;
	GLOBAL Char_To_Print
	GLOBAL Current_Display
	GLOBAL Saved_Display
	GLOBAL Update_Timer_HI
	GLOBAL Update_Timer_LO
	GLOBAL Colon_Timer_HI
	GLOBAL Colon_Timer_LO
	GLOBAL Display_Timer_HI
	GLOBAL Display_Timer_LO
	GLOBAL Saved_Seconds
	GLOBAL DOW_CharPtr
	GLOBAL CLOCK_Flags1
	GLOBAL CLOCK_Flags2
	;---------------------------------------------------;
	; Font
	;---------------------------------------------------;
	GLOBAL Font_Ptr_HI
	GLOBAL Font_Ptr_LO
	GLOBAL Font_Line_Ptr
	GLOBAL Char_To_Find
	;---------------------------------------------------;
	; I2C
	;---------------------------------------------------;
	GLOBAL I2C_Addr
	GLOBAL I2C_Data
	GLOBAL I2C_Byte
	GLOBAL I2C_BitCount
	GLOBAL I2C_ByteCount
	GLOBAL I2C_SavedCount
	GLOBAL I2C_Flags
    ;---------------------------------------------------;
#IF _IR_ENABLED_    
    ;---------------------------------------------------;
	; IR_For_PIC12F1840
	;---------------------------------------------------;
	GLOBAL IR_Status
	GLOBAL IR_Mfg_Code
	GLOBAL IR_Dev_Code
	GLOBAL IR_Op_Code
	GLOBAL IR_Code_0
	GLOBAL IR_Code_1
	GLOBAL IR_Code_2
	GLOBAL IR_Code_3
	GLOBAL IR_Code_Bit_Count
    ;---------------------------------------------------;
#ENDIF ; _IR_ENABLED_    
    ;---------------------------------------------------;
	; MAX_7219
	;---------------------------------------------------;
	GLOBAL Temp_Data
	GLOBAL Char2Print
	GLOBAL BitCount
	GLOBAL Command_HI
	GLOBAL Command_LO
	GLOBAL Intensity
	GLOBAL Matrix_Line_Ptr
	GLOBAL Matrix_Digit_Ptr
	GLOBAL Buffer_Line_Ptr
	GLOBAL Buffer_Digit_Ptr
    ;---------------------------------------------------;
	; Messaging_For_8x136_Matrix_Display
	;---------------------------------------------------;
	GLOBAL Messaging_Flags
    ;---------------------------------------------------;
    ; EEPROM_For_PIC12F1840
    ;---------------------------------------------------;
	GLOBAL EE_Addr
	GLOBAL EE_Data
    ;---------------------------------------------------;
#IF _IR_ENABLED_    
    ;---------------------------------------------------;
	; Timer_2_For_PIC12F1840
	;---------------------------------------------------;
	GLOBAL Timer_2_Overflow
	GLOBAL TMR2O
    ;---------------------------------------------------;
#ENDIF ; _IR_ENABLED_    
;-------------------------------------------------------;
#ELSE ; !_MAIN.ASM_
;-------------------------------------------------------;
    ; External Data
    ;---------------------------------------------------;
	; MAIN
	;---------------------------------------------------;
	EXTERN SYSTEM_Flags1
	EXTERN SYSTEM_Flags2
	EXTERN Temp1
	EXTERN Temp2
	;---------------------------------------------------;
	; Clock_For_8x136_Matrix_Display
	;---------------------------------------------------;
	EXTERN Char_To_Print
	EXTERN Current_Display
	EXTERN Saved_Display
	EXTERN Update_Timer_HI
	EXTERN Update_Timer_LO
	EXTERN Colon_Timer_HI
	EXTERN Colon_Timer_LO
	EXTERN Display_Timer_HI
	EXTERN Display_Timer_LO
	EXTERN Saved_Seconds
	EXTERN DOW_CharPtr
	EXTERN CLOCK_Flags1
	EXTERN CLOCK_Flags2
	;---------------------------------------------------;
	; Font
	;---------------------------------------------------;
	EXTERN Font_Ptr_HI
	EXTERN Font_Ptr_LO
	EXTERN Font_Line_Ptr
	EXTERN Char_To_Find
	;---------------------------------------------------;
	; I2C
	;---------------------------------------------------;
	EXTERN I2C_Addr
	EXTERN I2C_Data
	EXTERN I2C_Byte
	EXTERN I2C_BitCount
	EXTERN I2C_ByteCount
	EXTERN I2C_SavedCount
	EXTERN I2C_Flags
    ;---------------------------------------------------;
#IF _IR_ENABLED_    
    ;---------------------------------------------------;
	; IR_For_PIC12F1840
	;---------------------------------------------------;
	EXTERN IR_Status
	EXTERN IR_Mfg_Code
	EXTERN IR_Dev_Code
	EXTERN IR_Op_Code
	EXTERN IR_Code_0
	EXTERN IR_Code_1
	EXTERN IR_Code_2
	EXTERN IR_Code_3
	EXTERN IR_Code_Bit_Count
    ;---------------------------------------------------;
#ENDIF ; _IR_ENABLED_    
    ;---------------------------------------------------;
	; MAX_7219
	;---------------------------------------------------;
	EXTERN Temp_Data
	EXTERN Char2Print
	EXTERN BitCount
	EXTERN Command_HI
	EXTERN Command_LO
	EXTERN Intensity
	EXTERN Matrix_Line_Ptr
	EXTERN Matrix_Digit_Ptr
	EXTERN Buffer_Line_Ptr
	EXTERN Buffer_Digit_Ptr
    ;---------------------------------------------------;
	; MAX_7219
	;---------------------------------------------------;
	EXTERN Messaging_Flags
    ;---------------------------------------------------;
    ; EEPROM_For_PIC12F1840
    ;---------------------------------------------------;
	EXTERN EE_Addr
	EXTERN EE_Data
    ;---------------------------------------------------;
#IF _IR_ENABLED_    
    ;---------------------------------------------------;
	; Timer_2_For_PIC12F1840
	;---------------------------------------------------;
	EXTERN Timer_2_Overflow
	EXTERN TMR2O
    ;---------------------------------------------------;
#ENDIF ; _IR_ENABLED_    
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
