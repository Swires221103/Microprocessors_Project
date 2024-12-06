#include <xc.inc>


; Defining the PIR sensor pins
UP_sensor    EQU 0     ; RB0 - Up sensor
DOWN_sensor  EQU 1     ; RB1 - Down sensor
LEFT_sensor  EQU 2     ; RB2 - Left sensor
RIGHT_sensor EQU 3     ; RB3 - Right sensor


psect   udata_acs
UD_result:	ds  1
LR_result:	ds  1
    
    
global	Init_ports, Check_UD_axis, Check_LR_axis
    

Init_ports:
    clrf	PORTB, A
    movlw	0x0F          ; Set RB0-RB3 as inputs (1 = input)
    movwf	TRISB, A         ; Apply to TRISB
    RETURN

    
Check_UD_axis:
    clrf	UD_result, A      ; Clear previous result for Up/Down
    btfsc	PORTB, UP_sensor, A  ; If UP_SENSOR is high
    goto	Check_down_high
    goto	Check_down_low

Check_down_low:
    btfsc	PORTB, DOWN_sensor, A ; If DOWN_SENSOR is high
    goto	DOWN_condition_met
    RETURN                 ; If both are low, return

Check_down_high:
    btfss	PORTB, DOWN_sensor, A ; If DOWN_SENSOR is low
    goto	UP_condition_met
    RETURN                 ; If both are high, return

UP_condition_met:
    movlw	0x01              ; Set result for Up/Down axis
    movwf	UD_result, A         ; Store result in UD_RESULT
    RETURN
    
DOWN_condition_met:
    movlw	0xff              ; Set result for Up/Down axis
    movwf	UD_result, A         ; Store result in UD_RESULT
    RETURN
    
    
    
Check_LR_axis:
    clrf	LR_result, A          ; Clear previous result for Left/Right
    btfsc	PORTB, LEFT_sensor, A ; If LEFT_SENSOR is high
    goto	Check_right_high
    goto	Check_right_low
    
Check_right_low:
    btfsc	PORTB, RIGHT_sensor, A ; If RIGHT_SENSOR is high
    goto	RIGHT_condition_met
    RETURN                  ; If both are low, return

Check_right_high:
    btfss	PORTB, RIGHT_sensor, A ; If RIGHT_SENSOR is low
    goto	LEFT_condition_met
    RETURN                  ; If both are high, return

LEFT_condition_met:
    movlw	0xff              ; Set result for Left/Right axis
    movwf	LR_result, A         ; Store result in LR_RESULT
    RETURN
    
RIGHT_condition_met:
    movlw	0x01              ; Set result for Left/Right axis
    movwf	LR_result, A         ; Store result in LR_RESULT
    RETURN
    

END  
 