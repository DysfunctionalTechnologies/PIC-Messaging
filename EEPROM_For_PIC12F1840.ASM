;-------------------------------------------------------;
; Name:      EEPROM_For_PIC12F1840.ASM
; Use:       EEPROM For PIC12F1840 Routines
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
#DEFINE  _EEPROM_FOR_PIC12F1840.ASM_
#INCLUDE Common.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
EEPROM_DATA UDATA
;-------------------------------------------------------;
EE_Addr     res 1
EE_Data     res 1
;-------------------------------------------------------;

;-------------------------------------------------------;
EEPROM_CODE CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
_EE_Read_Byte:
;-------------------------------------------------------;
; W destroyed. EE_Addr in, EE_Data out
;-------------------------------------------------------;
    BANKSEL MEMORY
    MOVFW   EE_Addr
    BANKSEL EEADRL
    MOVWF   EEADRL
    CLRF    EEADRH
    BANKSEL EEDATL
    CLRF    EEDATL            ; kill leftover latch
    BANKSEL EECON1
    BCF     EECON1, CFGS
    BCF     EECON1, EEPGD
    BSF     EECON1, RD
    BANKSEL EEDATL
    MOVFW   EEDATL
    BANKSEL MEMORY
    MOVWF   EE_Data
	;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_EE_Write_Byte:
;-------------------------------------------------------;
; EE_Addr, EE_Data in. GIE off only for unlock.
;-------------------------------------------------------;
    BANKSEL MEMORY
    MOVFW   EE_Addr
    BANKSEL EEADRL
    MOVWF   EEADRL
    CLRF    EEADRH
    BANKSEL MEMORY
    MOVFW   EE_Data
    BANKSEL EEDATL
    MOVWF   EEDATL
    BANKSEL EECON1
    BCF     EECON1, CFGS
    BCF     EECON1, EEPGD
    BSF     EECON1, WREN
    BCF     INTCON, GIE
    MOVLW   H'55'
    MOVWF   EECON2
    MOVLW   H'AA'
    MOVWF   EECON2
    BSF     EECON1, WR
	;---------------------------------------------------;
_EE_WR_Wait:
	;---------------------------------------------------;
    BTFSC   EECON1, WR
    GOTO    _EE_WR_Wait
    BCF     EECON1, WREN
    BSF     INTCON, GIE
    BANKSEL MEMORY
	;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Init_EEPROM_Subsystem:
;-------------------------------------------------------;
    ; Initialize Variables
    ;---------------------------------------------------;
    BANKSEL MEMORY
    CLRF    EE_Addr
    CLRF    EE_Data
	;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
    END
;-------------------------------------------------------;
