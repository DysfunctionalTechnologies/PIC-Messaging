;-------------------------------------------------------;
; Name:      Messaging_For_8x136_Matrix_Display.ASM
; Use:       Messaging For 8x136 Matrix Display Routines
;-------------------------------------------------------;
; Copyright: ©2026 DTP
;            Dysfunctional Technologies, Philippines
;            All Rights Reserved
;-------------------------------------------------------;
; Author:    Timothy S. Carlson
;            Owner, CEO, and CTO
;            Dysfunctional Technologies, Philippines
;-------------------------------------------------------;
; Date:      September 24, 2026
; Version:   V1.00
; Project:   Messaging_8x136_V1.00_PIC12F1840_MAX7219_I2C_IR_Remote
;-------------------------------------------------------;
#DEFINE  _MESSAGING.ASM_ ;
#INCLUDE Common.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
MESSAGING_CODE CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
_Update_Messaging:
;-------------------------------------------------------;
; For Timing Each Display Mode
;-------------------------------------------------------;
_UC_Timers:
    ;---------------------------------------------------;
    DECF    Display_Timer_LO, F
    MOVLW   H'FF'
    XORWF   Display_Timer_LO, W
    SKPZ
    GOTO    _Update_Display
    ;---------------------------------------------------;
    DECF    Display_Timer_HI, F
    MOVLW   H'FF'
    XORWF   Display_Timer_HI, W
    SKPZ
    GOTO    _Update_Display
    ;---------------------------------------------------;
    INCF    Current_Display, F
    BCF	    INIT_FLAG
    MOVLW   MAX_DISPLAY
    XORWF   Current_Display, W
    SKPZ
    GOTO    _UC_Next_Display
    MOVLW   MIN_DISPLAY
    MOVWF   Current_Display
    ;---------------------------------------------------;
_UC_Next_Display:
    ;---------------------------------------------------;
    MOVFW   Current_Display
    ANDLW   DISPLAY_MASK
    BRW
    ;---------------------------------------------------;
    GOTO    _UC_Version       ;  0
    GOTO    _UC_Welcome_To    ;  1
    GOTO    _UC_Dysfunctional ;  2
    GOTO    _UC_Technologies  ;  3
    GOTO    _UC_Philippines   ;  4
    GOTO    _UC_God_Bless_USA ;  5
    MOVLW   MIN_DISPLAY       ;  6
    MOVLW   MIN_DISPLAY       ;  7
    MOVLW   MIN_DISPLAY       ;  8
    MOVLW   MIN_DISPLAY       ;  9
    MOVLW   MIN_DISPLAY       ;  10
    MOVLW   MIN_DISPLAY       ;  11
    MOVLW   MIN_DISPLAY       ;  12
    MOVLW   MIN_DISPLAY       ;  13
    MOVLW   MIN_DISPLAY       ;  14
    MOVLW   MIN_DISPLAY       ;  15
    ;---------------------------------------------------;
    MOVWF   Current_Display   ;
    GOTO    _UC_Next_Display  ;
    ;---------------------------------------------------;
_UC_Version:
    ;---------------------------------------------------;
;    INCF    Current_Display, F
    ;---------------------------------------------------;
_UC_Welcome_To:
_UC_Dysfunctional:
_UC_Technologies:
_UC_Philippines:
_UC_God_Bless_USA:
    ;---------------------------------------------------;
;    MOVLW   HIGH TIMER_1SEC_RELOAD
;    MOVWF   Display_Timer_HI
;    MOVLW   LOW  TIMER_1SEC_RELOAD
;    MOVWF   Display_Timer_LO
    ;---------------------------------------------------;
    CLRF    Display_Timer_HI
    MOVLW   .200          ; ~1 s if T0 is 5 ms
    MOVWF   Display_Timer_LO
    ;---------------------------------------------------;
    BSF		UPDATE_FLAG
;    GOTO    _Update_Display
;-------------------------------------------------------;
_Update_Display:
;-------------------------------------------------------;
    BTFSS   UPDATE_FLAG
    RETURN
    BCF	    UPDATE_FLAG
    ;---------------------------------------------------;
    MOVLW   MAX_DISPLAY
    XORWF   Current_Display, W
    SKPZ
    GOTO    _UD_Next_Display
    ;---------------------------------------------------;
    MOVLW   MIN_DISPLAY
    MOVWF   Current_Display
    ;---------------------------------------------------;
_UD_Next_Display:
    ;---------------------------------------------------;
    MOVFW   Current_Display
    ANDLW   DISPLAY_MASK
    BRW
    ;---------------------------------------------------;
    GOTO    _Print_Version       ;  0
    GOTO    _Print_Welcome_To    ;  1
    GOTO    _Print_Dysfunctional ;  2
    GOTO    _Print_Technologies  ;  3
    GOTO    _Print_Philippines   ;  4
    GOTO    _Print_God_Bless_USA ;  5
    ;---------------------------------------------------;
    MOVLW   MIN_DISPLAY          ;  6
    MOVLW   MIN_DISPLAY          ;  7
    MOVLW   MIN_DISPLAY          ;  8
    MOVLW   MIN_DISPLAY          ;  9
    MOVLW   MIN_DISPLAY          ;  10
    MOVLW   MIN_DISPLAY          ;  11
    MOVLW   MIN_DISPLAY          ;  12
    MOVLW   MIN_DISPLAY          ;  13
    MOVLW   MIN_DISPLAY          ;  14
    MOVLW   MIN_DISPLAY          ;  15
    ;---------------------------------------------------;
    MOVLW   Current_Display      ; 
    GOTO    _UD_Next_Display     ;
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
;    BCF	    UPDATE_FLAG
    ;---------------------------------------------------;
    MOVLW   HIGH TIMER_2SEC_RELOAD
    MOVWF   Display_Timer_HI
    MOVLW   LOW  TIMER_2SEC_RELOAD
    MOVWF   Display_Timer_LO
    CLRF    Current_Display
    ;---------------------------------------------------;
    BSF	    UPDATE_FLAG
    ;---------------------------------------------------;
    CALL    _Clear_Buffer
    CALL    _Update_Matrix
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
    END
;-------------------------------------------------------;
