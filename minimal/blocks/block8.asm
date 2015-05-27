
 ;block 8


 db "  .( Interrupts setup ) "

 db " interrupts FORTH32 LINK   "
 db " interrupts CONTEXT !   "

 db	" ' div_by_zero @     0x 0   make_interrupt_gate  "
 db	" ' debug_int   @     0x 1   make_interrupt_gate  "
 db	" ' nmi_int     @     0x 2   make_interrupt_gate  "
 db	" ' break_int   @     0x 3   make_interrupt_gate  "
 db	" ' overflow    @     0x 4   make_interrupt_gate  "
 db	" ' bound_int   @     0x 5   make_interrupt_gate  "
 db	" ' ud_int      @     0x 6   make_interrupt_gate  "
 db	" ' nomath_int  @     0x 7   make_interrupt_gate  "
 db	" ' df_int      @     0x 8   make_interrupt_gate  "
 db	" ' mf_int      @     0x 9   make_interrupt_gate  "
 db	" ' tss_int     @     0x A   make_interrupt_gate  "
 db	" ' np_int      @     0x B   make_interrupt_gate  "
 db	" ' ss_int      @     0x C   make_interrupt_gate  "
 db	" ' gp_int      @     0x D   make_interrupt_gate  "
 db	" ' pf_int      @     0x E   make_interrupt_gate  "

 db	" ' mf_int      @     0x 10  make_interrupt_gate  "
 db	" ' ac_int      @     0x 11  make_interrupt_gate  "
 db	" ' mc_int      @     0x 12  make_interrupt_gate  "
 db	" ' xm_int      @     0x 13  make_interrupt_gate  "
; db	 " ' xm_int	 @     0x 14  make_interrupt_gate  "

 db	" ' key_int     @     0x 21  make_interrupt_gate  "

 db " FORTH32 CONTEXT ! FORTH32 CURRENT ! "



 db " WORD: CHAR      PARSE HERE 1+ C@  ;WORD "
 db " WORD: B,        HERE C! [ ' HERE CELL+ LIT, ] @ 1+ [ ' HERE CELL+ LIT, ] ! ;WORD "
 db " WORD: b,        1+ DUP C@ DUP HEX.  B, ;WORD  "

 db " WORD: CHAR,     CHAR B, ;WORD "


 db " WORD: CHARs,    Begin   CHAR  B,   1-   DUP  0x_as_lit, 0   =  Until    Pop     ;WORD "

 db " ASSEMBLER CONTEXT ! ASSEMBLER FORTH32 LINK  "
 db " FORTH32 CURRENT !  "



 db " VARIABLE numkys "
 db "  0x 18 CHARs, 1 2 3 4 5 6 7 8 9 0 - =  ! @ # $ % ^ & * ( ) _ +  "
 db " VARIABLE numky1 "
 db "  0x  4 CHARs, [ ] { } "
 db " VARIABLE numky2 "
 db "  0x  4 CHARs, ; ' `   : QUOTE B, CHAR, ~  "
 db " VARIABLE numky3 "
 db "  0x  2 CHARs, \ | "
 db " VARIABLE numky4 "
 db "  0x  6 CHARs, , . / < > ? "
 db " VARIABLE space_ "
 db "  0x 20  B, "
 db " VARIABLE qwerty  "
 db "  0x 14 CHARs, q w e r t y u i o p  Q W E R T Y U I O P " ; F - tab, 1C - Enter
 db " VARIABLE asdfgh  "
 db "  0x 12 CHARs, a s d f g h j k l    A S D F G H J K L "
 db " VARIABLE zxcvbn  "
 db "  0x  E CHARs, z x c v b n m        Z X C V B N M  "

		    ;

 db " ALIGN     "

 db " HEADER KEY        HERE CELL+ , "
 db " mov_d[],#  key  , 0x 0 ,    "
 db " backward< "
 db " hlt       "
 db " cmp_d[],#  key , 0x 0 , "
 db " je <backward  "
 db " mov_eax,[]  key  , "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret "

 db " ALIGN      "

 db " HEADER upper_shift_only   HERE CELL+ , "
 db " movsx_eax,b[] key_flags 1+ ,    "
 ;db " mov_eax,[] key_flags , "
 ;db " mov_eax,# key_flags ,	  "
 ;db " inc_eax	 "
 ;db " movsx_eax,b[eax]       "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret "

 db " ALIGN      "

 db " HEADER upper_shift_caps   HERE CELL+ , "
 db " movsx_eax,b[] key_flags 1+ ,    "
 db " movsx_ebx,b[] key_flags  ,    "
 db " xor_eax,ebx   "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret "

 db " ALIGN      "



 db " FORTH32 CONTEXT ! FORTH32 CURRENT ! "
 db " EXIT "

db     0
 alignhe20