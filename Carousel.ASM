;-------------------------------------------------------;
; Name:      Carousel.ASM
; Use:       Carousel Routines
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
#DEFINE  _CAROUSEL.ASM_
#INCLUDE Common.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
CAROUSEL_DATA UDATA
;-------------------------------------------------------;
Slot_Dwell    res 1
Dwell_Count   res 1
;-------------------------------------------------------;

;-------------------------------------------------------;
CAROUSEL_CODE CODE
;-------------------------------------------------------;

;-------------------------------------------------------;
_EEPS_Restart:
;-------------------------------------------------------;
    CLRF    Current_Display
	;---------------------------------------------------;
_EE_Print_Slot:
	;---------------------------------------------------;
    BANKSEL MEMORY
    MOVLW   14
    MOVWF   Dwell_Count
	;---------------------------------------------------;
_EEPS_Try:
	;---------------------------------------------------;
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
    CALL    _EE_Read_Byte
    BANKSEL MEMORY
    MOVFW   EE_Data
    MOVWF   Slot_Dwell
    XORLW   H'FF'
    SKPNZ
    GOTO    _EEPS_Empty
    BTFSC   Slot_Dwell, SLOT_ENABLED_BIT
    GOTO    _EEPS_Text
    INCF    Current_Display, F
    MOVLW   14
    SUBWF   Current_Display, W
    SKPNC
    CLRF    Current_Display
    DECFSZ  Dwell_Count, F
    GOTO    _EEPS_Try
    GOTO    _EEPS_AllOff
	;---------------------------------------------------;
_EEPS_AllOff:
	;---------------------------------------------------;
    CALL    _Print_No_Enabled
    MOVLW   H'FD'
    MOVWF   Current_Display
    MOVLW   10
    BANKSEL Slot_Dwell
    MOVWF   Slot_Dwell
    CALL    _Load_Dwell_Timer
	;---------------------------------------------------;
    RETURN
	;---------------------------------------------------;
_EEPS_Text:
	;---------------------------------------------------;
    INCF    EE_Addr, F
    CLRF    Temp1
	;---------------------------------------------------;
_EEPS_Next:
	;---------------------------------------------------;
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
	;---------------------------------------------------;
    RETURN
	;---------------------------------------------------;
_EEPS_Empty:
	;---------------------------------------------------;
    MOVFW   Current_Display
    SKPZ
    GOTO    _EE_SkipEmpty
    CALL    _Clear_Buffer
    CALL    _Update_Matrix
    MOVLW   30
    BANKSEL Slot_Dwell
    MOVWF   Slot_Dwell
    MOVLW   H'FF'
    MOVWF   Current_Display
	;---------------------------------------------------;
    RETURN
	;---------------------------------------------------;
_EE_SkipEmpty:
	;---------------------------------------------------;
    INCF    Current_Display, F
    MOVLW   14
    SUBWF   Current_Display, W
    SKPNC
    CLRF    Current_Display
    DECFSZ  Dwell_Count, F
    GOTO    _EEPS_Try
    GOTO    _EEPS_AllOff
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
    MOVLW   A'Z'+1
    SUBWF   Temp2, W
    SKPC
    GOTO    _EE_San_OK
	;---------------------------------------------------;
_EE_San_Space:
	;---------------------------------------------------;
    MOVLW   A' '
	;---------------------------------------------------;
    RETURN
	;---------------------------------------------------;
_EE_San_OK:
	;---------------------------------------------------;
    MOVFW   Temp2
	;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Load_Dwell_Timer:
;-------------------------------------------------------;
    BANKSEL Slot_Dwell
    MOVFW   Slot_Dwell
    ANDLW   DWELL_TICKS_MASK
    SKPNZ
    MOVLW   30
    MOVWF   Dwell_Count
    BANKSEL Display_Timer_LO
    CLRF    Display_Timer_LO
    CLRF    Display_Timer_HI
	;---------------------------------------------------;
_LDT_Loop:
	;---------------------------------------------------;
    MOVLW   20                      ; 100ms / 5ms T0
    ADDWF   Display_Timer_LO, F
    SKPNC
    INCF    Display_Timer_HI, F
    BANKSEL Dwell_Count
    DECFSZ  Dwell_Count, F
    GOTO    _LDT_Loop
	;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
_Init_Carousel_Subsystem:
;-------------------------------------------------------;
    ; Initialize Variables
    ;---------------------------------------------------;
    BANKSEL MEMORY
    CLRF	Slot_Dwell
    BCF		EE_GLASS_FLAG
	;---------------------------------------------------;
    RETURN
;-------------------------------------------------------;

;-------------------------------------------------------;
CAROUSEL_EEDATA org __EEPROM_START
;-------------------------------------------------------;
; First word = dwell (* 10ms). If 0xFF, end of slots.
; If bit 7 = 1, slot disabled, string not displayed.
; Following words 1-17 - the actual string
;-------------------------------------------------------;
    ; Slot 00
    DE  EE_FLAG_MSG_ENABLED + 30 ; * 100ms = 3 seconds
    DE	" MERRY CHRISTMAS " ;
    ; Slot 01
    DE  EE_FLAG_MSG_ENABLED + 30 ; * 100ms = 3 seconds
    DE  " HAPPY NEW YEAR! " ;
    ; Slot 02
    DE  EE_FLAG_MSG_DISABLED  ; bit 7 = 0 = disabled
    DE	"SLOT 02 DISABLED " ;
    ; Slot 03
    DE  EE_FLAG_MSG_DISABLED  ; bit 7 = 0 = disabled
    DE	"SLOT 03 DISABLED " ;
    ; Slot 04
    DE  EE_FLAG_MSG_DISABLED  ; bit 7 = 0 = disabled
    DE	"SLOT 04 DISABLED " ;
    ; Slot 05
    DE  EE_FLAG_MSG_DISABLED  ; bit 7 = 0 = disabled
    DE  "SLOT 05 DISABLED " ;
    ; Slot 06
    DE  EE_FLAG_MSG_DISABLED  ; bit 7 = 0 = disabled
    DE  "SLOT 06 DISABLED " ;
    ; Slot 07
    DE  EE_FLAG_MSG_DISABLED  ; bit 7 = 0 = disabled
    DE  "SLOT 07 DISABLED " ;
    ; Slot 08
    DE  EE_FLAG_MSG_DISABLED  ; bit 7 = 0 = disabled
    DE  "SLOT 08 DISABLED " ;
    ; Slot 09
    DE  EE_FLAG_MSG_DISABLED  ; bit 7 = 0 = disabled
    DE  "SLOT 09 DISABLED " ;
    ; Slot 10
    DE  EE_FLAG_MSG_DISABLED  ; bit 7 = 0 = disabled
    DE  "SLOT 10 DISABLED " ;
    ; Slot 11
    DE  EE_FLAG_MSG_DISABLED  ; bit 7 = 0 = disabled
    DE  "SLOT 11 DISABLED " ;
    ; Slot 12
    DE  EE_FLAG_MSG_DISABLED  ; bit 7 = 0 = disabled
    DE  "SLOT 12 DISABLED " ;
    ; Slot 13
    DE  EE_FLAG_MSG_DISABLED  ; bit 7 = 0 = disabled
    DE  "SLOT 13 DISABLED " ;
    ; End of Carousel
    DE  EE_END_OF_SLOTS
    
    org     __EEPROM_START + EE_FLAGS
    DE  0x01    
;-------------------------------------------------------;
    
;-------------------------------------------------------;
    END
;-------------------------------------------------------;
