.( Interrupts setup ) 

interrupts FORTH32 LINK   
interrupts CONTEXT !   

' div_by_zero @     0x 0   make_interrupt_gate  
' debug_int   @     0x 1   make_interrupt_gate  
' nmi_int     @     0x 2   make_interrupt_gate  
' break_int   @     0x 3   make_interrupt_gate  
' overflow    @     0x 4   make_interrupt_gate  
' bound_int   @     0x 5   make_interrupt_gate  
' ud_int      @     0x 6   make_interrupt_gate  
' nomath_int  @     0x 7   make_interrupt_gate  
' df_int      @     0x 8   make_interrupt_gate  
' mf_int      @     0x 9   make_interrupt_gate  
' tss_int     @     0x A   make_interrupt_gate  
' np_int      @     0x B   make_interrupt_gate  
' ss_int      @     0x C   make_interrupt_gate  
' gp_int      @     0x D   make_interrupt_gate  
' pf_int      @     0x E   make_interrupt_gate  

' mf_int      @     0x 10  make_interrupt_gate  
' ac_int      @     0x 11  make_interrupt_gate  
' mc_int      @     0x 12  make_interrupt_gate  
' xm_int      @     0x 13  make_interrupt_gate  
' xm_int      @     0x 14  make_interrupt_gate  

' key_int     @     0x 21  make_interrupt_gate  

FORTH32 CONTEXT ! FORTH32 CURRENT ! 


WORD: CHAR      PARSE HERE 1+ C@  ;WORD 
WORD: B,        HERE C! [ ' HERE CELL+ LIT, ] @ 1+ [ ' HERE CELL+ LIT, ] ! ;WORD 
WORD: b,        1+ DUP C@ DUP HEX.  B, ;WORD  

WORD: CHAR,     CHAR B, ;WORD 


WORD: CHARs,    Begin   CHAR  B,   1-   DUP  0x_as_lit, 0   =  Until    Pop     ;WORD 

ASSEMBLER CONTEXT ! ASSEMBLER FORTH32 LINK  
FORTH32 CURRENT !  



VARIABLE numkys 
0x 18 CHARs, 1 2 3 4 5 6 7 8 9 0 - =  ! @ # $ % ^ & * ( ) _ +  
VARIABLE numky1 
0x  4 CHARs, [ ] { } 
VARIABLE numky2 
0x  4 CHARs, ; ' `   : QUOTE B, CHAR, ~  
VARIABLE numky3 
0x  2 CHARs, \ | 
VARIABLE numky4 
0x  6 CHARs, , . / < > ? 
VARIABLE space_ 
0x 20  B, 
VARIABLE qwerty  
0x 14 CHARs, q w e r t y u i o p  Q W E R T Y U I O P 
VARIABLE asdfgh  
0x 12 CHARs, a s d f g h j k l    A S D F G H J K L 
VARIABLE zxcvbn  
0x  E CHARs, z x c v b n m        Z X C V B N M  


 ALIGN     

 HEADER KEY        HERE CELL+ , 
 mov_d[],#  key  , 0x 0 ,    
 backward< 
 hlt       
 cmp_d[],#  key , 0x 0 , 
 je <backward  
 mov_eax,[]  key  , 
 mov_edx,#  ' Push @ ,   call_edx            
 ret 

 ALIGN      

 HEADER upper_shift_only   HERE CELL+ , 
 movsx_eax,b[] key_flags 1+ ,    
 mov_edx,#  ' Push @ ,   call_edx            
 ret 

 ALIGN      

 HEADER upper_shift_caps   HERE CELL+ , 
 movsx_eax,b[] key_flags 1+ ,    
 movsx_ebx,b[] key_flags  ,    
 xor_eax,ebx   
 mov_edx,#  ' Push @ ,   call_edx            
 ret 

 ALIGN    



 FORTH32 CONTEXT ! FORTH32 CURRENT 
 EXIT
