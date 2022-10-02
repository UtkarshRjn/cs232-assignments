		AREA 	SHUNTING_YARD_ALGO,CODE,READWRITE
		ENTRY
INIT
		ADR		R0,source_array_ROM 				
		LDR		R2,=0x40000000		; value stack
		LDR		R3,=0x50000000		; operator stack
		LDRB	R8,[R0],#01
		MOV		R10,#0

START	
		LDRB	R1,[R0],#1
		SUBS	R8,R8,#01
		CMP		R8,#-1
		BEQ		OP_STACK_EMPTY_LOOP	
		
		CMP		R1,#9
		ITT		LE
		STRBLE	R1,[R2],#1
		BLE		START
		
		CMP		R1,#14
		ITT		EQ
		STRBEQ	R1,[R3],#1
		BEQ		START
		
		CMP		R1,#15
		BEQ		LEFT_P_LOOP
		
		CMP		R1,#9
		STRBGT	R1,[R3],#1
		
		B		START
		
LEFT_P_LOOP
		SUBS	R3,R3,#1
		LDRB	R1,[R3]
		CMP		R1,#14			; compare the operator at the top with left paranthese
		BEQ		START
		SUBS	R2,R2,#1
		LDRB	R4,[R2]
		SUBS	R2,R2,#1
		LDRB	R5,[R2]
		
		; performs the arithmetic operation and store the result in R6
		CMP		R1,#10
		ADDEQ	R6,R4,R5
		CMP		R1,#11
		SUBEQ	R6,R5,R4
		CMP		R1,#12
		MULEQ	R6,R4,R5
		CMP		R1,#13
		MOVEQ	R6,#0
		BEQ		DIVIDE1	
AFTER_DIVIDE1
		
		STRB	R6,[R2],#1
		B		LEFT_P_LOOP

DIVIDE1
		CMP		R5,R4
		ITTT	GE
		SUBGE	R5,R5,R4
		ADDGE	R6,R6,#1
		BGE		DIVIDE1
		B		AFTER_DIVIDE1
		
DIVIDE2
		CMP		R5,R4
		ITTT	GE
		SUBGE	R5,R5,R4
		ADDGE	R6,R6,#1
		BGE		DIVIDE2
		B		AFTER_DIVIDE2

OP_STACK_EMPTY_LOOP	
		CMP		R3,#0x50000001
		MOVEQ	R10,#1	
		SUBS	R3,R3,#1
		LDRB	R1,[R3]
		SUBS	R2,R2,#1
		LDRB	R4,[R2]
		SUBS	R2,R2,#1
		LDRB	R5,[R2]
		
		; performs the arithmetic operation and store the result in R6
		CMP		R1,#10
		ADDEQ	R6,R4,R5
		CMP		R1,#11
		SUBEQ	R6,R5,R4
		CMP		R1,#12
		MULEQ	R6,R4,R5
		CMP		R1,#13
		MOVEQ	R6,#0
		BEQ		DIVIDE2	
AFTER_DIVIDE2
		
		STRB	R6,[R2],#1
		CMP		R10,#1
		BNE		OP_STACK_EMPTY_LOOP

HERE	B		HERE

source_array_ROM	DCB		0x0B,0x09,0x0C,0x0E,0x0E,0x02,0x0A,0x08,0x0F,0x0D,0x02,0x0F  	; 9 * (( 2 + 8 ) / 2 )
;	+ -> 10 , - -> 11 , * -> 12 , / -> 13 , ( -> 14 , ) -> 15

		END