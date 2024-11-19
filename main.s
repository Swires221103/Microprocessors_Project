#include <xc.inc>

 

extrn	UART_Setup, UART_Transmit_Message  ; external subroutines
extrn   LCD_Setup, LCD_Write_Message, LCD_Clear, LCD_delay_ms
extrn   Keypad_Setup, Keypad_Read

psect   code, abs          

rst:	org 0x0
        goto	setup

 

                ; ******* Programme FLASH read Setup Code ***********************
setup:  bcf     CFGS   ; point to Flash program memory 
        bsf     EEPGD                 ; access Flash program memory
                ;call       UART_Setup     ; setup UART
                ;call       LCD_Setup        ; setup UART
        call	Keypad_Setup
        goto    start

               

                ; ******* Main programme ****************************************
start:
	call    Keypad_Read        
	goto    setup