TYPEZ   									
0x 2 LOAD 		 						
0x 3 LOAD  	0x 5 LOAD 							
TIMER@  2HEX.  							

0x 4 LOAD    								

S" Test of type "  1+ TYPEZ

.( WORD:) WORD:  nnb    HERE HEX.  0x_as_lit, 333777  HEX.   TIMER@ 2HEX.   ;WORD
HERE HEX. nnb
TIMER@ 2HEX. 								
EXIT 										
