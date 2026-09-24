;-------------------------------------------------------;
; Name:      Himem_For_PIC12F1840.ASM
; Use:       High Memory For PIC12F1840 Routines
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
#DEFINE  _HIMEM_FOR_PIC12F1840.ASM_
#INCLUDE Common.INC
;-------------------------------------------------------;

;-------------------------------------------------------;
HIMEM_CODE CODE H'0800'
;-------------------------------------------------------;

;-------------------------------------------------------;
_String_Table:
;-------------------------------------------------------;
    DE  " MESSAGING V",(VERSION_MAJOR & H'0F') + '0', ".", ((VERSION_MINOR & H'F0') >> 4) + '0', (VERSION_MINOR & H'0F') + '0', " " ; 0
    DE	"   WELCOME TO    " ; 1
    DE  "  DYSFUNCTIONAL  " ; 2
    DE	"  TECHNOLOGIES   " ; 3
    DE	"   PHILIPPINES   " ; 4
    DE  "GOD BLESS AMERICA" ; 5
;-------------------------------------------------------;

;-------------------------------------------------------;
_Font_Table:
;-------------------------------------------------------;
    DE ' ' ; Space
    ;-------------;
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    ;-------------;
    DE '.' ; Period
    ;-------------;
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00011000'
    DE B'00011000'
    ;-------------;
    DE ':' ; Colon
    ;-------------;
    DE B'00000000'
    DE B'00011000'
    DE B'00011000'
    DE B'00000000'
    DE B'00000000'
    DE B'00011000'
    DE B'00011000'
    DE B'00000000'
    ;-------------;
    DE '|' ; Vertical Bar
    ;-------------;
    DE B'00000000'
    DE B'00011000'
    DE B'00011000'
    DE B'00011000'
    DE B'00011000'
    DE B'00011000'
    DE B'00011000'
    DE B'00000000'
    ;-------------;
    DE '+' ; Plus
    ;-------------;
    DE B'00000000'
    DE B'00000000'
    DE B'00010000'
    DE B'00111000'
    DE B'00010000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    ;-------------;
    DE '-' ; Minus
    ;-------------;
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00111000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    ;-------------;
    DE '`' ; Tick
    ;-------------;
    DE B'00011000'
    DE B'00011000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    ;-------------;
    DE '/' ; Forward Slash
    ;-------------;
    DE B'00000100'
    DE B'00000100'
    DE B'00001000'
    DE B'00001000'
    DE B'00010000'
    DE B'00010000'
    DE B'00100000'
    DE B'00100000'
    ;-------------;
    DE '0' ; Zero
    ;-------------;
    DE B'00111000'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'00111000'
    ;-------------;
    DE '1' ; One
    ;-------------;
    DE B'00010000'
    DE B'00110000'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    DE B'01111100'
    ;-------------;
    DE '2'
    ;-------------;
    DE B'00111000'
    DE B'01000100'
    DE B'00000100'
    DE B'00111000'
    DE B'01000000'
    DE B'01000000'
    DE B'01000000'
    DE B'01111100'
    ;-------------;
    DE '3'
    ;-------------;
    DE B'00111000'
    DE B'01000100'
    DE B'00000100'
    DE B'00011000'
    DE B'00000100'
    DE B'00000100'
    DE B'01000100'
    DE B'00111000'
    ;-------------;
    DE '4'
    ;-------------;
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01111100'
    DE B'00000100'
    DE B'00000100'
    DE B'00000100'
    DE B'00000100'
    ;-------------;
    DE '5'
    ;-------------;
    DE B'01111100'
    DE B'01000000'
    DE B'01000000'
    DE B'01111000'
    DE B'00000100'
    DE B'00000100'
    DE B'01000100'
    DE B'00111000'
    ;-------------;
    DE '6'
    ;-------------;
    DE B'00111000'
    DE B'01000100'
    DE B'01000000'
    DE B'01111000'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'00111000'
    ;-------------;
    DE '7'
    ;-------------;
    DE B'01111100'
    DE B'00000100'
    DE B'00000100'
    DE B'00001000'
    DE B'00010000'
    DE B'00100000'
    DE B'01000000'
    DE B'01000000'
    ;-------------;
    DE '8'
    ;-------------;
    DE B'00111000'
    DE B'01000100'
    DE B'01000100'
    DE B'00111000'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'00111000'
    ;-------------;
    DE '9'
    ;-------------;
    DE B'00111000'
    DE B'01000100'
    DE B'01000100'
    DE B'00111100'
    DE B'00000100'
    DE B'00000100'
    DE B'01000100'
    DE B'00111000'
    ;-------------;
    DE 'A'
    ;-------------;
    DE B'00111000'
    DE B'01000100'
    DE B'01000100'
    DE B'01111100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    ;-------------;
    DE 'B'
    ;-------------;
    DE B'01111000'
    DE B'01000100'
    DE B'01000100'
    DE B'01111000'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01111000'
    ;-------------;
    DE 'C'
    ;-------------;
    DE B'00111000'
    DE B'01000100'
    DE B'01000000'
    DE B'01000000'
    DE B'01000000'
    DE B'01000000'
    DE B'01000100'
    DE B'00111000'
    ;-------------;
    DE 'D'
    ;-------------;
    DE B'01111000'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01111000'
    ;-------------;
    DE 'E'
    ;-------------;
    DE B'01111100'
    DE B'01000000'
    DE B'01000000'
    DE B'01110000'
    DE B'01000000'
    DE B'01000000'
    DE B'01000000'
    DE B'01111100'
    ;-------------;
    DE 'F'
    ;-------------;
    DE B'01111100'
    DE B'01000000'
    DE B'01000000'
    DE B'01110000'
    DE B'01000000'
    DE B'01000000'
    DE B'01000000'
    DE B'01000000'
    ;-------------;
    DE 'G'
    ;-------------;
    DE B'00111000'
    DE B'01000100'
    DE B'01000000'
    DE B'01011100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'00111000'
    ;-------------;
    DE 'H'
    ;-------------;
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01111100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    ;-------------;
    DE 'I'
    ;-------------;
    DE B'01111100'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    DE B'01111100'
    ;-------------;
    DE 'J'
    ;-------------;
    DE B'01111100'
    DE B'00000100'
    DE B'00000000'
    DE B'00000100'
    DE B'00000100'
    DE B'00000100'
    DE B'01000100'
    DE B'00111000'
    ;-------------;
    DE 'K'
    ;-------------;
    DE B'01000100'
    DE B'01000100'
    DE B'01001000'
    DE B'01110000'
    DE B'01001000'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    ;-------------;
    DE 'L'
    ;-------------;
    DE B'01000000'
    DE B'01000000'
    DE B'01000000'
    DE B'01000000'
    DE B'01000000'
    DE B'01000000'
    DE B'01000000'
    DE B'01111100'
    ;-------------;
    DE 'M'
    ;-------------;
    DE B'01000100'
    DE B'01101100'
    DE B'01010100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    ;-------------;
    DE 'N'
    ;-------------;
    DE B'01000100'
    DE B'01100100'
    DE B'01010100'
    DE B'01001100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    ;-------------;
    DE 'O'
    ;-------------;
    DE B'00111000'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'00111000'
    ;-------------;
    DE 'P'
    ;-------------;
    DE B'01111000'
    DE B'01000100'
    DE B'01000100'
    DE B'01111000'
    DE B'01000000'
    DE B'01000000'
    DE B'01000000'
    DE B'01000000'
    ;-------------;
    DE 'O'
    ;-------------;
    DE B'00111000'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01010100'
    DE B'01001000'
    DE B'00110100'
    ;-------------;
    DE 'R'
    ;-------------;
    DE B'01111000'
    DE B'01000100'
    DE B'01000100'
    DE B'01111000'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    ;-------------;
    DE 'S'
    ;-------------;
    DE B'00111000'
    DE B'01000100'
    DE B'01000000'
    DE B'00111000'
    DE B'00000100'
    DE B'00000100'
    DE B'01000100'
    DE B'00111000'
    ;-------------;
    DE 'T'
    ;-------------;
    DE B'01111100'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    ;-------------;
    DE 'U'
    ;-------------;
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'00111000'
    ;-------------;
    DE 'V'
    ;-------------;
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'00101000'
    DE B'00010000'
    ;-------------;
    DE 'W'
    ;-------------;
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'01010100'
    DE B'01101100'
    DE B'01000100'
    ;-------------;
    DE 'x'
    ;-------------;
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'01000100'
    DE B'00101000'
    DE B'00010000'
    DE B'00101000'
    DE B'01000100'
    ;-------------;
    DE 'X'
    ;-------------;
    DE B'01000100'
    DE B'01000100'
    DE B'00101000'
    DE B'00010000'
    DE B'00101000'
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    ;-------------;
    DE 'Y'
    ;-------------;
    DE B'01000100'
    DE B'01000100'
    DE B'01000100'
    DE B'00111000'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    DE B'00010000'
    ;-------------;
    DE 'Z'
    ;-------------;
    DE B'01111100'
    DE B'00000100'
    DE B'00001000'
    DE B'00010000'
    DE B'00100000'
    DE B'01000000'
    DE B'01000000'
    DE B'01111100'
    ;-------------;
    DE SPECIAL_DEGREE ; Special Degree
    ;-------------;
    DE B'00010000'
    DE B'00101000'
    DE B'00010000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    ;-------------;
    DE SPECIAL_AM_PM ; Special AM/PM Indicator
    ;-------------;
    DE B'00000001'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    ;-------------;
    DE SPECIAL_DOT ; Special Dot
    ;-------------;
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000000'
    DE B'00000001'
    ;-------------;
    DE SPECIAL_COLON ; Special Colon
    ;-------------;
    DE B'00000000'
    DE B'00000001'
    DE B'00000001'
    DE B'00000000'
    DE B'00000000'
    DE B'00000001'
    DE B'00000001'
    DE B'00000000'
    ;-------------;
    DE SPECIAL_SLASH ; Special Slash
    ;-------------;
    DE B'00000000'
    DE B'00000000'
    DE B'00000001'
    DE B'00000001'
    DE B'00000001'
    DE B'00000001'
    DE B'00000000'
    DE B'00000000'
    ;-------------;
    DE	EOF_MARKER
;-------------------------------------------------------;

;-------------------------------------------------------;
    DE	H'00DE',H'00AD',H'00BE',H'00EF'
;-------------------------------------------------------;

    ;---------------------------------------------------;
    ; H'0800'-H'08FF'
    ;---------------------------------------------------;
;    DW	H'0800',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0800'-H'0807'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0808'-H'080F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0810'-H'0817'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0818'-H'081F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0820'-H'0827'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0828'-H'082F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0830'-H'0837'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0838'-H'083F'
;    DW	H'0840',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0840'-H'0847'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0848'-H'084F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0850'-H'0857'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0858'-H'085F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0860'-H'0867'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0868'-H'086F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0870'-H'0877'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0878'-H'087F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0880'-H'0887'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0888'-H'088F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0890'-H'0897'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0898'-H'089F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'08A0'-H'08A7'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'08A8'-H'08AF'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'08B0'-H'08B7'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'08B8'-H'08BF'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'08C0'-H'08C7'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'08C8'-H'08CF'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'08D0'-H'08D7'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'08D8'-H'08DF'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'08E0'-H'08E7'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'08E8'-H'08EF'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'08F0'-H'08F7'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'00DE',H'00AD',H'00BE',H'00EF',H'08FF' ; H'08F8'-H'08FF'
    ;---------------------------------------------------;
    ; H'0900'-H'09FF'
    ;---------------------------------------------------;
;    DW	H'0900',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0900'-H'0907'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0908'-H'090F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0910'-H'0917'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0918'-H'091F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0920'-H'0927'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0928'-H'092F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0930'-H'0937'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0938'-H'093F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0940'-H'0947'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0948'-H'094F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0950'-H'0957'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0958'-H'095F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0960'-H'0967'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0968'-H'096F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0970'-H'0977'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0978'-H'097F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0980'-H'0987'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0988'-H'098F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0990'-H'0997'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0998'-H'099F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'09A0'-H'09A7'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'09A8'-H'09AF'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'09B0'-H'09B7'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'09B8'-H'09BF'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'09C0'-H'09C7'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'09C8'-H'09CF'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'09D0'-H'09D7'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'09D8'-H'09DF'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'09E0'-H'09E7'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'09E8'-H'09EF'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'09F0'-H'09F7'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'00DE',H'00AD',H'00BE',H'00EF',H'09FF' ; H'09F8'-H'09FF'
    ;---------------------------------------------------;
    ; H'0A00'-H'0AFF'
    ;---------------------------------------------------;
;    DW	H'0A00',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A00'-H'0A07'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A08'-H'0A0F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A10'-H'0A17'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A18'-H'0A1F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A20'-H'0A27'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A28'-H'0A2F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A30'-H'0A37'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A38'-H'0A3F'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A40'-H'0A47'
;    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A48'-H'0A4F'
    DW	                H'0A4A',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A48'-H'0A4F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A50'-H'0A57'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A58'-H'0A5F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A60'-H'0A67'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A68'-H'0A6F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A70'-H'0A77'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A78'-H'0A7F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A80'-H'0A87'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A88'-H'0A8F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A90'-H'0A97'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0A98'-H'0A9F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0AA0'-H'0AA7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0AA8'-H'0AAF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0AA8'-H'0AAF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0AB0'-H'0AB7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0AB8'-H'0ABF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0AC0'-H'0AC7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0AC8'-H'0ACF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0AD0'-H'0AD7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0AD8'-H'0ADF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0AE0'-H'0AE7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0AE8'-H'0AEF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0AF0'-H'0AF7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'00DE',H'00AD',H'00BE',H'00EF',H'0AFF' ; H'0AF8'-H'0AFF'
    ;---------------------------------------------------;
    ; H'0B00'-H'0BFF'
    ;---------------------------------------------------;
    DW	H'0B00',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B00'-H'0B07'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B08'-H'0B0F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B10'-H'0B17'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B18'-H'0B1F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B20'-H'0B27'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B28'-H'0B2F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B30'-H'0B37'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B38'-H'0B3F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B40'-H'0B47'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B48'-H'0B4F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B50'-H'0B57'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B58'-H'0B5F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B60'-H'0B67'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B68'-H'0B6F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B70'-H'0B77'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B78'-H'0B7F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B80'-H'0B87'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B88'-H'0B8F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B90'-H'0B97'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0B98'-H'0B9F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0BA0'-H'0BA7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0BA8'-H'0BAF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0BB0'-H'0BB7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0BB8'-H'0BBF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0BC0'-H'0BC7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0BC8'-H'0BCF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0BD0'-H'0BD7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0BD8'-H'0BDF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0BE0'-H'0BE7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0BE8'-H'0BEF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0BF0'-H'0BF7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'00DE',H'00AD',H'00BE',H'00EF',H'0BFF' ; H'0BF8'-H'0BFF'
    ;---------------------------------------------------;
    ; H'0C00'-H'0CFF'
    ;---------------------------------------------------;
    DW	H'0C00',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C00'-H'0C07'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C08'-H'0C0F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C10'-H'0C17'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C18'-H'0C1F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C20'-H'0C27'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C28'-H'0C2F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C30'-H'0C37'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C38'-H'0C3F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C40'-H'0C47'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C48'-H'0C4F'
    DW	H'0C50',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C50'-H'0C57'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C58'-H'0C5F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C60'-H'0C67'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C68'-H'0C6F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C70'-H'0C77'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C78'-H'0C7F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C80'-H'0C87'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C88'-H'0C8F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C90'-H'0C97'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0C98'-H'0C9F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0CA0'-H'0CA7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0CA8'-H'0CAF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0CB0'-H'0CB7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0CB8'-H'0CBF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0CC0'-H'0CC7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0CC8'-H'0CCF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0CD0'-H'0CD7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0CD8'-H'0CDF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0CE0'-H'0CE7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0CE8'-H'0CEF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0CF0'-H'0CF7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'00DE',H'00AD',H'00BE',H'00EF',H'0CFF' ; H'0CF8'-H'0CFF'
    ;---------------------------------------------------;
    ; H'0D00'-H'0DFF'
    ;---------------------------------------------------;
    DW	H'0D00',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D00'-H'0D07'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D08'-H'0D0F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D10'-H'0D17'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D18'-H'0D1F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D20'-H'0D27'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D28'-H'0D2F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D30'-H'0D37'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D38'-H'0D3F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D40'-H'0D47'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D48'-H'0D4F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D50'-H'0D57'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D58'-H'0D5F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D60'-H'0D67'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D68'-H'0D6F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D70'-H'0D77'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D78'-H'0D7F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D80'-H'0D87'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D88'-H'0D8F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D90'-H'0D97'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0D98'-H'0D9F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0DA0'-H'0DA7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0DA8'-H'0DAF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0DB0'-H'0DB7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0DB8'-H'0DBF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0DC0'-H'0DC7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0DC8'-H'0DCF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0DD0'-H'0DD7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0DD8'-H'0DDF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0DE0'-H'0DE7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0DE8'-H'0DEF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0DF0'-H'0DF7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'00DE',H'00AD',H'00BE',H'00EF',H'0DFF' ; H'0DF8'-H'0DFF'
    ;---------------------------------------------------;
    ; H'0E00'-H'0EFF'
    ;---------------------------------------------------;
    DW	H'0E00',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E00'-H'0E07'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E08'-H'0E0F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E10'-H'0E17'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E18'-H'0E1F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E20'-H'0E27'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E28'-H'0E2F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E30'-H'0E37'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E38'-H'0E3F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E40'-H'0E47'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E48'-H'0E4F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E50'-H'0E57'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E58'-H'0E5F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E60'-H'0E67'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E68'-H'0E6F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E70'-H'0E77'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E78'-H'0E7F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E80'-H'0E87'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E88'-H'0E8F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E90'-H'0E97'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0E98'-H'0E9F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0EA0'-H'0EA7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0EA8'-H'0EAF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0EB0'-H'0EB7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0EB8'-H'0EBF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0EC0'-H'0EC7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0EC8'-H'0ECF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0ED0'-H'0ED7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0ED8'-H'0EDF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0EE0'-H'0EE7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0EE8'-H'0EEF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0EF0'-H'0EF7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'00DE',H'00AD',H'00BE',H'00EF',H'0EFF' ; H'0EF8'-H'0EFF'
    ;---------------------------------------------------;
    ; H'0F00'-H'0FFF'
    ;---------------------------------------------------;
    DW	H'0F00',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F00'-H'0F07'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F08'-H'0F0F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F10'-H'0F17'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F18'-H'0F1F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F20'-H'0F27'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F28'-H'0F2F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F30'-H'0F37'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F38'-H'0F3F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F40'-H'0F47'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F48'-H'0F4F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F50'-H'0F57'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F58'-H'0F5F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F60'-H'0F67'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F68'-H'0F6F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F70'-H'0F77'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F78'-H'0F7F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F80'-H'0F87'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F88'-H'0F8F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F90'-H'0F97'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0F98'-H'0F9F'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0FA0'-H'0FA7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0FA8'-H'0FAF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0FB0'-H'0FB7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0FB8'-H'0FBF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0FC0'-H'0FC7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0FC8'-H'0FCF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0FD0'-H'0FD7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0FD8'-H'0FDF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0FE0'-H'0FE7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0FE8'-H'0FEF'
    DW	H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF',H'3FFF' ; H'0FF0'-H'0FF7'
    DW	H'3FFF',H'3FFF',H'3FFF',H'00DE',H'00AD',H'00BE',H'00EF',H'0FFF' ; H'0FF8'-H'0FFF'
    ;---------------------------------------------------;

;-------------------------------------------------------;
    END
;-------------------------------------------------------;
