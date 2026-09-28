;-------------------------------------------------------;
; Name:      Messaging_For_8x136_Matrix_Display.ASM
; Use:       Messaging For 8x136 Matrix Display Routines
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
#DEFINE  _MESSAGING.ASM_
#INCLUDE Common.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
MESSAGING_DATA   UDATA
;-------------------------------------------------------;
Char_To_Print    res 1
Current_Display  res 1
Saved_Display    res 1
Update_Timer_HI  res 1
Update_Timer_LO  res 1
Colon_Timer_HI   res 1
Colon_Timer_LO   res 1
Display_Timer_HI res 1
Display_Timer_LO res 1
Saved_Seconds    res 1
DOW_CharPtr      res 1
CLOCK_Flags1     res 1
CLOCK_Flags2     res 1
Messaging_Flags  res 1
This_Digit       res 1
;-------------------------------------------------------;
MESSAGING_CODE   CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
_Update_Messaging:
;-------------------------------------------------------;
    BANKSEL MEMORY
    BTFSC   MSGS_ENABLED_FLAG
    GOTO    _UC_Timers
    DECF    Display_Timer_LO, F
    MOVLW   H'FF'
    XORWF   Display_Timer_LO, W
    SKPZ
	;---------------------------------------------------;
    RETURN
	;---------------------------------------------------;
    DECF    Display_Timer_HI, F
    MOVLW   H'FF'
    XORWF   Display_Timer_HI, W
    SKPZ
	;---------------------------------------------------;
    RETURN
	;---------------------------------------------------;
    MOVFW   Current_Display
    XORLW   H'FF'
    SKPNZ
    GOTO    _UM_Muted_Banner
    CALL    _Clear_Buffer
    CALL    _Update_Matrix
    MOVLW   H'FF'
    MOVWF   Display_Timer_LO
    MOVWF   Display_Timer_HI
	;---------------------------------------------------;
    RETURN
	;---------------------------------------------------;
_UM_Muted_Banner:
	;---------------------------------------------------;
    CALL    _Print_Msgs_Disabled
    MOVLW   H'FE'
    MOVWF   Current_Display
    MOVLW   10
    BANKSEL Slot_Dwell
    MOVWF   Slot_Dwell
    CALL    _Load_Dwell_Timer
	;---------------------------------------------------;
    RETURN
	;---------------------------------------------------;
_UC_Timers:
	;---------------------------------------------------;
    DECF    Display_Timer_LO, F
    MOVLW   H'FF'
    XORWF   Display_Timer_LO, W
    SKPZ
    RETURN
    DECF    Display_Timer_HI, F
    MOVLW   H'FF'
    XORWF   Display_Timer_HI, W
    SKPZ
    RETURN
    INCF    Current_Display, F
    MOVLW   14
    SUBWF   Current_Display, W
    SKPNC
    CLRF    Current_Display
    CALL    _EE_Print_Slot
    CALL    _Load_Dwell_Timer
	;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;
    
;-------------------------------------------------------;
_Print_Msgs_Disabled:
;-------------------------------------------------------;
    CALL    _Clear_Buffer
    BANKSEL This_Digit
    CLRF    This_Digit
	;---------------------------------------------------;
_PMD_Loop:
	;---------------------------------------------------;
    MOVFW   This_Digit
    MOVWF   Buffer_Digit_Ptr
    MOVFW   This_Digit
    MOVWF   FSR1L
    MOVLW   HIGH _Str_Msgs_Disabled
    IORLW   H'80'
    MOVWF   FSR1H
    MOVLW   LOW  _Str_Msgs_Disabled
    ADDWF   FSR1L, F
    SKPNC
    INCF    FSR1H, F
    MOVFW   INDF1
    CALL    _Print_Char
    INCF    This_Digit, F
    MOVLW   MAX_DIGITS
    XORWF   This_Digit, W
    SKPZ
    GOTO    _PMD_Loop
    GOTO    _Update_Matrix
;-------------------------------------------------------;
    
;-------------------------------------------------------;
_Print_Version_String:
;-------------------------------------------------------;
    CALL    _Clear_Buffer
    ;---------------------------------------------------;
    BANKSEL This_Digit
    CLRF    This_Digit
    ;---------------------------------------------------;
_PVS_Loop:
    ;---------------------------------------------------;
    MOVFW   This_Digit
    MOVWF   Buffer_Digit_Ptr
    ;---------------------------------------------------;
    MOVFW	This_Digit
    MOVWF   FSR1L
    ;---------------------------------------------------;
    MOVLW   HIGH _Str_Version
    IORLW   H'80'
    MOVWF   FSR1H
    ;---------------------------------------------------;
    MOVLW   LOW  _Str_Version
    ADDWF   FSR1L, F
    SKPNC
    INCF    FSR1H, F
    ;---------------------------------------------------;
    MOVFW   INDF1
    ;---------------------------------------------------;
    CALL    _Print_Char
    ;---------------------------------------------------;
    INCF    This_Digit, F
    ;---------------------------------------------------;
    MOVLW   MAX_DIGITS
    XORWF   This_Digit, W
    SKPZ
    GOTO    _PVS_Loop
    ;---------------------------------------------------;
    GOTO    _Update_Matrix
;-------------------------------------------------------;

;-------------------------------------------------------;
_Load_Msgs_Enabled_Flag:
;-------------------------------------------------------;
; EE 0xFE → RAM MSGS_ENABLED_FLAG
; 0x00 muted. 0x01 or virgin 0xFF enabled.
;-------------------------------------------------------;
    BANKSEL MEMORY
    MOVLW   EE_FLAGS
    MOVWF   EE_Addr
    CALL    _EE_Read_Byte
    BANKSEL MEMORY
    MOVFW   EE_Data
    SKPNZ
    GOTO    _LM_Muted
    BSF     MSGS_ENABLED_FLAG
    RETURN
_LM_Muted:
    BCF     MSGS_ENABLED_FLAG
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
#IFDEF _CODE_TO_DELETE_LATER_
;-------------------------------------------------------;
_Init_Display:
;-------------------------------------------------------;
    MOVFW   Current_Display
    XORWF   Saved_Display, W
    SKPNZ
    ;---------------------------------------------------;
    RETURN
    ;---------------------------------------------------;
    CALL    _Clear_Buffer
    MOVFW   Current_Display
    MOVWF   Saved_Display
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Print_Welcome_To:
;-------------------------------------------------------;
    CALL    _Init_Display
    ;---------------------------------------------------;
    MOVLW   WELCOME_TO_STRING_PTR
    CALL    _Print_Linear_Buffer_String
    ;---------------------------------------------------;
    GOTO    _Update_Matrix
;-------------------------------------------------------;

;-------------------------------------------------------;
_Print_Dysfunctional:
;-------------------------------------------------------;
    CALL    _Init_Display
    ;---------------------------------------------------;
    MOVLW   DYSFUNCTIONAL_STRING_PTR
    CALL    _Print_Linear_Buffer_String
    ;---------------------------------------------------;
    GOTO    _Update_Matrix
;-------------------------------------------------------;

;-------------------------------------------------------;
_Print_Technologies:
;-------------------------------------------------------;
    CALL    _Init_Display
    ;---------------------------------------------------;
    MOVLW   TECHNOLOGIES_STRING_PTR
    CALL    _Print_Linear_Buffer_String
    ;---------------------------------------------------;
    GOTO    _Update_Matrix
;-------------------------------------------------------;

;-------------------------------------------------------;
_Print_God_Bless_USA:
;-------------------------------------------------------;
    CALL    _Init_Display
    ;---------------------------------------------------;
    MOVLW   GOD_BLESS_USA_STRING_PTR
    CALL    _Print_Linear_Buffer_String
    ;---------------------------------------------------;
    GOTO    _Update_Matrix
;-------------------------------------------------------;

;-------------------------------------------------------;
_Print_Philippines:
;-------------------------------------------------------;
    CALL    _Init_Display
    ;---------------------------------------------------;
    MOVLW   PHILIPPINES_STRING_PTR
    CALL    _Print_Linear_Buffer_String
    ;---------------------------------------------------;
    GOTO    _Update_Matrix
;-------------------------------------------------------;
#ENDIF
;-------------------------------------------------------;

;-------------------------------------------------------;
_Init_Messaging_Subsystem:
;-------------------------------------------------------;
    BANKSEL MEMORY
    ;---------------------------------------------------;
    CALL    _Load_Msgs_Enabled_Flag
    CLRF    CLOCK_Flags1
    CLRF    CLOCK_Flags2
    ;---------------------------------------------------;
    MOVLW   H'FF'
    MOVWF   Saved_Display
    MOVWF   Saved_Seconds
    ;---------------------------------------------------;
    MOVLW   HIGH TIMER_100MS_RELOAD
    MOVWF   Update_Timer_HI
    MOVLW   LOW  TIMER_100MS_RELOAD
    MOVWF   Update_Timer_LO
    ;---------------------------------------------------;
    MOVLW   HIGH TIMER_3SEC_RELOAD
    MOVWF   Display_Timer_HI
    MOVLW   LOW  TIMER_3SEC_RELOAD
    MOVWF   Display_Timer_LO
    CLRF    Current_Display
    ;---------------------------------------------------;
    BSF	    UPDATE_FLAG
    ;---------------------------------------------------;
    CALL    _Clear_Buffer
    CALL    _Update_Matrix
    ;---------------------------------------------------;
    MOVLW	H'FF'
    MOVWF	Current_Display
    BCF     EE_GLASS_FLAG
    CALL    _Print_Version_String
    MOVLW   30
    BANKSEL Slot_Dwell
    MOVWF   Slot_Dwell
    CALL    _Load_Dwell_Timer
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
    END
;-------------------------------------------------------;
