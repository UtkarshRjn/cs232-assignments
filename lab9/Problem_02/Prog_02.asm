		AREA 	SHUNTING_YARD_ALGO,CODE,READWRITE
		ENTRY
INIT
		ADR		R0,source_array_ROM 				
		LDR		R2,=0x40000000		; value stack
		LDR		R3,=0x50000000		; operator stack
		LDRB	R8,[R0],#01
		MOV		R10,#0

START	
		

HERE	B		HERE

source_array_ROM	DCB		
		END