		AREA 	SORT_ARRAY,CODE,READWRITE
		ENTRY
START
		ADR		R0,source_array_ROM 				
		LDR		R2,=0x40000000
		LDRB	R8,[R0],#01
		STRB	R8,[R2],#01			

FOR_COPY
		LDRB	R1,[R0],#01
		STRB	R1,[R2],#01
		SUBS	R8,R8,#01
		CMP		R8,#0
		BNE		FOR_COPY

START1	LDR		R1,=0x40000000
		LDRB	R5,[R1],#01
		SUBS	R5,R5,#01
		MOV		R7,#0
		

LOOP	LDRB	R2,[R1],#01
		LDRB	R3,[R1]
		CMP		R2,R3
		BLT		LOOP2
		STRB	R2,[R1],#-01
		STRB	R3,[R1]
		MOV		R7,#01
		ADD		R1,#01

LOOP2
		SUBS	R5,R5,#01
		CMP		R5,#0
		BNE		LOOP
		CMP		R7,#0
		BNE		START1
	
HERE	B		HERE

source_array_ROM	DCB		0x05,0x05,0x02,0x08,0x04,0x01

		END