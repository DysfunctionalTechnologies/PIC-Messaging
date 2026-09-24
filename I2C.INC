;-------------------------------------------------------;
; Name:      I2C.INC
; Use:       I2C Routines Header File
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
#DEFINE _I2C.INC_
;-------------------------------------------------------;

;-------------------------------------------------------;
; Defines
;-------------------------------------------------------;
; Hardware Bit defines in PIC16F1826.INC
;-------------------------------------------------------;
#DEFINE I2C_READ     H'40'                 ;
#DEFINE I2C_READ_BIT 6                     ; I2C R/W flag
#DEFINE I2C_NACK     H'80'                 ;
#DEFINE I2C_NACK_BIT 7                     ; I2C 'no acknowledge' (NACK) flag
;-------------------------------------------------------;

;-------------------------------------------------------;
; Macros
;-------------------------------------------------------;
;-------------------------------------------------------;

;-------------------------------------------------------;
#IFDEF _I2C.ASM_
;-------------------------------------------------------;
    ; Global Routines
    ;---------------------------------------------------;
    GLOBAL  _Initialize_I2C_Subsystem
    ;---------------------------------------------------;
    GLOBAL  _I2C_Set_Device_Address
    GLOBAL  _I2C_Set_Transfer_Size
    ;---------------------------------------------------;
    GLOBAL  _I2C_Start_Write
    GLOBAL  _I2C_Write_Bits
    GLOBAL  _I2C_Write_Byte
    GLOBAL  _I2C_Write_Bytes
    ;---------------------------------------------------;
    GLOBAL  _I2C_Start_Read
    GLOBAL  _I2C_Read_Bits
    GLOBAL  _I2C_Read_Bytes
    ;---------------------------------------------------;
    GLOBAL  _I2C_Start
    GLOBAL  _I2C_Stop
;-------------------------------------------------------;
#ELSE ; !_I2C.ASM_
;-------------------------------------------------------;
    ; External Routines
    ;---------------------------------------------------;
    EXTERN  _Initialize_I2C_Subsystem
    ;---------------------------------------------------;
    EXTERN  _I2C_Set_Device_Address
    EXTERN  _I2C_Set_Transfer_Size
    ;---------------------------------------------------;
    EXTERN  _I2C_Start_Write
    EXTERN  _I2C_Write_Bits
    EXTERN  _I2C_Write_Byte
    EXTERN  _I2C_Write_Bytes
    ;---------------------------------------------------;
    EXTERN  _I2C_Start_Read
    EXTERN  _I2C_Read_Bits
    EXTERN  _I2C_Read_Bytes
    ;---------------------------------------------------;
    EXTERN  _I2C_Start
    EXTERN  _I2C_Stop
;-------------------------------------------------------;
#ENDIF ; !_I2C.ASM_
;-------------------------------------------------------;
    
