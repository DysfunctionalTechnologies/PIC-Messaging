;-------------------------------------------------------;
; Name:      Idle.ASM
; Use:       Idle Messaging Routines
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
#DEFINE  _IDLE.ASM_
#INCLUDE Common.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
IDLE_DATA UDATA
;-------------------------------------------------------;
Idle_Dwell      RES     1
Idle_Mix        RES     1
Idle_Glyph      RES     1
Idle_Prev       RES     1
Idle_First      RES     1
Idle_Petal      RES     1
;-------------------------------------------------------;

;-------------------------------------------------------;
IDLE_CODE CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
_Load_Idle_Dwell:
;-------------------------------------------------------;
; 1.0 s .. 4.0 s, step 0.5 s. Never the same dwell twice.
; Seed is Timer 1. Do not write TMR1.
;-------------------------------------------------------;
    CALL    _Get_Timer_1
    ANDLW   H'07'
    MOVWF   Temp1
    MOVLW   7
    SUBWF   Temp1, W
    SKPC
    GOTO    _LID_Scale
    CLRF    Temp1
;-------------------------------------------------------;
_LID_Scale:
;-------------------------------------------------------;
    MOVFW   Temp1
    LSLF    Temp1, F
    LSLF    Temp1, F
    ADDWF   Temp1, F
    MOVLW   10
    ADDWF   Temp1, F
    MOVFW   Temp1
    BANKSEL Idle_Dwell
    XORWF   Idle_Dwell, W
    SKPNZ
    GOTO    _LID_Step
    XORWF   Idle_Dwell, W
    GOTO    _LID_Store
;-------------------------------------------------------;
_LID_Step:
;-------------------------------------------------------;
    MOVFW   Idle_Dwell
    ADDLW   5
    MOVWF   Temp1
    MOVLW   41
    SUBWF   Temp1, W
    SKPC
    GOTO    _LID_Keep
    MOVLW   10
    MOVWF   Temp1
;-------------------------------------------------------;
_LID_Keep:
;-------------------------------------------------------;
    MOVFW   Temp1
;-------------------------------------------------------;
_LID_Store:
;-------------------------------------------------------;
    MOVWF   Idle_Dwell
    BANKSEL Slot_Dwell
    MOVWF   Slot_Dwell
    CALL    _Load_Dwell_Timer
    ;---------------------------------------------------;
    BANKSEL MEMORY
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Paint_Idle_Tiles:
;-------------------------------------------------------;
    CALL    _Clear_Buffer
    CALL    _Get_Timer_1
    BANKSEL Idle_Mix
    XORWF   Idle_Mix, F
    INCF    Idle_Mix, F
    SKPNZ
    INCF    Idle_Mix, F
    BANKSEL TIMER_1_VALUE_H
    MOVFW   TIMER_1_VALUE_H
    BANKSEL Idle_Mix
    XORWF   Idle_Mix, F
    SKPNZ
    INCF    Idle_Mix, F
    CLRF    Idle_Petal
;-------------------------------------------------------;
_PIT_Loop:
;-------------------------------------------------------;
    BANKSEL Idle_Petal
    MOVFW   Idle_Petal
    BANKSEL Buffer_Digit_Ptr
    MOVWF   Buffer_Digit_Ptr
    BANKSEL Idle_Mix
    MOVLW   H'1D'
    ADDWF   Idle_Mix, F
    SKPNZ
    INCF    Idle_Mix, F
    SWAPF   Idle_Mix, W
    XORWF   Idle_Mix, W
    ANDLW   H'07'
    ADDLW   H'F0'
    MOVWF   Idle_Glyph
    CLRF    Temp2
;-------------------------------------------------------;
_PIT_Check:
;-------------------------------------------------------;
    BANKSEL Idle_Glyph
    MOVLW   H'F0'
    SUBWF   Idle_Glyph, W
    SKPC
    GOTO    _PIT_Force
    MOVLW   H'F8'
    SUBWF   Idle_Glyph, W
    SKPNC
    GOTO    _PIT_Force
    GOTO    _PIT_InRange
;-------------------------------------------------------;
_PIT_Force:
;-------------------------------------------------------;
    BANKSEL Idle_Glyph
    MOVLW   H'F0'
    MOVWF   Idle_Glyph
;-------------------------------------------------------;
_PIT_InRange:
;-------------------------------------------------------;
    BANKSEL Idle_Petal
    MOVFW   Idle_Petal
    SKPNZ
    GOTO    _PIT_Take
    MOVFW   Idle_Glyph
    XORWF   Idle_Prev, W
    SKPNZ
    GOTO    _PIT_Bump
    MOVFW   Idle_Petal
    XORLW   16
    SKPZ
    GOTO    _PIT_Take
    MOVFW   Idle_Glyph
    XORWF   Idle_First, W
    SKPNZ
    GOTO    _PIT_Take
;-------------------------------------------------------;
_PIT_Bump:
;-------------------------------------------------------;
    BANKSEL Temp2
    INCF    Temp2, F
    MOVLW   3
    SUBWF   Temp2, W
    SKPNC
    GOTO    _PIT_Take
    BANKSEL Idle_Glyph
    INCF    Idle_Glyph, F
    MOVLW   H'F8'
    XORWF   Idle_Glyph, W
    SKPNZ
    GOTO    _PIT_Wrap
    GOTO    _PIT_Check
;-------------------------------------------------------;
_PIT_Wrap:
;-------------------------------------------------------;
    BANKSEL Idle_Glyph
    MOVLW   H'F0'
    MOVWF   Idle_Glyph
    GOTO    _PIT_Check
;-------------------------------------------------------;
_PIT_Take:
;-------------------------------------------------------;
    BANKSEL Idle_Glyph
    MOVLW   H'07'
    ANDWF   Idle_Glyph, F
    MOVLW   H'F0'
    IORWF   Idle_Glyph, F
    BANKSEL Idle_Petal
    MOVFW   Idle_Petal
    SKPNZ
    GOTO    _PIT_Save0
    GOTO    _PIT_Print
;-------------------------------------------------------;
_PIT_Save0:
;-------------------------------------------------------;
    BANKSEL Idle_Glyph
    MOVFW   Idle_Glyph
    MOVWF   Idle_First
;-------------------------------------------------------;
_PIT_Print:
;-------------------------------------------------------;
    BANKSEL Idle_Glyph
    MOVFW   Idle_Glyph
    MOVWF   Idle_Prev
    CALL    _Print_Char
    BANKSEL Idle_Petal
    INCF    Idle_Petal, F
    MOVLW   17
    XORWF   Idle_Petal, W
    SKPZ
    GOTO    _PIT_Loop
    GOTO    _Update_Matrix
;-------------------------------------------------------;

;-------------------------------------------------------;
_Init_Idle_Subsystem:
;-------------------------------------------------------;
    BANKSEL Idle_Mix
    MOVLW   1
    MOVWF   Idle_Mix
    CLRF    Idle_Dwell
    CLRF    Idle_First
    CLRF    Idle_Prev
	;---------------------------------------------------;
    BANKSEL MEMORY
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
    END
;-------------------------------------------------------;
