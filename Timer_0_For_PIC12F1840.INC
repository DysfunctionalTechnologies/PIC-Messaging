;-------------------------------------------------------;
; Name:      Timer_0_For_PIC12F1840.INC
; Use:       Timer 0 For PIC12F1840 Routines Header File
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
#DEFINE _TIMER_0_FOR_PIC12F1840.INC_
;-------------------------------------------------------;

;-------------------------------------------------------;
; Defines
;-------------------------------------------------------;
    ; At a process clock of 32Mhz
    ;---------------------------------------------------;
#DEFINE TIMER_0_0p037ms H'FF' ; 0.037ms  (37us)
#DEFINE TIMER_0_0p520ms H'F0' ; 0.520ms (520us)
#DEFINE TIMER_0_1p040ms H'E0' ; 1.040ms
#DEFINE TIMER_0_1p550ms H'D0' ; 1.550ms
#DEFINE TIMER_0_1p750ms H'C8' ; 1.750ms
#DEFINE TIMER_0_2p060ms H'C0' ; 2.060ms
#DEFINE TIMER_0_2p580ms H'B0' ; 2.580ms
#DEFINE TIMER_0_3p090ms H'A0' ; 3.090ms
#DEFINE TIMER_0_3p600ms H'90' ; 3.600ms
#DEFINE TIMER_0_4p110ms H'80' ; 4.110ms
#DEFINE TIMER_0_4p630ms H'70' ; 4.630ms
#DEFINE TIMER_0_5p010ms H'64' ; 5.010ms ** USED FOR MOST SW
#DEFINE TIMER_0_5p140ms H'60' ; 5.140ms
#DEFINE TIMER_0_5p650ms H'50' ; 5.650ms
#DEFINE TIMER_0_6p170ms H'40' ; 6.170ms
#DEFINE TIMER_0_6p680ms H'30' ; 6.680ms
#DEFINE TIMER_0_7p190ms H'20' ; 7.190ms
#DEFINE TIMER_0_7p700ms H'10' ; 7.700ms
#DEFINE TIMER_0_8p210ms H'00' ; 8.210ms
    ;---------------------------------------------------;
#DEFINE TIMER_0_LOAD_VALUE TIMER_0_5p010ms
;-------------------------------------------------------;

;-------------------------------------------------------;
; Macros
;-------------------------------------------------------;
;-------------------------------------------------------;

;-------------------------------------------------------;
#IFDEF _TIMER_0_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
    ; Global Routines
    ;---------------------------------------------------;
    GLOBAL  _Initialize_Timer_0_Subsystem
    ;---------------------------------------------------;
    GLOBAL  _Timer_0_INT_Handler
    GLOBAL  _Wait_For_Timer_0_INT_Flag
;-------------------------------------------------------;
#ELSE ; !_TIMER_0_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
    ; External Routines
    ;---------------------------------------------------;
    EXTERN  _Initialize_Timer_0_Subsystem
    ;---------------------------------------------------;
    EXTERN  _Timer_0_INT_Handler
    EXTERN  _Wait_For_Timer_0_INT_Flag
;-------------------------------------------------------;
#ENDIF ; !_TIMER_0_FOR_PIC12F1840.ASM_
;-------------------------------------------------------;
