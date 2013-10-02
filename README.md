f-os
====

FORTH OS loading and developing from it's one source code. 

Concept.

Forth system loading fron any device. (Now from flash). Load makes from source code. 
Code of system mixed. Low-level code mixed with high-level code. 
You could work both level simultaneously.

Included screen editor, blocks fylesystem.

Loader aka Block 0 (zero) written by fasm. 
Block 0 contain master boot record, kernel, base vocabulary.
All the rest deployng from source code.


Non standart words.

0x  - input hex number, put it on stack
0x, - input hex number, compile lit-code, compile hex value. Immediate. 
HEX. - print value from top of stack as hex.
HEXa - put 8 bytes on address from stack
BIN: - set next words as low-level word. 
opcode - create opcode word. get n dwords from stack and compile it as bytes to code segment
code_top - address of value of first free byte in code segment
label - get value from stack, create word with execution semantic: calculate and compile value to code segment



