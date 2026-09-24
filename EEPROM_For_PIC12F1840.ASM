;-------------------------------------------------------;
; Name:      EEPROM_For_PIC12F1840.ASM
; Use:       EEPROM For PIC12F1840 Routines
;-------------------------------------------------------;
; Copyright: ©2026 DTP
;            Dysfunctional Technologies, Philippines
;            All Rights Reserved
;-------------------------------------------------------;
; Author:    Timothy S. Carlson
;            Owner, CEO, and CTO
;            Dysfunctional Technologies, Philippines
;-------------------------------------------------------;
; Date:      September 25, 2026
; Version:   V1.00
; Project:   PIC-Messaging_PIC12F1840_EEPROM_MAX7219_I2C_IR_Remote
;-------------------------------------------------------;
#DEFINE  _EEPROM_FOR_PIC12F1840.ASM_
#INCLUDE Common.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
EEPROM_CODE CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
_EE_Read_Byte:
;-------------------------------------------------------;
; W destroyed. EE_Addr in, EE_Data out
;-------------------------------------------------------;
;    BANKSEL EEADRL
;    MOVFW   EE_Addr
;    MOVWF   EEADRL
;    CLRF    EEADRH
;    BANKSEL EECON1
;    BCF     EECON1, CFGS
;    BCF     EECON1, EEPGD
;    BSF     EECON1, RD
;    BANKSEL EEDATL
;    MOVFW   EEDATL
;    MOVWF   EE_Data
;    BANKSEL MEMORY
;    RETURN
    BANKSEL EEADRL
    MOVFW   EE_Addr
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
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_EE_Write_Byte:
;-------------------------------------------------------;
; EE_Addr, EE_Data in. GIE off only for unlock.
;-------------------------------------------------------;
;    BANKSEL EEADRL
;    MOVFW   EE_Addr
;    MOVWF   EEADRL
;    CLRF    EEADRH
;    BANKSEL EEDATL
;    MOVFW   EE_Data
;    MOVWF   EEDATL
;    BANKSEL EECON1
;    BCF     EECON1, CFGS
;    BCF     EECON1, EEPGD
;    BSF     EECON1, WREN
;    TURN_OFF_INTS_M
;    MOVLW   H'55'
;    MOVWF   EECON2
;    MOVLW   H'AA'
;    MOVWF   EECON2
;    BSF     EECON1, WR
;_EE_WR_Wait:
;    BTFSC   EECON1, WR
;    GOTO    _EE_WR_Wait
;    BCF     EECON1, WREN
;    TURN_ON_INTS_M
;    BANKSEL MEMORY
;    RETURN
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
_EE_WR_Wait:
    BTFSC   EECON1, WR
    GOTO    _EE_WR_Wait
    BCF     EECON1, WREN
    BSF     INTCON, GIE
    BANKSEL MEMORY
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_EE_Diag_Write:
;-------------------------------------------------------;
    CLRF    EE_Addr
    MOVLW   EE_TEST_PATTERN
    MOVWF   EE_Data
;    GOTO    _EE_Write_Byte
    CALL    _EE_Write_Byte
    GOTO    _EE_Paint_W
;-------------------------------------------------------;

;-------------------------------------------------------;
_EE_Diag_Read:
;-------------------------------------------------------;
    CLRF    EE_Addr
;    GOTO    _EE_Read_Byte
    CALL    _EE_Read_Byte
    GOTO    _EE_Paint_R
;-------------------------------------------------------;

;-------------------------------------------------------;
_EE_Paint_W:
;-------------------------------------------------------;
    BSF     EE_GLASS_FLAG
    CALL    _Clear_Buffer
    SET_CURSOR_M 0
    PRINT_CHAR_M A'E'
    SET_CURSOR_M 1
    PRINT_CHAR_M A'E'
    SET_CURSOR_M 2
    PRINT_CHAR_M A' '
    SET_CURSOR_M 3
    PRINT_CHAR_M A'W'
    SET_CURSOR_M 4
    PRINT_CHAR_M A' '
    SET_CURSOR_M 5
    MOVFW   EE_Data
    CALL    _EE_Print_Hex
    GOTO    _Update_Matrix
;-------------------------------------------------------;

;-------------------------------------------------------;
_EE_Paint_R:
;-------------------------------------------------------;
    BSF     EE_GLASS_FLAG
    CALL    _Clear_Buffer
    SET_CURSOR_M 0
    PRINT_CHAR_M A'E'
    SET_CURSOR_M 1
    PRINT_CHAR_M A'E'
    SET_CURSOR_M 2
    PRINT_CHAR_M A' '
    SET_CURSOR_M 3
    PRINT_CHAR_M A'R'
    SET_CURSOR_M 4
    PRINT_CHAR_M A' '
    SET_CURSOR_M 5
    MOVFW   EE_Data
    CALL    _EE_Print_Hex
    GOTO    _Update_Matrix
;-------------------------------------------------------;

;-------------------------------------------------------;
_EE_Print_Hex:
;-------------------------------------------------------;
; W = byte
;-------------------------------------------------------;
    BANKSEL MEMORY
    SET_CURSOR_M 5
    MOVFW   EE_Data
    SWAPF   EE_Data, W
    ANDLW   H'0F'
    CALL    _EE_Print_Nibble

    BANKSEL MEMORY
    SET_CURSOR_M 6
    MOVFW   EE_Data
    ANDLW   H'0F'
    GOTO    _EE_Print_Nibble
;    SET_CURSOR_M 5
;    MOVWF   Temp1
;    SWAPF   Temp1, W
;    CALL    _EE_Print_Nibble
;    SET_CURSOR_M 6
;    MOVFW   Temp1
;;    GOTO    _EE_Print_Nibble
;-------------------------------------------------------;

;-------------------------------------------------------;
_EE_Print_Nibble:
;-------------------------------------------------------;
    ANDLW   H'0F'
    MOVWF   Temp2
    MOVLW   A'0'
    ADDWF   Temp2, F         ; 0-9 > '0'-'9', 10-15 > ':'-'?'
    MOVLW   A'9'
    SUBWF   Temp2, W         ; W = char-'9'
    MOVLW   A':'
    SUBWF   Temp2, W         ; C=1 if char >= ':'
    SKPC
    GOTO    _EE_PN_Out       ; '0'-'9'
    MOVLW   7
    ADDWF   Temp2, F         ; ':'>'A' . . . '?'>'F'
_EE_PN_Out:
    MOVFW   Temp2
    GOTO    _Print_Char
;-------------------------------------------------------;
    
;-------------------------------------------------------;
_Initialize_EEPROM_Subsystem:
;-------------------------------------------------------;
    ; Initialize I/O Port (Interrupt)
    ;---------------------------------------------------;
    ;---------------------------------------------------;
    ; Initialize External Interrupt
    ;---------------------------------------------------;
    ;---------------------------------------------------;
    ; Enable Interrupts
    ;---------------------------------------------------;
    ;---------------------------------------------------;
    ; Initialize Variables
    ;---------------------------------------------------;
    BANKSEL MEMORY
    CLRF    EE_Addr
    CLRF    EE_Data
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
    END
;-------------------------------------------------------;
#DEFINE  _EEPROM.ASM_
#INCLUDE Common.INC

EEPROM_CODE CODE


    END
