;-------------------------------------------------------;
; Name:      I2C.ASM
; Use:       I2C Routines
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
#DEFINE  _I2C.ASM_
#INCLUDE Common.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
I2C_DATA       UDATA
;-------------------------------------------------------;
I2C_Addr       res 1
I2C_Data       res 1
I2C_Byte       res 1
I2C_BitCount   res 1
I2C_ByteCount  res 1
I2C_SavedCount res 1
I2C_Flags      res 1
;-------------------------------------------------------;
I2C_CODE       CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Delay:
;-------------------------------------------------------;
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Set_Device_Address:
;-------------------------------------------------------;
; device address in W, stored in I2C_Addr
;-------------------------------------------------------;
    MOVWF   I2C_Addr
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Set_Transfer_Size:
;-------------------------------------------------------;
; byte count in W, stored in I2C_ByteCount
;-------------------------------------------------------;
    MOVWF   I2C_ByteCount
    MOVWF   I2C_SavedCount
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Start_Write:
;-------------------------------------------------------;
; I2C address for device should be in I2C_Addr		;
;-------------------------------------------------------;
    BCF	    I2C_Flags, I2C_READ_BIT ; Clear R/W flag (Write)
    GOTO    _I2C_Start
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Start_Read:
;-------------------------------------------------------;
; I2C address for device should be in I2C_Addr		;
;-------------------------------------------------------;
    BSF	    I2C_Flags, I2C_READ_BIT ; Set R/W flag (Read)
    GOTO    _I2C_Start
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Start:
;-------------------------------------------------------;
; I2C address for device should be in I2C_Addr		;
;-------------------------------------------------------;
    BCF	    I2C_Flags, I2C_NACK_BIT ; Reset Ack Error
    BSF	    I2C_PORT, I2C_DAT_BIT   ; I2C Data HIGH
    BSF	    I2C_PORT, I2C_CLK_BIT   ; I2C Clock HIGH
    CALL    _I2C_Delay
    BCF	    I2C_PORT, I2C_DAT_BIT   ; I2C Data LOW
    CALL    _I2C_Delay
    BCF	    I2C_PORT, I2C_CLK_BIT   ; I2C Clock LOW
    CALL    _I2C_Delay
    CALL    _I2C_Delay
    BCF	    STATUS, C
    RLF	    I2C_Addr, W
    MOVWF   I2C_Byte
    BCF	    I2C_Byte, LSB
    BTFSC   I2C_Flags, I2C_READ_BIT
    BSF	    I2C_Byte, LSB
    CALL    _I2C_Write_Bits
    BTFSS   I2C_Flags, I2C_NACK_BIT
    RETURN
    CALL    _I2C_Stop
    GOTO    _I2C_Start_Write
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Write_Bits:
;-------------------------------------------------------;
    MOVLW   8
    MOVWF   I2C_BitCount            ; Set bit count.
    ;---------------------------------------------------;
IWBi_Next_Bit:
    ;---------------------------------------------------;
    BTFSS   I2C_Byte, MSB           ; Data high or low?
    BCF	    I2C_DAT                 ; Low, set I2C Data LOW
    BTFSC   I2C_Byte, MSB           ; Data high or low?
    BSF	    I2C_DAT                 ; High, set I2C Data HIGH
    CALL    _I2C_Delay
    BSF	    I2C_CLK                 ; I2C Clock HIGH
    CALL    _I2C_Delay
    BCF	    I2C_CLK                 ; I2C Clock LOW 
    CALL    _I2C_Delay
    BCF	    I2C_DAT                 ; I2C Data LOW 
    CALL    _I2C_Delay
    RLF	    I2C_Byte, F
    DECFSZ  I2C_BitCount, F         ; Do all bits.
    GOTO    IWBi_Next_Bit
    CALL    _I2C_Delay
    BANKSEL I2C_DIR
    BSF	    I2C_DIR, I2C_DAT_BIT    ; I2C Data an input
    BANKSEL MEMORY
    BSF	    I2C_CLK                 ; I2C Clock HIGH
    NOP
    BTFSC   I2C_PORT, I2C_DAT_BIT   ; Do we have an acknowledge?
    BSF	    I2C_Flags, I2C_NACK_BIT ; Flag I2C NACK
    CALL    _I2C_Delay
    BCF	    I2C_CLK                 ; I2C Clock LOW
    CALL    _I2C_Delay
    BANKSEL I2C_DIR
    BCF	    I2C_DIR, I2C_DAT_BIT    ; I2C Data an output
    BANKSEL I2C_PORT
    BCF	    I2C_DAT                 ; I2C Data LOW
    BANKSEL MEMORY
    CALL    _I2C_Delay
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Read_Bits:
;-------------------------------------------------------;
    BCF	    I2C_PORT, I2C_DAT_BIT ; I2C Data LOW
    BANKSEL I2C_DIR
    BSF	    I2C_DIR, I2C_DAT_BIT  ; I2C Data As Input
    BANKSEL MEMORY
    CALL    _I2C_Delay
    MOVLW   8
    MOVWF   I2C_BitCount          ; Set bit count.
    CLRF    I2C_Byte
    ;---------------------------------------------------;
IRBi_Next_Bit:
    ;---------------------------------------------------;
    BCF	    STATUS, C
    RLF	    I2C_Byte, F
    CALL    _I2C_Delay
    BSF	    I2C_CLK               ; I2C Clock HIGH
    CALL    _I2C_Delay
    BTFSC   I2C_DAT               ; Is data bit high?
    BSF	    I2C_Byte, LSB         ; Yes, set it in I2C byte
    CALL    _I2C_Delay
    BCF	    I2C_PORT, I2C_CLK_BIT ; I2C Clock LOW
    CALL    _I2C_Delay
    DECFSZ  I2C_BitCount, F       ; Do all bits
    GOTO    IRBi_Next_Bit
    MOVWF   INDF1
    BANKSEL I2C_DIR
    BCF	    I2C_DIR, I2C_DAT_BIT  ; I2C Data As Output
    BANKSEL MEMORY
    CALL    _I2C_Delay
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Master_ACK:
;-------------------------------------------------------;
    BANKSEL I2C_DIR
    BCF	    I2C_DIR, I2C_DAT_BIT  ; I2C Data an output
    BANKSEL MEMORY
    BCF	    I2C_PORT, I2C_DAT_BIT ; I2C Data LOW
    GOTO    _I2C_Master_ACK_NACK
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Master_NACK:
;-------------------------------------------------------;
    BANKSEL I2C_DIR
    BCF	    I2C_DIR, I2C_DAT_BIT  ; I2C Data an output
    BANKSEL MEMORY
    BSF	    I2C_PORT, I2C_DAT_BIT ; I2C Data LOW
    GOTO    _I2C_Master_ACK_NACK
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Master_ACK_NACK:
;-------------------------------------------------------;
    CALL    _I2C_Delay
    BSF	    I2C_PORT, I2C_CLK_BIT ; I2C Clock HIGH
    CALL    _I2C_Delay
    BCF	    I2C_PORT, I2C_CLK_BIT ; I2C Clock LOW
    CALL    _I2C_Delay
    BANKSEL I2C_DIR
    BCF	    I2C_DIR, I2C_DAT_BIT  ; I2C Data an output
    BANKSEL MEMORY
    BCF	    I2C_PORT, I2C_DAT_BIT ; I2C Data LOW
    CALL    _I2C_Delay
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Stop:
;-------------------------------------------------------;
    BCF	    I2C_PORT, I2C_CLK_BIT ; Ensure I2C Clock LOW
    BCF	    I2C_PORT, I2C_DAT_BIT ; Ensure I2C Data LOW
    CALL    _I2C_Delay
    BSF	    I2C_PORT, I2C_CLK_BIT ; I2C Clock HIGH First
    CALL    _I2C_Delay
    BSF	    I2C_PORT, I2C_DAT_BIT ; I2C Data HIGH Last, during Clock HIGH
    CALL    _I2C_Delay
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Write_Byte:
;-------------------------------------------------------;
    MOVWF   I2C_Data
    ;---------------------------------------------------;
IWB_Start:
    ;---------------------------------------------------;
    CALL    _I2C_Start_Write
    MOVFW   I2C_Data
    MOVWF   I2C_Byte
    CALL    _I2C_Write_Bits
    CALL    _I2C_Stop
    BTFSC   I2C_Flags, I2C_NACK_BIT
    GOTO    IWB_Start
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Write_Bytes:
;-------------------------------------------------------;
; (Uses FSR1 and INDF1)
; I2C_ByteCount contains number of bytes to xfer
;-------------------------------------------------------;
    CLRF    FSR1H
    MOVWF   I2C_Data
    MOVWF   FSR1L
    MOVLW   H'00'
    XORWF   I2C_ByteCount, F
    BTFSS   STATUS, Z
    GOTO    IWBy_Start
    MOVLW   H'01'
    MOVWF   I2C_ByteCount
    ;---------------------------------------------------;
IWBy_Start:
    ;---------------------------------------------------;
    MOVFW   I2C_ByteCount
    MOVWF   I2C_SavedCount
    CALL    _I2C_Start_Write
    ;---------------------------------------------------;
IWBy_Next_Byte:
    ;---------------------------------------------------;
    MOVFW   INDF1
    MOVWF   I2C_Byte
    CALL    _I2C_Write_Bits
    BTFSC   I2C_Flags, I2C_NACK_BIT
    GOTO    IWBy_Error
    INCF    FSR1L, F
    SKPNC
    INCF    FSR1H, F
    DECFSZ  I2C_ByteCount, F
    GOTO    IWBy_Next_Byte
    CALL    _I2C_Stop
    MOVFW   I2C_SavedCount
    MOVWF   I2C_ByteCount
    RETURN
    ;---------------------------------------------------;
IWBy_Error:
    ;---------------------------------------------------;
    CALL    _I2C_Stop
    MOVFW   I2C_SavedCount
    MOVWF   I2C_ByteCount
    MOVFW   LOW I2C_Data
    MOVWF   FSR1L
    MOVFW   HIGH I2C_Data
    MOVWF   FSR1H
    GOTO    _I2C_Write_Bytes
;-------------------------------------------------------;

;-------------------------------------------------------;
_I2C_Read_Bytes:
;-------------------------------------------------------;
; (Uses FSR1 and INDF1)
; I2C_ByteCount contains number of bytes to xfer
;-------------------------------------------------------;
    MOVWF   FSR1L
    CLRF    FSR1H
    MOVLW   H'00'
    XORWF   I2C_ByteCount, F
    BTFSS   STATUS, Z
    GOTO    IRBy_Start
    MOVLW   H'01'
    MOVWF   I2C_ByteCount
    ;---------------------------------------------------;
IRBy_Start:
    ;---------------------------------------------------;
    MOVFW   I2C_ByteCount
    MOVWF   I2C_SavedCount
    CALL    _I2C_Start_Read
    ;---------------------------------------------------;
IRBy_Next_Byte:
    ;---------------------------------------------------;
    CALL    _I2C_Read_Bits
    MOVLW   H'01'
    XORWF   I2C_ByteCount, W
    BTFSS   STATUS, Z
    CALL    _I2C_Master_ACK  ; don't ACK if last byte
    MOVFW   I2C_Byte
    MOVWF   INDF1
    INCF    FSR1L, F
    SKPNC
    INCF    FSR1H, F
    DECFSZ  I2C_ByteCount, F
    GOTO    IRBy_Next_Byte
    CALL    _I2C_Master_NACK ; NACK on last byte
    CALL    _I2C_Stop
    MOVFW   I2C_SavedCount
    MOVWF   I2C_ByteCount
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Init_I2C_Subsystem:
;-------------------------------------------------------;
    BANKSEL I2C_DIR               ;
    BCF	    I2C_DIR, I2C_CLK_BIT  ; I2C_CLK as output
    BCF	    I2C_DIR, I2C_DAT_BIT  ; I2C_DAT as output
    BANKSEL I2C_PORT              ;
    BSF	    I2C_PORT, I2C_CLK_BIT ; I2C_CLK high
    NOP                           ;
    NOP                           ;
    BSF	    I2C_PORT, I2C_DAT_BIT ; I2C_DAT high
    ;---------------------------------------------------;
    ; Initialize Variables
    ;---------------------------------------------------;
    BANKSEL MEMORY
    ;---------------------------------------------------;
    CLRF    I2C_Addr
    CLRF    I2C_Flags
    CLRF    I2C_ByteCount
    ;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
    END
;-------------------------------------------------------;
