#include <xc.inc>

global	Keypad_Setup, Keypad_Read

psect	udata_acs   ; named variables in access ram
Keypad_Column:	ds 1   ; reserve 1 byte for variable Keypad Column
Keypad_Row:	ds 1   ; reserve 1 byte for variable Keypad Row
Key_cnt_out:	ds 1   ; reserve 1 byte for variable Keypad outer counter
Key_cnt_in:	ds 1
Key_prsd:	ds 1

psect	keypad_code,class=CODE

Keypad_Setup:
    clrf    PORTE, A
    movlw   0xFF
    movwf   TRISE, A
    clrf    LATE, A
    movlw   0xF
    movwf   BSR
    bsf	    PADCFG1, 6
    
    clrf    LATJ
    clrf    TRISJ
    
    return
        
Keypad_Read:
    movlw   0x0F
    movwf   TRISE, A
    movff   PORTE, Keypad_Row, A
    movlw   0xF0
    movwf   TRISE, A
    movff   PORTE, Keypad_Column, A
    
    movf    Keypad_Row, W, A
    iorwf   Keypad_Column, W, A
;    movwf   Key_prsd
    movwf   LATJ    
    return
    
Keypad_Decode:
    

    
    
Keypad_delay:		    ; delay subroutine
	movlw	250
	movwf	Key_cnt_out
	movwf	Key_cnt_in
lp1:
	decfsz	Key_cnt_out
	bra	lp2
	return
lp2:	
	decfsz	Key_cnt_in
	bra lp2
	bra lp1
	
    
	


