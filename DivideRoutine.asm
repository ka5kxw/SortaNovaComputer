// I don't really have an assembler (or really an instruction set fully) defined yet, but this is a good start
// IIII MM AA AAAA AAAA
// I= Memory reference instruction
//  0000	ADD M to ACC
//	0001	SUB	M from ACC
//	0010	AND	M AND Acc
//	0011	OR	M OR Acc
//	0100	XOR	M XOR Acc
//	0101	LOAD	Acc from M
//	0110	STORE	Acc to M
//	0111	DSZ	Decrement M and skip on Zero
//	1000	SSP	Set Stack Pointer to M
//	1001	JZ	Jump to M on zero flag set
//	1010	JCS	Jump to M on carry flag set
//	1011	JP	Jump to M on positive flag set
//	1100	JN	Jump to M on negative flag set
//	1101	JMP	Jump to M
//	1110	BRA	Store PC+1 to M and Jump to M+1
//	1111	Non memory reference instructions
//
// M= 	00	Direct
// 	01	Indirect
// 	10	Zero Page
// 	11	Indexed
// A = 	10 bits representing an address [0..1023] for Direct, Indirect or Zero Page addressing 
// or an offset for Indexed addressing
// And for Implied/IN-OUT instructions
//
// I/O instructions
// 1111 I R AA AAAA AAAA

// I =	1	Input/Output Instructions
// R= 	0	Read
// 	    1	Write
// A=	Device address

// Implied Instructions
// 1111 Ixxx CCCC xxxx
//
// I=	0	Implied Instructions
// C=	0000	PUSH	Push AC to stack
//	0001	POP	Pop top of stack to Accumulator
//	0010	CC	Clear Carry
//	0011	SC	Set Carry
//	0100	MAX	Move Acc to Index
//	0101	MXA	Move Index to Acc
//	0110	INX	Increment Index
//	0111	DEX	Decrement Index
//	1000	NOP	No Operation
//	1001	SWAP	Trade Hi and Low byte of Accumulator
//	1010	ROTR	Rotate Right
//	1011	ROTL	Rotate Left
//	1100	SETA	Set Accumulator all 1’s (alternative instruction → Copy SP to ACC)
//	1101	CLRA	Clear Accumulator 
//	1110	CMP	Complement Accumulator
//	1111	INA	Increment Accumulator

// Just so I can get started, lets also define a few assembler directives
// Usage is:
//              [Label] Directive [Constant|Text|Value|Address]
// Directive    Description                              Example
// //           comment
// RW           Reserve Word                             index  RW      // reserve a memory location 
// RDW          Reserve Double Word                      Result RDW     //  reserve 2 consecutive locations at Result and Result+1 
// TEXT         Packed ASCII Text String                 Prompt TEXT 'Enter your last name' // Reserve locations starting and text and packed with ASCII characters 
// ORG          Set PC                                   ORG 0x100        // instruct the assembler to set address counter to hex 0100
// EQU          Equate                                   Start EQU 0x100  // straight text replacement of label start with 0x100. i.e. ORG Start = ORG 0x100
// DEC          Store Decimal Constant                   DEC 0            // used a lot with indirect jumps back to calling subroutine
// HEX          Store Hexadecimal Constant               HEX FFFF         // Reserve and store a hex constant
START  EQU 0x100
ORG    START
divide    DEC 0
          CLA
          POP
          STORE Dividend
          POP
          Store Divisor
divloop  CC       // Clear the carry bit
          //do stuff 16 times
          //
          //
          DSZ  divi    // 
          JMP  divloop
          LOAD Divquo
          PUSH
          LOAD divrem
          PUSH    
          JMP,I divide
          
divi      DEC 15  // loop index variable for division routine
Dividend  HEX  0  // Dividend 16 bit value (Variables will come to the routine in a stack frame)
Divisor   HEX  0  // Divisor 16 bit value
Divquo    HEX  0  // Quotient or result 16 bit value
divrem    HEX  0  // Remainder  16 bit value


