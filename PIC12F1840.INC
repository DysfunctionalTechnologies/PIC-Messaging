;-------------------------------------------------------;
; Name:      PIC12F1840.INC
; Use:       PIC12F1840 Routines Header File
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
#DEFINE _PIC12F1840.INC_
;-------------------------------------------------------;
; PIC12F1840 Pinout:
;-------------------------------------------------------;
;
;                             PIC12F1840 
;                              |------|
;                   (+5V) VDD -| 1  8 |- VSS (GND)
;               (I2C_CLK) RA5 -| 2  7 |- RA0 (MATRIX_CLK)
; (MATRIX_DOUT / I2C_DAT) RA4 -| 3  6 |- RA1 (MATRIX_LOAD/CS)
;               (IR_DATA) RA3 -| 4  5 |- RA2 (UNUSED)
;                              |------|
;
;               NOTE: RA5 is I2C_CLK Input/Output
;                     RA4 is I2C_DAT Input/Output / MATRIX_DOUT Output
;                     RA3 is IR_DATA Input
;                     RA2 is UNUSED
;                     RA1 is MATRIX LOAD/CS Output
;                     RA0 is MATRIX CLK Output
;
;-------------------------------------------------------;

;-------------------------------------------------------;
    LIST P=PIC12F1840
#INCLUDE <p12f1840.inc>
;-------------------------------------------------------;
    ; Set default radix to DECIMAL (Was HEX)		;
    ;---------------------------------------------------;
    RADIX DEC
    ;---------------------------------------------------;
    ; Suppress message 207 from list file
    ; (Found label after column 1)
    ;---------------------------------------------------;
    ; ERRORLEVEL -207
    ;---------------------------------------------------;
    ; Suppress message 302 from list file
    ; (Register in operand not in bank 0)
    ;---------------------------------------------------;
    ERRORLEVEL -302
;-------------------------------------------------------;

;-------------------------------------------------------;
; Common Defines
;-------------------------------------------------------;
#DEFINE FALSE   0
#DEFINE TRUE   -1
    ;---------------------------------------------------;
#DEFINE	MEMORY  0
    ;---------------------------------------------------;
#DEFINE	LSB     0
#DEFINE	MSB     7
;-------------------------------------------------------;

;-------------------------------------------------------;
#IFDEF _MAIN.ASM_
;-------------------------------------------------------;
    ; Set Configuration Bits
    ;---------------------------------------------------;
    __CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_ON & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _CLKOUTEN_OFF & _IESO_OFF & _FCMEN_OFF
    __CONFIG _CONFIG2, _WRT_OFF & _PLLEN_OFF & _STVREN_ON & _BORV_LO & _LVP_OFF
;-------------------------------------------------------;
#ENDIF ; _MAIN.ASM_
;-------------------------------------------------------;

;-------------------------------------------------------;
; Hardware Defines
;-------------------------------------------------------;
#DEFINE EEPROM_START          H'F000'
#DEFINE EEPROM_LENGTH         H'100'
    ;---------------------------------------------------;
#DEFINE LINEAR_BUFFER_ADDRESS H'2050'    
#DEFINE BUFFER_1_ADDRESS      H'048'
#DEFINE BUFFER_1_SIZE         40
#DEFINE BUFFER_2_ADDRESS      H'0A0'
#DEFINE BUFFER_2_SIZE         80
#DEFINE BUFFER_3_ADDRESS      H'120'
#DEFINE BUFFER_3_SIZE         80
    ;---------------------------------------------------;
    ; H'020'-H'02F' -> H'2000'-H'200F' ; 80 bytes
    ; H'030'-H'03F' -> H'2010'-H'201F' ;
    ; H'040'-H'04F' -> H'2020'-H'202F' ;
    ; H'050'-H'05F' -> H'2030'-H'203F' ;
    ; H'060'-H'06F' -> H'2040'-H'204F' ;
    ;---------------------------------------------------;
    ; H'0A0'-H'0AF' -> H'2050'-H'205F' ; 80 bytes
    ; H'0B0'-H'0BF' -> H'2060'-H'206F' ;
    ; H'0C0'-H'0CF' -> H'2070'-H'207F' ; 240 bytes total
    ; H'0D0'-H'0DF' -> H'2080'-H'208F' ;
    ; H'0E0'-H'0EF' -> H'2090'-H'209F' ;
    ;---------------------------------------------------;
    ; H'120'-H'12F' -> H'20A0'-H'20AF' ; 80 bytes
    ; H'130'-H'13F' -> H'20B0'-H'20BF' ;
    ; H'140'-H'14F' -> H'20C0'-H'20CF' ;
    ; H'150'-H'15F' -> H'20D0'-H'20DF' ;
    ; H'160'-H'16F' -> H'20E0'-H'20EF' ;
    ;---------------------------------------------------;
#DEFINE MAX7219_DIR           TRISA ;
#DEFINE MAX7219_PORT          PORTA ;
#DEFINE MAX7219_CLK_BYTE      H'01' ;
#DEFINE MAX7219_CLK_BIT       0     ; GPIO 0 - Pin 7
#DEFINE MAX7219_CLK           MAX7219_PORT, MAX7219_CLK_BIT
#DEFINE MAX7219_CS_BYTE       H'02' ;
#DEFINE MAX7219_CS_BIT        1     ; GPIO 1 - Pin 6
#DEFINE MAX7219_CS            MAX7219_PORT, MAX7219_CS_BIT
#DEFINE MAX7219_DOUT_BYTE     H'10' ;
#DEFINE MAX7219_DOUT_BIT      4     ; GPIO 4 - Pin 3
#DEFINE MAX7219_DOUT          MAX7219_PORT, MAX7219_DOUT_BIT
    ;---------------------------------------------------;
#DEFINE UNUSED_2_DIR          TRISA ;
#DEFINE UNUSED_2_PORT         PORTA ;
#DEFINE UNUSED_2_BYTE         H'04' ;
#DEFINE UNUSED_2_BIT          2     ; GPIO 2 - Pin 5
#DEFINE UNUSED_2              UNUSED_2_PORT, UNUSED_2_BIT
    ;---------------------------------------------------;
#DEFINE IR_DIR                TRISA ;
#DEFINE IR_PORT               PORTA ;
#DEFINE IR_BYTE               H'08' ;
#DEFINE IR_BIT                3     ; GPIO 3 - PIN 4
#DEFINE IR                    IR_PORT, IR_BIT
    ;---------------------------------------------------;
#DEFINE I2C_DIR               TRISA ;
#DEFINE I2C_PORT              PORTA ;
#DEFINE I2C_DAT_BYTE          H'10' ;
#DEFINE I2C_DAT_BIT           4     ; GPIO 4 - Pin 3
#DEFINE I2C_DAT               I2C_PORT, I2C_DAT_BIT
#DEFINE I2C_CLK_BYTE          H'20' ;
#DEFINE I2C_CLK_BIT           5     ; GPIO 5 - Pin 2
#DEFINE I2C_CLK               I2C_PORT, I2C_CLK_BIT
;-------------------------------------------------------;

;-------------------------------------------------------;
; Macros
;-------------------------------------------------------;
;-------------------------------------------------------;

;-------------------------------------------------------;
#IFDEF _PIC12F1840.ASM_
;-------------------------------------------------------;
    GLOBAL  _Initialize_Microcontroller
    GLOBAL  _Initialize_Oscillator
    GLOBAL  _Initialize_Miscellaneous
    GLOBAL  _Initialize_Ports
;-------------------------------------------------------;
#ELSE ; !_PIC12F1840.ASM_
;-------------------------------------------------------;
    EXTERN  _Initialize_Microcontroller
    EXTERN  _Initialize_Oscillator
    EXTERN  _Initialize_Miscellaneous
    EXTERN  _Initialize_Ports
;-------------------------------------------------------;
#ENDIF ; !_PIC12F1840.ASM_
;-------------------------------------------------------;
