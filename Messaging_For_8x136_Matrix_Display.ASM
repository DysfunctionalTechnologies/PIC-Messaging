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
	;---------------------------------------------------;
Display_Timer_HI res 1
Display_Timer_LO res 1
Messaging_Flags  res 1
This_Digit       res 1
;-------------------------------------------------------;
MESSAGING_CODE   CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
_Update_Messaging:
;-------------------------------------------------------;
    BANKSEL MEMORY
    BTFSC   EDIT_FLAG
	;---------------------------------------------------;
    RETURN
	;---------------------------------------------------;
    MOVFW   Current_Display
    XORLW   H'FD'
    SKPNZ
    GOTO    _UM_HoldBlank

    BTFSC   MSGS_ENABLED_FLAG
    GOTO    _UC_Timers

    MOVFW   Current_Display
    XORLW   H'FE'
    SKPNZ
    GOTO    _UM_HoldBlank

    MOVFW   Current_Display
    XORLW   H'FF'
    SKPZ
    GOTO    _UM_HoldBlank

;-------------------------------------------------------;
_UM_Muted_Banner:
;-------------------------------------------------------;
    CALL    _Print_Msgs_Disabled
    MOVLW   H'FE'
    MOVWF   Current_Display
    MOVLW   10
    BANKSEL Slot_Dwell
    MOVWF   Slot_Dwell
    CALL    _Load_Dwell_Timer
	;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_UM_HoldBlank:
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
    MOVFW   Current_Display
    XORLW   H'FE'
    SKPNZ
    GOTO    _UM_Idle_Arm
    MOVFW   Current_Display
    XORLW   H'FC'
    SKPNZ
    GOTO    _UM_Idle_Arm
    ;---------------------------------------------------;
    CALL    _Clear_Buffer
    CALL    _Update_Matrix
    MOVLW   H'FF'
    MOVWF   Display_Timer_LO
    MOVWF   Display_Timer_HI
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_UM_Idle_Arm:
;-------------------------------------------------------;
    CALL    _Paint_Idle_Tiles
    BANKSEL MEMORY
    MOVLW   H'FC'
    MOVWF   Current_Display
    CALL    _Load_Idle_Dwell
    ;---------------------------------------------------;
    BANKSEL MEMORY
    RETURN
;-------------------------------------------------------;

;;-------------------------------------------------------;
;_UM_HoldBlank:
;;-------------------------------------------------------;
;    DECF    Display_Timer_LO, F
;    MOVLW   H'FF'
;    XORWF   Display_Timer_LO, W
;    SKPZ
;	;---------------------------------------------------;
;    RETURN
;	;---------------------------------------------------;
;    DECF    Display_Timer_HI, F
;    MOVLW   H'FF'
;    XORWF   Display_Timer_HI, W
;    SKPZ
;	;---------------------------------------------------;
;    RETURN
;	;---------------------------------------------------;
;    CALL    _Clear_Buffer
;    CALL    _Update_Matrix
;    MOVLW   H'FF'
;    MOVWF   Display_Timer_LO
;    MOVWF   Display_Timer_HI
;	;---------------------------------------------------;
;    RETURN
;;-------------------------------------------------------;

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
    MOVFW   Current_Display
    MOVWF   Saved_Display
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
_Edit_Enter:
;-------------------------------------------------------;
    BANKSEL MEMORY
    BSF     EDIT_FLAG
    CLRF    Current_Display
    GOTO    _Paint_Enable_Prompt
;-------------------------------------------------------;

;-------------------------------------------------------;
_Edit_Exit:
;-------------------------------------------------------;
    BANKSEL MEMORY
    BCF     EDIT_FLAG
    CLRF    Current_Display
    MOVWF   Saved_Display
    CALL    _EE_Print_Slot
    CALL    _Load_Dwell_Timer
	;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Edit_Next:
;-------------------------------------------------------;
    BANKSEL MEMORY
    INCF    Current_Display, F
    MOVLW   14
    SUBWF   Current_Display, W
    SKPNC
    CLRF    Current_Display
    GOTO    _Paint_Enable_Prompt
;-------------------------------------------------------;

;-------------------------------------------------------;
_Edit_Yes:
;-------------------------------------------------------;
    BANKSEL MEMORY
    CALL    _Slot_Dwell_Addr
    CALL    _EE_Read_Byte
    BANKSEL EE_Data
    MOVFW   EE_Data
    XORLW   H'FF'
    SKPZ
    BSF     EE_Data, SLOT_ENABLED_BIT
    SKPZ
    CALL    _EE_Write_Byte
    BANKSEL MEMORY
    INCF    Current_Display, F
    MOVLW   14
    SUBWF   Current_Display, W
    SKPNC
    CLRF    Current_Display
    GOTO    _Paint_Enable_Prompt
;-------------------------------------------------------;
    
;-------------------------------------------------------;
_Edit_No:
;-------------------------------------------------------;
    CALL    _Slot_Dwell_Addr
    CALL    _EE_Read_Byte
    BANKSEL EE_Data
    MOVFW   EE_Data
    XORLW   H'FF'
    SKPNZ
    GOTO    _Edit_Next
    BCF     EE_Data, SLOT_ENABLED_BIT
    CALL    _EE_Write_Byte
    GOTO    _Edit_Next
;-------------------------------------------------------;
    
;-------------------------------------------------------;
_Slot_Dwell_Addr:
;-------------------------------------------------------;
    BANKSEL MEMORY
    MOVFW   Current_Display
    MOVWF   EE_Addr
    LSLF    EE_Addr, F
    MOVFW   EE_Addr
    MOVWF   Temp1
    LSLF    EE_Addr, F
    LSLF    EE_Addr, F
    LSLF    EE_Addr, F
    MOVFW   Temp1
    ADDWF   EE_Addr, F
	;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Paint_Enable_Prompt:
;-------------------------------------------------------;
    CALL    _Clear_Buffer
    SET_CURSOR_M 0
    PRINT_CHAR_M A'M'
    PRINT_CHAR_M A'S'
    PRINT_CHAR_M A'G'
    PRINT_CHAR_M A' '
    BANKSEL MEMORY
    MOVFW   Current_Display
    MOVWF   Temp1
    CLRF    Temp2
	;---------------------------------------------------;
_PEP_Tens:
	;---------------------------------------------------;
    MOVLW   10
    SUBWF   Temp1, W
    SKPC
    GOTO    _PEP_TensDone
    MOVWF   Temp1
    INCF    Temp2, F
    GOTO    _PEP_Tens
	;---------------------------------------------------;
_PEP_TensDone:
	;---------------------------------------------------;
    MOVFW   Temp2
    CALL    _Print_Numeric
    MOVFW   Temp1
    CALL    _Print_Numeric
    BANKSEL MEMORY
    CALL    _Slot_Dwell_Addr
    CALL    _EE_Read_Byte
    BANKSEL EE_Data
    MOVFW   EE_Data
    XORLW   H'FF'
    SKPNZ
    GOTO    _PEP_Empty
    BTFSS   EE_Data, SLOT_ENABLED_BIT
    GOTO    _PEP_Off
    PRINT_CHAR_M A' '
    PRINT_CHAR_M A'E'
    PRINT_CHAR_M A'N'
    PRINT_CHAR_M A'A'
    PRINT_CHAR_M A'B'
    PRINT_CHAR_M A'L'
    PRINT_CHAR_M A'E'
    PRINT_CHAR_M A'D'
    GOTO    _Update_Matrix
	;---------------------------------------------------;
_PEP_Off:
	;---------------------------------------------------;
    PRINT_CHAR_M A' '
    PRINT_CHAR_M A'D'
    PRINT_CHAR_M A'I'
    PRINT_CHAR_M A'S'
    PRINT_CHAR_M A'A'
    PRINT_CHAR_M A'B'
    PRINT_CHAR_M A'L'
    PRINT_CHAR_M A'E'
    PRINT_CHAR_M A'D'
    GOTO    _Update_Matrix
	;---------------------------------------------------;
_PEP_Empty:
	;---------------------------------------------------;
    PRINT_CHAR_M A' '
    PRINT_CHAR_M A'E'
    PRINT_CHAR_M A'M'
    PRINT_CHAR_M A'P'
    PRINT_CHAR_M A'T'
    PRINT_CHAR_M A'Y'
    GOTO    _Update_Matrix
;-------------------------------------------------------;

;-------------------------------------------------------;
_Print_No_Enabled:
;-------------------------------------------------------;
    CALL    _Clear_Buffer
    BANKSEL This_Digit
    CLRF    This_Digit
	;---------------------------------------------------;
_PNE_Loop:
	;---------------------------------------------------;
    MOVFW   This_Digit
    MOVWF   Buffer_Digit_Ptr
    MOVFW   This_Digit
    MOVWF   FSR1L
    MOVLW   HIGH _Str_No_Enabled
    IORLW   H'80'
    MOVWF   FSR1H
    MOVLW   LOW  _Str_No_Enabled
    ADDWF   FSR1L, F
    SKPNC
    INCF    FSR1H, F
    MOVFW   INDF1
    CALL    _Print_Char
    INCF    This_Digit, F
    MOVLW   MAX_DIGITS
    XORWF   This_Digit, W
    SKPZ
    GOTO    _PNE_Loop
    GOTO    _Update_Matrix
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
_Init_Messaging_Subsystem:
;-------------------------------------------------------;
    BANKSEL MEMORY
    ;---------------------------------------------------;
    CALL    _Load_Msgs_Enabled_Flag
	;---------------------------------------------------;
    BANKSEL MEMORY
	;---------------------------------------------------;
    MOVLW   H'FF'
    MOVWF   Saved_Display
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
