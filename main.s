	#include <xc.inc>

psect	code, abs
	
main:
	org	0x0
	goto	start

	org	0x100		    ; Main code starts here at address 0x100
start:
	movlw 	0x0
	movwf	TRISC, A	    ; Port C all outputs
	movlw	0xff
	movwf	TRISD, A
	movlw	0x0
	movwf	0x6, A
	btfsc	PORTD, 0, A
	bra	loop1
	btfsc	PORTD, 1, A
	bra	loop2
	goto	start
	
loop1:
	movff 	0x06, PORTC
	incf 	0x06, W, A
test1:
	movwf	0x06, A		    ; Test for end of loop condition
	movlw 	0x30
	cpfsgt 	0x06, A
	bra 	loop1		    ; Not yet finished goto start of loop again
	goto 	0x0		    ; Re-run program from start
loop2:
	movff 	0x06, PORTC
	incf 	0x06, W, A
test2:
	movwf	0x06, A		    ; Test for end of loop condition
	movlw 	0x20
	cpfsgt 	0x06, A
	bra 	loop2		    ; Not yet finished goto start of loop again
	goto 	0x0		    ; Re-run program from start

	end	main
