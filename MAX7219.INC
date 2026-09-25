;-------------------------------------------------------;
; Name:      MAX7219.INC
; Use:       MAX7219 Routines Header File
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
#DEFINE _MAX7219.INC_
;-------------------------------------------------------;

;-------------------------------------------------------;
; Defines
;-------------------------------------------------------;
    ; MAX7219 Commands
    ;---------------------------------------------------;
#DEFINE MAX7219_NOP         H'00'
    ;---------------------------------------------------;
#DEFINE MAX7219_DIGIT_0     H'01'
#DEFINE MAX7219_DIGIT_1     H'02'
#DEFINE MAX7219_DIGIT_2     H'03'
#DEFINE MAX7219_DIGIT_3     H'04'
#DEFINE MAX7219_DIGIT_4     H'05'
#DEFINE MAX7219_DIGIT_6     H'07'
#DEFINE MAX7219_DIGIT_7     H'08'
    ;---------------------------------------------------;
#DEFINE MAX7219_DECODE      H'09'
#DEFINE DECODE_OFF          H'00'
#DEFINE DECODE_ON           H'FF'
    ;---------------------------------------------------;
#DEFINE MAX7219_INTENSITY   H'0A'
#DEFINE INTENSITY_MIN       INTENSITY_0
#DEFINE INTENSITY_0         H'00'
#DEFINE INTENSITY_1         H'01'
#DEFINE INTENSITY_2         H'02'
#DEFINE INTENSITY_3         H'03'
#DEFINE INTENSITY_4         H'04'
#DEFINE INTENSITY_5         H'05'
#DEFINE INTENSITY_6         H'06'
#DEFINE INTENSITY_7         H'07'
#DEFINE INTENSITY_MID       H'08'
#DEFINE INTENSITY_8         H'08'
#DEFINE INTENSITY_9         H'09'
#DEFINE INTENSITY_A         H'0A'
#DEFINE INTENSITY_B         H'0B'
#DEFINE INTENSITY_C         H'0C'
#DEFINE INTENSITY_D         H'0D'
#DEFINE INTENSITY_E         H'0E'
#DEFINE INTENSITY_F         H'0F'
#DEFINE INTENSITY_MAX       INTENSITY_F
    ;---------------------------------------------------;
#DEFINE MAX7219_SCANLIMIT   H'0B'
#DEFINE SCANLIMIT_MIN       H'00'
#DEFINE SCANLIMIT_MAX       H'07'
    ;---------------------------------------------------;
#DEFINE MAX7219_SHUTDOWN    H'0C'
#DEFINE SHUTDOWN_ON         H'00'
#DEFINE SHUTDOWN_OFF        H'01'
    ;---------------------------------------------------;
#DEFINE MAX7219_DISPLAYTEST H'0F'
#DEFINE DISPLAYTEST_OFF     H'00'
#DEFINE DISPLAYTEST_ON      H'01'
    ;---------------------------------------------------;
    ; System Parameters
    ;---------------------------------------------------;
#DEFINE MAX_DIGITS          17
#DEFINE MAX_LINES           8
#DEFINE MAX_DATA            MAX_DIGITS * MAX_LINES
    ;---------------------------------------------------;
    ; Buffer Parameters
    ;---------------------------------------------------;
#DEFINE MATRIX_BUFFER_ADDR  LINEAR_BUFFER_ADDRESS
#DEFINE MATRIX_BUFFER_LEN   MAX_DATA
;-------------------------------------------------------;

;-------------------------------------------------------;
; Macros
;-------------------------------------------------------;
;-------------------------------------------------------;
    
;-------------------------------------------------------;
#IFDEF _MAX7219.ASM_
;-------------------------------------------------------;
    ; Global Routines
    ;---------------------------------------------------;
    GLOBAL  _Initialize_MAX7219_Subsystem
    ;---------------------------------------------------;
    ; Buffer Routines
    ;---------------------------------------------------;
    GLOBAL  _Clear_Buffer
    GLOBAL  _Write_Buffer
    GLOBAL  _Read_Buffer
    GLOBAL  _Clear_Char
    GLOBAL  _Print_Numeric
    GLOBAL  _Print_Char
    GLOBAL  _Overlay_Char
    GLOBAL  _Remove_Char
    GLOBAL  _Prev_Buffer_Line_Ptr
    GLOBAL  _Next_Buffer_Line_Ptr
    GLOBAL  _Prev_Buffer_Digit_Ptr
    GLOBAL  _Next_Buffer_Digit_Ptr
    ;---------------------------------------------------;
    ; Matrix Routines
    ;---------------------------------------------------;
    GLOBAL  _Init_Matrix
    GLOBAL  _Clear_Matrix
    GLOBAL  _Update_Matrix
    GLOBAL  _Set_Intensity_MIN
    GLOBAL  _Set_Intensity_MAX
    GLOBAL  _Set_Intensity_New
    GLOBAL  _Set_Intensity
    GLOBAL  _Inc_Intensity
    GLOBAL  _Dec_Intensity
    GLOBAL  _Get_Intensity
;-------------------------------------------------------;
#ELSE ; !_MAX7219.ASM_
;-------------------------------------------------------;
    ; External Routines
    ;---------------------------------------------------;
    EXTERN  _Initialize_MAX7219_Subsystem
    ;---------------------------------------------------;
    ; Buffer Routines
    ;---------------------------------------------------;
    EXTERN  _Clear_Buffer
    EXTERN  _Write_Buffer
    EXTERN  _Read_Buffer
    EXTERN  _Clear_Char
    EXTERN  _Print_Numeric
    EXTERN  _Print_Char
    EXTERN  _Overlay_Char
    EXTERN  _Remove_Char
    EXTERN  _Prev_Buffer_Line_Ptr
    EXTERN  _Next_Buffer_Line_Ptr
    EXTERN  _Prev_Buffer_Digit_Ptr
    EXTERN  _Next_Buffer_Digit_Ptr
    ;---------------------------------------------------;
    ; Matrix Routines
    ;---------------------------------------------------;
    EXTERN  _Init_Matrix
    EXTERN  _Clear_Matrix
    EXTERN  _Update_Matrix
    EXTERN  _Set_Intensity_MIN
    EXTERN  _Set_Intensity_MAX
    EXTERN  _Set_Intensity_New
    EXTERN  _Set_Intensity
    EXTERN  _Inc_Intensity
    EXTERN  _Dec_Intensity
    EXTERN  _Get_Intensity
;-------------------------------------------------------;
#ENDIF ; !_MAX7219.ASM_
;-------------------------------------------------------;
