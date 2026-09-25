;-------------------------------------------------------;
; Name:      MAX7219.ASM
; Use:       MAX7219 Routines
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
#DEFINE  _MAX7219.ASM_
#INCLUDE Common.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
; Linear Buffers 
;-------------------------------------------------------;
MAX7219_BUFFER2 UDATA BUFFER_2_ADDRESS
;-------------------------------------------------------;
                res   BUFFER_2_SIZE
;-------------------------------------------------------;
MAX7219_BUFFER3 UDATA BUFFER_3_ADDRESS
;-------------------------------------------------------;
                res   BUFFER_3_SIZE
;-------------------------------------------------------;

;-------------------------------------------------------;
MAX7219_CODE CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
; BUFFER ROUTINES (MEMORY ARRAY)
;-------------------------------------------------------;

;-------------------------------------------------------;
_Set_Buffer_Ptr:
;-------------------------------------------------------;
    MOVLW   HIGH MATRIX_BUFFER_ADDR
    MOVWF   FSR1H
    MOVLW   LOW	 MATRIX_BUFFER_ADDR
    MOVWF   FSR1L
    ;---------------------------------------------------;
    MOVFW   Buffer_Line_Ptr    ; Digit 0
    ADDWF   Buffer_Line_Ptr, W ; Digit 1
    ADDWF   Buffer_Line_Ptr, W ; Digit 2
    ADDWF   Buffer_Line_Ptr, W ; Digit 3
    ADDWF   Buffer_Line_Ptr, W ; Digit 4
    ADDWF   Buffer_Line_Ptr, W ; Digit 5
    ADDWF   Buffer_Line_Ptr, W ; Digit 6
    ADDWF   Buffer_Line_Ptr, W ; Digit 7
    ADDWF   Buffer_Line_Ptr, W ; Digit 8
    ADDWF   Buffer_Line_Ptr, W ; Digit 9
    ADDWF   Buffer_Line_Ptr, W ; Digit 10
    ADDWF   Buffer_Line_Ptr, W ; Digit 11
    ADDWF   Buffer_Line_Ptr, W ; Digit 12
    ADDWF   Buffer_Line_Ptr, W ; Digit 13
    ADDWF   Buffer_Line_Ptr, W ; Digit 14
    ADDWF   Buffer_Line_Ptr, W ; Digit 15
    ADDWF   Buffer_Line_Ptr, W ; Digit 16
    ADDWF   Buffer_Digit_Ptr, W
    ;---------------------------------------------------;
    ADDWF   FSR1L, F
    SKPNC
    INCF    FSR1H, F
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Write_Buffer:
;-------------------------------------------------------;
    MOVWF   Temp_Data
    CALL    _Set_Buffer_Ptr
    MOVFW   Temp_Data
    MOVWF   INDF1
    RETURN
;------------------------------------------------------;

;-------------------------------------------------------;
_Read_Buffer:
;-------------------------------------------------------;
    CALL    _Set_Buffer_Ptr
    MOVFW   INDF1
    RETURN
;------------------------------------------------------;

;-------------------------------------------------------;
_Clear_Buffer:
;-------------------------------------------------------;
    CLRF    Buffer_Line_Ptr
    ;---------------------------------------------------;
_CB_Next_Line:
    ;---------------------------------------------------;
    CLRF    Buffer_Digit_Ptr
    ;---------------------------------------------------;
_CB_Next_Digit:
    ;---------------------------------------------------;
    CALL    _Set_Buffer_Ptr
    MOVLW   0
    CALL    _Write_Buffer
    CALL    _Next_Buffer_Digit_Ptr
    SKPZ
    GOTO    _CB_Next_Digit
    CALL    _Next_Buffer_Line_Ptr
    SKPZ
    GOTO    _CB_Next_Line
    ; clean up pointers so pointing at beginning of
    ; buffer, not out in the weeds.
    CLRF	Buffer_Line_Ptr
    CLRF	Buffer_Digit_Ptr
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Clear_Char:
;-------------------------------------------------------;
; Buffer_Digit - should be set to digit in buff
;-------------------------------------------------------;
    CLRF    Buffer_Line_Ptr
    ;---------------------------------------------------;
_CC_Next_Buffer_Line:
    ;---------------------------------------------------;
    MOVLW   0
    CALL    _Write_Buffer
    CALL    _Next_Buffer_Line_Ptr
    SKPZ
    GOTO    _CC_Next_Buffer_Line
    GOTO    _Update_Matrix
;-------------------------------------------------------;

;-------------------------------------------------------;
_Print_Numeric:
;-------------------------------------------------------;
; W = numeric (0-9) to print
;-------------------------------------------------------;
    ANDLW   H'0F'
    IORLW   '0'
;-------------------------------------------------------;
_Print_Char:
;-------------------------------------------------------;
; W = character (0-9, A-Z) to print
;-------------------------------------------------------;
    MOVWF   Char2Print
    CALL    _Reset_Font
    MOVFW   Char2Print
    CALL    _Find_Char_In_Font
    CLRF    Buffer_Line_Ptr
    ;---------------------------------------------------;
_PC_Next_Buffer_Line:
    ;---------------------------------------------------;
    CALL    _Read_Buffer
    ANDLW   H'83'
    MOVWF   Char2Print
    MOVFW   Buffer_Line_Ptr
    CALL    _Set_Font_Line_Ptr
    CALL    _Get_Data_From_Font
    ANDLW   H'7C'
    IORWF   Char2Print, W
    CALL    _Write_Buffer
    CALL    _Next_Buffer_Line_Ptr
    SKPZ
    GOTO    _PC_Next_Buffer_Line
    GOTO    _Update_Matrix
;-------------------------------------------------------;

;-------------------------------------------------------;
_Overlay_Char:
;-------------------------------------------------------;
; W = character to overlay
;-------------------------------------------------------;
    MOVWF   Char2Print
    CALL    _Reset_Font
    MOVFW   Char2Print
    CALL    _Find_Char_In_Font
    CLRF    Buffer_Line_Ptr
    ;---------------------------------------------------;
_OC_Next_Line:
    ;---------------------------------------------------;
    CALL    _Read_Buffer
    MOVWF   Char2Print
    MOVFW   Buffer_Line_Ptr
    CALL    _Set_Font_Line_Ptr
    CALL    _Get_Data_From_Font
    IORWF   Char2Print, W
    CALL    _Write_Buffer
    CALL    _Next_Buffer_Line_Ptr
    SKPZ
    GOTO    _OC_Next_Line
    GOTO    _Update_Matrix
;-------------------------------------------------------;

;-------------------------------------------------------;
_Remove_Char:
;-------------------------------------------------------;
; W = character to remove (erase)
;-------------------------------------------------------;
    MOVWF   Char2Print
    CALL    _Reset_Font
    MOVFW   Char2Print
    CALL    _Find_Char_In_Font
    CLRF    Buffer_Line_Ptr
    ;---------------------------------------------------;
_RC_Next_Line:
    ;---------------------------------------------------;
    CALL    _Read_Buffer
    MOVWF   Char2Print
    MOVFW   Buffer_Line_Ptr
    CALL    _Set_Font_Line_Ptr
    CALL    _Get_Data_From_Font
    XORLW   H'FF'
    ANDWF   Char2Print, W
    CALL    _Write_Buffer
    CALL    _Next_Buffer_Line_Ptr
    SKPZ
    GOTO    _RC_Next_Line
    GOTO    _Update_Matrix
;-------------------------------------------------------;

;-------------------------------------------------------;
; MATRIX ROUTINES (LED 8x8 MATRIX HARDWARE)
;-------------------------------------------------------;

;-------------------------------------------------------;
_Init_Matrix:
;-------------------------------------------------------;
    CALL    _Display_Test_OFF
    CALL    _Shutdown_OFF
    CALL    _Decode_OFF
    CALL    _Set_Scan_Limit_MAX
    CALL    _Set_Intensity
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Clear_Matrix:
;-------------------------------------------------------;
    CLRF    Matrix_Line_Ptr
    ;---------------------------------------------------;
_CM_Next:
    ;---------------------------------------------------;
    MOVFW   Matrix_Line_Ptr
    ADDLW   1
    MOVWF   Command_HI
    CLRF    Command_LO
    CALL    _Do_Command
    CALL    _Next_Matrix_Line_Ptr
    SKPZ
    GOTO    _CM_Next
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Update_Matrix:
;-------------------------------------------------------;
    MOVFW   Buffer_Digit_Ptr
    MOVWF   Temp1
    MOVFW   Buffer_Line_Ptr
    MOVWF   Temp2
    ;---------------------------------------------------;
    CALL    _Init_Matrix
    CLRF    Matrix_Line_Ptr
    ;---------------------------------------------------;
#IF !_LEFT_TO_RIGHT_    
    ;---------------------------------------------------;
    CLRF    Buffer_Line_Ptr
    ;---------------------------------------------------;
#ELSE ; _LEFT_TO_RIGHT_
    ;---------------------------------------------------;
    MOVLW   MAX_LINES - 1
    MOVWF   Buffer_Line_Ptr
    ;---------------------------------------------------;
#ENDIF ; _LEFT_TO_RIGHT_
    ;---------------------------------------------------;
_UM_Next_Line:
    ;---------------------------------------------------;
    CALL    _Set_CS
    CLRF    Matrix_Digit_Ptr
    ;---------------------------------------------------;
#IF !_LEFT_TO_RIGHT_    
    ;---------------------------------------------------;
    CLRF    Buffer_Digit_Ptr
    ;---------------------------------------------------;
#ELSE ; _LEFT_TO_RIGHT_
    ;---------------------------------------------------;
    MOVLW   MAX_DIGITS - 1
    MOVWF   Buffer_Digit_Ptr
    ;---------------------------------------------------;
#ENDIF ; _LEFT_TO_RIGHT_
    ;---------------------------------------------------;
_UM_Next_Digit:
    ;---------------------------------------------------;
    CALL    _Read_Buffer
    ;---------------------------------------------------;
#IF _LEFT_TO_RIGHT_
    ;---------------------------------------------------;
    CALL    _Reverse_W
    ;---------------------------------------------------;
#ENDIF ; _LEFT_TO_RIGHT_
    ;---------------------------------------------------;
    BTFSS   POWER_FLAG
    MOVLW   0
    ;---------------------------------------------------;
    CALL    _Write_Line_Data
    CALL    _Prev_Buffer_Digit_Ptr
    CALL    _Next_Matrix_Digit_Ptr
    SKPZ
    GOTO    _UM_Next_Digit
    ;---------------------------------------------------;
    CALL    _Set_LOAD
    CALL    _Prev_Buffer_Line_Ptr
    CALL    _Next_Matrix_Line_Ptr
    SKPZ
    GOTO    _UM_Next_Line
    ;---------------------------------------------------;
    MOVFW   Temp2
    MOVWF   Buffer_Line_Ptr
    MOVFW   Temp1
    MOVWF   Buffer_Digit_Ptr
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Write_Matrix:
;-------------------------------------------------------;
    SAVE_GIE_M
    TURN_OFF_INTS_M
    ;---------------------------------------------------;
    BCF     MAX7219_PORT, MAX7219_CLK_BIT
    BCF     MAX7219_PORT, MAX7219_DOUT_BIT
    ;---------------------------------------------------;
    MOVLW   8
    MOVWF   BitCount
    MOVFW   Command_HI
    MOVWF   Temp_Data
    ;---------------------------------------------------;
_WM_Command_Next_Bit:
    ;---------------------------------------------------;
    BTFSC   Temp_Data, MSB
    BSF     MAX7219_PORT, MAX7219_DOUT_BIT
    NOP
    BSF     MAX7219_PORT, MAX7219_CLK_BIT
    NOP
    BCF     MAX7219_PORT, MAX7219_CLK_BIT
    NOP
    BCF     MAX7219_PORT, MAX7219_DOUT_BIT
    RLF	    Temp_Data, F
    DECFSZ  BitCount, F
    GOTO    _WM_Command_Next_Bit
    MOVLW   8
    MOVWF   BitCount
    MOVFW   Command_LO
    MOVWF   Temp_Data
    ;---------------------------------------------------;
_WM_Data_Next_Bit:
    ;---------------------------------------------------;
    BTFSC   Temp_Data, MSB
    BSF	    MAX7219_PORT, MAX7219_DOUT_BIT
    NOP
    BSF	    MAX7219_PORT, MAX7219_CLK_BIT
    NOP
    BCF	    MAX7219_PORT, MAX7219_CLK_BIT
    NOP
    BCF	    MAX7219_PORT, MAX7219_DOUT_BIT
    RLF	    Temp_Data, F
    DECFSZ  BitCount, F
    GOTO    _WM_Data_Next_Bit
    ;---------------------------------------------------;
_WM_Exit:
    ;---------------------------------------------------;
    RESTORE_GIE_M
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Write_Line_Data:
;-------------------------------------------------------;
; W - Line Data
;-------------------------------------------------------;
    MOVWF   Command_LO      ;
    MOVFW   Matrix_Line_Ptr ;
    ADDLW   1               ;
    MOVWF   Command_HI      ; Set command byte, Data byte already set
    CALL    _Write_Matrix   ; Write data to line
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Set_CS:
;-------------------------------------------------------;
    BCF	    MAX7219_PORT, MAX7219_CS_BIT
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Set_LOAD:
;-------------------------------------------------------;
    BSF	    MAX7219_PORT, MAX7219_CS_BIT
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Do_Command:
;-------------------------------------------------------;
    CALL    _Set_CS
    CLRF    Matrix_Digit_Ptr
    ;---------------------------------------------------;
_DC_Next_Digit:
    ;---------------------------------------------------;
    CALL    _Write_Matrix
    CALL    _Next_Matrix_Digit_Ptr
    SKPZ
    GOTO    _DC_Next_Digit
    CALL    _Set_LOAD
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_NOP:
;-------------------------------------------------------;
    MOVLW   MAX7219_NOP
    MOVWF   Command_HI
    CLRF    Command_LO
    GOTO    _Do_Command
;-------------------------------------------------------;

;-------------------------------------------------------;
_Decode_OFF:
;-------------------------------------------------------;
    MOVLW   MAX7219_DECODE
    MOVWF   Command_HI
    MOVLW   DECODE_OFF
    MOVWF   Command_LO
    GOTO    _Do_Command
;-------------------------------------------------------;

;-------------------------------------------------------;
_Decode_ON:
;-------------------------------------------------------;
    MOVLW   MAX7219_DECODE
    MOVWF   Command_HI
    MOVLW   DECODE_ON
    MOVWF   Command_LO
    GOTO    _Do_Command
;-------------------------------------------------------;

;-------------------------------------------------------;
_Set_Intensity_MIN:
;-------------------------------------------------------;
    MOVLW   INTENSITY_MIN
    GOTO    _Set_Intensity_New
;-------------------------------------------------------;
_Set_Intensity_MAX:
;-------------------------------------------------------;
    MOVLW   INTENSITY_MAX
;-------------------------------------------------------;
_Set_Intensity_New:
;-------------------------------------------------------;
    MOVWF   Intensity
;-------------------------------------------------------;
_Set_Intensity:
;-------------------------------------------------------;
    MOVFW   Intensity
    MOVWF   Command_LO
    MOVLW   MAX7219_INTENSITY
    MOVWF   Command_HI
    GOTO    _Do_Command
;-------------------------------------------------------;

;-------------------------------------------------------;
_Inc_Intensity:
;-------------------------------------------------------;
    LSLF    Intensity, W
    ANDLW   H'0F'
    IORLW   H'01'
    MOVWF   Intensity
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Dec_Intensity:
;-------------------------------------------------------;
    LSRF    Intensity, W
    ANDLW   H'07'
    MOVWF   Intensity
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Get_Intensity:
;-------------------------------------------------------;
    MOVFW   Intensity
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Set_Scan_Limit_MIN:
;-------------------------------------------------------;
    MOVLW   SCANLIMIT_MIN
    GOTO    _Set_Scan_Limit
;-------------------------------------------------------;

;-------------------------------------------------------;
_Set_Scan_Limit_MAX:
;-------------------------------------------------------;
    MOVLW   SCANLIMIT_MAX
;    GOTO    _Set_Scan_Limit
;-------------------------------------------------------;
_Set_Scan_Limit:
;-------------------------------------------------------;
    MOVWF   Command_LO
    MOVLW   MAX7219_SCANLIMIT
    MOVWF   Command_HI
    GOTO    _Do_Command
;-------------------------------------------------------;

;-------------------------------------------------------;
_Shutdown_OFF:
;-------------------------------------------------------;
    MOVLW   SHUTDOWN_OFF
    MOVWF   Command_LO
    MOVLW   MAX7219_SHUTDOWN
    MOVWF   Command_HI
    GOTO    _Do_Command
;-------------------------------------------------------;

;-------------------------------------------------------;
_Shutdown_ON:
;-------------------------------------------------------;
    MOVLW   SHUTDOWN_ON
    MOVWF   Command_LO
    MOVLW   MAX7219_SHUTDOWN
    MOVWF   Command_HI
    GOTO    _Do_Command
;-------------------------------------------------------;

;-------------------------------------------------------;
_Display_Test_OFF:
;-------------------------------------------------------;
    MOVLW   DISPLAYTEST_OFF
    MOVWF   Command_LO
    MOVLW   MAX7219_DISPLAYTEST
    MOVWF   Command_HI
    GOTO    _Do_Command
;-------------------------------------------------------;

;-------------------------------------------------------;
_Display_Test_ON:
;-------------------------------------------------------;
    MOVLW   DISPLAYTEST_ON
    MOVWF   Command_LO
    MOVLW   MAX7219_DISPLAYTEST
    MOVWF   Command_HI
    GOTO    _Do_Command
;-------------------------------------------------------;

;-------------------------------------------------------;
_Next_Matrix_Line_Ptr:
;-------------------------------------------------------;
    INCF    Matrix_Line_Ptr, F
    MOVLW   MAX_LINES
    XORWF   Matrix_Line_Ptr, W
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Prev_Matrix_Line_Ptr:
;-------------------------------------------------------;
    DECF    Matrix_Line_Ptr, F
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Next_Matrix_Digit_Ptr:
;-------------------------------------------------------;
    INCF    Matrix_Digit_Ptr, F
    MOVLW   MAX_DIGITS
    XORWF   Matrix_Digit_Ptr, W
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Prev_Matrix_Digit_Ptr:
;-------------------------------------------------------;
    DECF    Matrix_Digit_Ptr, F
    MOVLW   H'FF'
    XORWF   Matrix_Digit_Ptr, W
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Next_Buffer_Line_Ptr:
;-------------------------------------------------------;
    INCF    Buffer_Line_Ptr, F
    MOVLW   MAX_LINES
    XORWF   Buffer_Line_Ptr, W
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Prev_Buffer_Line_Ptr:
;-------------------------------------------------------;
    DECF    Buffer_Line_Ptr, F
;    MOVLW   H'FF'
;    XORWF   Buffer_Line_Ptr, W
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Next_Buffer_Digit_Ptr:
;-------------------------------------------------------;
    INCF    Buffer_Digit_Ptr, F
    MOVLW   MAX_DIGITS
    XORWF   Buffer_Digit_Ptr, W
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Prev_Buffer_Digit_Ptr:
;-------------------------------------------------------;
    DECF    Buffer_Digit_Ptr, F
;    MOVLW   H'FF'
;    XORWF   Buffer_Digit_Ptr, W
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
#IF _LEFT_TO_RIGHT_
;-------------------------------------------------------;
_Reverse_W:
; W = data to reverse (0<>7, 1<>6, 2<>5, 3<>4)
;-------------------------------------------------------;
    MOVWF   Command_LO
    CLRF    Command_HI
    ;====================
    MOVLW   8
    MOVWF   BitCount
    ;---------------------------------------------------;
_RW_Next_Bit:
    ;---------------------------------------------------;
    RRF	    Command_HI, F
    RLF	    Command_LO, F
    SKPNC
    BSF	    Command_HI, 7
    CLRC
    ;====================
    DECFSZ  BitCount, F
    GOTO    _RW_Next_Bit
    ;====================
    MOVFW   Command_HI
    RETURN
;-------------------------------------------------------;
#ENDIF ; _LEFT_TO_RIGHT_
;-------------------------------------------------------;
    
;-------------------------------------------------------;
_Initialize_MAX7219_Subsystem:
;-------------------------------------------------------;
    ; Initialize MAX7219 ports
    ;---------------------------------------------------;
    BANKSEL MAX7219_DIR
    BCF     MAX7219_DIR, MAX7219_CS_BIT
    BCF     MAX7219_DIR, MAX7219_DOUT_BIT
    BCF     MAX7219_DIR, MAX7219_CLK_BIT
    BANKSEL MAX7219_PORT
    BSF     MAX7219_PORT, MAX7219_CS_BIT
    BCF     MAX7219_PORT, MAX7219_CLK_BIT
    BCF     MAX7219_PORT, MAX7219_DOUT_BIT
    ;---------------------------------------------------;
    ; Initialize MAX7219 Subsystem
    ;---------------------------------------------------;
    BANKSEL MEMORY
    ;---------------------------------------------------;
    MOVLW   INTENSITY_MIN
    MOVWF   Intensity
    CALL    _Init_Matrix
    CALL    _Clear_Buffer
    CALL    _Clear_Matrix
    CLRF    Command_HI
    CLRF    Command_LO
    CLRF    Matrix_Line_Ptr
    CLRF    Matrix_Digit_Ptr
    CLRF    Buffer_Line_Ptr
    CLRF    Buffer_Digit_Ptr
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
    END
;-------------------------------------------------------;
