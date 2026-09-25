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
EEPROM_CODE CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
_EE_Read_Byte:
;-------------------------------------------------------;
; W destroyed. EE_Addr in, EE_Data out
;-------------------------------------------------------;
    BANKSEL MEMORY
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
    MOVLW   EE_TEST_ADDR     ; H'FF'
    MOVWF   EE_Addr
    MOVLW   EE_TEST_PATTERN
    MOVWF   EE_Data
    CALL    _EE_Write_Byte
    GOTO    _EE_Paint_W
;-------------------------------------------------------;

;-------------------------------------------------------;
_EE_Diag_Read:
;-------------------------------------------------------;
    MOVLW   EE_TEST_ADDR     ; H'FF'
    MOVWF   EE_Addr
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
_EE_Print_Slot:
;-------------------------------------------------------;
; Current_Display = slot 0..13
; Slot = [dwell][17 chars]. Dwell 0xFF = empty / end.
;-------------------------------------------------------;
	BANKSEL MEMORY
	CLRF	Buffer_Digit_Ptr
    MOVLW	A'X'
    CALL	_Print_Char
    RETURN
;    BANKSEL MEMORY
    MOVFW   Current_Display
    MOVWF   EE_Addr           ; *1
    LSLF    EE_Addr, F        ; *2
    MOVFW   EE_Addr
    MOVWF   Temp1             ; save *2
    LSLF    EE_Addr, F        ; *4
    LSLF    EE_Addr, F        ; *8
    LSLF    EE_Addr, F        ; *16
    MOVFW   Temp1
    ADDWF   EE_Addr, F        ; *18
    ;---------------------------------------------------;
    CALL    _EE_Read_Byte     ; dwell
    BANKSEL MEMORY
    MOVFW   EE_Data
    XORLW   H'FF'
    SKPNZ
    GOTO    _EEPS_Empty
    ;---------------------------------------------------;
    INCF    EE_Addr, F        ; first text byte
    CLRF    Temp1             ; column 0..16
    ;---------------------------------------------------;
_EEPS_Next:
    BANKSEL MEMORY
    MOVFW   Temp1
    MOVWF   Buffer_Digit_Ptr
    CALL    _EE_Read_Byte
    BANKSEL MEMORY
    MOVFW   EE_Data
    CALL    _EE_Sanitize
    CALL    _Print_Char
    BANKSEL MEMORY
    INCF    EE_Addr, F
    INCF    Temp1, F
    MOVLW   17
    XORWF   Temp1, W
    SKPZ
    GOTO    _EEPS_Next
    RETURN
;-------------------------------------------------------;
_EEPS_Empty:
    MOVFW   Current_Display
    SKPNZ
    RETURN                    ; slot 0 empty: nothing to show
    CLRF    Current_Display
    GOTO    _EE_Print_Slot
;-------------------------------------------------------;

;-------------------------------------------------------;
_EE_Sanitize:
; W in/out. Bad glyph -> space.
;-------------------------------------------------------;
    MOVWF   Temp2
    MOVLW   A' '
    SUBWF   Temp2, W
    SKPC
    GOTO    _EE_San_Space
    MOVLW   A'Z'
    SUBWF   Temp2, W
    SKPNC
    GOTO    _EE_San_OK
_EE_San_Space:
    MOVLW   A' '
    RETURN
_EE_San_OK:
    MOVFW   Temp2
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Initialize_EEPROM_Subsystem:
;-------------------------------------------------------;
    ; Initialize Variables
    ;---------------------------------------------------;
    BANKSEL MEMORY
    CLRF    EE_Addr
    CLRF    EE_Data
    BCF		EE_GLASS_FLAG
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
 org __EEPROM_START
;-------------------------------------------------------;
; First word = dwell (* 100ms). If 0xFF, end of strings
; Following words 1-17 - the actual string
;-------------------------------------------------------;
MSGString1:
    DE  30 ; * 100ms = 3 seconds
    DE  "  EE  MSG V",(VERSION_MAJOR & H'0F') + '0', ".", ((VERSION_MINOR & H'F0') >> 4) + '0', (VERSION_MINOR & H'0F') + '0', "  " ; 0
MSGString2:
    DE  30 ; * 100ms = 3 seconds
    DE	"   WELCOME TO    " ; 1
MSGString3:
    DE  30 ; * 100ms = 3 seconds
    DE  "  DYSFUNCTIONAL  " ; 2
MSGString4:
    DE  30 ; * 100ms = 3 seconds
    DE	"  TECHNOLOGIES   " ; 3
MSGString5:
    DE  30 ; * 100ms = 3 seconds
    DE	"   PHILIPPINES   " ; 4
MSGString6:
    DE  30 ; * 100ms = 3 seconds
    DE  "GOD BLESS AMERICA" ; 5
    DE  0xFF ; end if string list
;-------------------------------------------------------;
    
;-------------------------------------------------------;
    END
;-------------------------------------------------------;
