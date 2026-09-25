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
MESSAGING_CODE CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
_Update_Messaging:
;-------------------------------------------------------;
_UC_Timers:
;-------------------------------------------------------;
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
    ; expired
    INCF    Current_Display, F
    MOVLW   6
    SUBWF   Current_Display, W
    SKPNC
    CLRF    Current_Display
    MOVLW   HIGH TIMER_3SEC_RELOAD
    MOVWF   Display_Timer_HI
    MOVLW   LOW  TIMER_3SEC_RELOAD
    MOVWF   Display_Timer_LO
    CALL    _EE_Print_Slot
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

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
_Print_Version:
;-------------------------------------------------------;
    CALL    _Init_Display
    ;---------------------------------------------------;
    MOVLW   VERSION_STRING_PTR
    CALL    _Print_Linear_Buffer_String
    ;---------------------------------------------------;
    GOTO    _Update_Matrix
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

;-------------------------------------------------------;
_Print_Linear_Buffer_String:
;-------------------------------------------------------;
; W = Offset Into String Array in Linear Memory         ;
;-------------------------------------------------------;
    MOVWF   Temp1
    CLRF    Temp2
    ;---------------------------------------------------;
_PLBS_Loop:
    ;---------------------------------------------------;
    MOVFW   Temp2
    MOVWF   Buffer_Digit_Ptr
    ;---------------------------------------------------;
    MOVFW   Temp1
    MOVWF   FSR1L
    ;---------------------------------------------------;
    MOVLW   HIGH _String_Table
    IORLW   H'80'
    MOVWF   FSR1H
    ;---------------------------------------------------;
    MOVLW   LOW  _String_Table
    ADDWF   FSR1L, F
    SKPNC
    INCF    FSR1H, F
    ;---------------------------------------------------;
    MOVFW   INDF1
    ;---------------------------------------------------;
    CALL    _Print_Char
    ;---------------------------------------------------;
    INCF    Temp1, F
    INCF    Temp2, F
    ;---------------------------------------------------;
    MOVLW   MAX_DIGITS
    XORWF   Temp2, W
    SKPZ
    GOTO    _PLBS_Loop
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Initialize_Messaging_Subsystem:
;-------------------------------------------------------;
    BANKSEL MEMORY
    ;---------------------------------------------------;
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
    MOVLW   HIGH TIMER_5SEC_RELOAD
    MOVWF   Display_Timer_HI
    MOVLW   LOW  TIMER_5SEC_RELOAD
    MOVWF   Display_Timer_LO
    CLRF    Current_Display
    ;---------------------------------------------------;
    BSF	    UPDATE_FLAG
    ;---------------------------------------------------;
    CALL    _Clear_Buffer
    CALL    _Update_Matrix
    ;---------------------------------------------------;
    CLRF    Current_Display
    BCF     EE_GLASS_FLAG
    BSF     UPDATE_FLAG
    CALL    _EE_Print_Slot
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
    END
;-------------------------------------------------------;
