		AREA 	DIJKSTRA_ALGO,CODE,READWRITE
		ENTRY
START
		ADR		R0,N
		ADR		R1,Node
		ADR		R2,ADJACENCY_MATRIX
		LDR		R3,=0x30000000		; for number of nodes
		LDR		R4,=0x40000000		; for source node
		LDR		R6,=0x60000000		; for the location of adjacent list
		LDR		R7,=0x70000000		; for the final list of shortest distance
		LDR		R9,=0x90000000		; for the visited array storage
		LDRB	R5,[R0]				; copy the number of nodes from R0 to 0x30000000
		STRB	R5,[R3]
		LDRB	R0,[R1]				; copy the number of nodes from R1 to 0x40000000
		STRB	R0,[R4]				
		MUL		R8,R5,R5			; multiply the n values to get the size of adjacent list

FOR_COPY
		LDRB	R0,[R2],#01			; copying the adjacency list to 0x60000000
		STRB	R0,[R6],#01			
		SUBS	R8,R8,#01			
		CMP		R8,#0				
		BNE		FOR_COPY			
		; R8,R1,R0,R2 are free
			
		MOV		R1,R7				
FOR_INIT
		LDR		R0,=0xFF			; storing infinity as initial distance form the source
		STRB	R0,[R1],#01
		MOV		R9,#01				; Adding all vertex to the array Q as non-visited
		ADD		R9,#01
		SUBS	R5,R5,#01
		CMP		R5,#0		
		BNE		FOR_INIT		
		LDR		R0,=0x00			; updating the value of dist(source) in this array to 0
		LDR		R2,[R4]				
		STRB	R0,[R7,R2]
		; R0,R8,R2,R5,R1 are free	
		
MAIN_LOOP
		MOV		R1,R7				; Selects the required u such that it is in u and has smallest distance
		LDRB	R0,[R1],#01
		LDRB	R5,[R3]
		MOV		R8,R9

CHECK_LOOP
		CMP		R8,#0
		ITT		NE
		LDRBNE	R5,[R3]
		SUBNE	R5,R5,#01
		BNE		LOOP
		ADD		R8,#1
		SUBS	R5,#1
		CMP		R5,#0
		BNE		CHECK_LOOP
		B		HERE
		
LOOP
		LDRB	R2,[R1],#01
		SUBS	R5,R5,#01
		CMP		R0,R2
		IT		GT
		MOVGT	R0,R2
		CMP		R5,#0
		BNE		LOOP
		CMP		[R9,R0],#1
		ITE		NE
		BNE		MAIN_LOOP
		MOVNE	[R9,R0],#0
		; R0 contains the u so is not free here
		; R1,R2,R5,R8 free

		LDRB	R8,[R3]
		MUL 	R8,R0,R8			; Contains N*u to help shift in location 0x60000000 
		LDRB	R0,[R7,R0]			; R0 contains dist(u)
		LDRB	R2,[R6,R8]			; R2 points at the adjacency list of vertex u
		LDRB	R5,[R3]
		MOV		R1,R7				; R8 free at this location
		MOV		R8,R9
		MOV		R12,#0
LOOP2					
		CMP		R5,#0
		BEQ		MAIN_LOOP
		
		ADD		R10,R0,R2
		MOV		R11,R1
		ADD		R2,#1
		ADD		R1,#1
		ADD		R8,#1
				
		CMP		[R8,#-1],#0
		ITT		EQ
		SUBEQ	R5,#01
		ADDEQ	R12,#01
		BEQ		LOOP2
		
		CMP		R10,R11
		MOVLE	[R7,R12],R10 
		SUBS	R5,#01
		ADD		R12,#01
		B		LOOP2				

HERE	B		HERE

N	DCB		0x06
ADJACENCY_MATRIX	DCB		0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x03, 0x00, 0x05, 0x01, 0x00, 0x00, 0x03, 0x04, 0x00, 0x00, 0x03, 0x03, 0x00, 0x00, 0x01, 0x00, 0x00, 0x04, 0x00, 0x00, 0x02, 0x00, 0x05, 0x00, 0x01, 0x02, 0x00  
Node	DCB		0x00

		END