# f-os
FORTH OS loading and developing from it's one source code. 
Baremetal Forth-like system.
Running in 32-bit PM.
Goal: make kernel with minimal set of forth words, wich afford to load and deploy the rest of system from source code.

Real-mode version includes built-in editor and symplest assembler.
PM and 64-bit versions at stage of development of the concept.

Difference wint traditional Forths:

1) Symplest interpretator.
1.1) No STATE
1.2) No compilation mode
1.3) No immediates (no IMMEDIATE flag in counter)
1.4) No automatic numbers
2) Number translation withdrawn from interpretator to special word 0x - interpret next word as hex number.
...
3) some else
