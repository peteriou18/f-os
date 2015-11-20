
 ;block 9 
; pause KEY upper_shift_only upper_shft_caps 
; 2@ EMIT CRLF CR SPACE (bHEX) (wHEX) 2HEX. HEX. bHEX. wHEX. (dump) DUMP
; frame fix_frame 1st 2nd 2rd 4th 5th 1st+ 2nd+ 



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
 db	" ' pit_int     @     0x 20  make_interrupt_gate  "
 db	" ' key_int     @     0x 21  make_interrupt_gate  "
 db	" ' slave_int   @     0x 22  make_interrupt_gate  "
 db	" ' rtc_int     @     0x 28  make_interrupt_gate  "
 db " FORTH32 CONTEXT ! FORTH32 CURRENT ! "




 db " ASSEMBLER CONTEXT ! ASSEMBLER FORTH32 LINK  "
 db " FORTH32 CURRENT !  "

 db " ALIGN "
 ;
 db " HEADER pause       HERE CELL+ , "
 db " mov_edx,# ' Pop @ ,   call_edx              "
 db " mov_[],eax pit_interval , "
 db " backward<   "
 db " hlt         "
 db " mov_eax,[] pit_interval , "
 db " test_eax,eax            "
 db " jne   <backward         "
 db " ret                     "


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

 db " FORTH32 CONTEXT ! "

 db " WORD: 2@   >R R@ @ R> CELL+ @ ;WORD "

 db " WORD: EMIT      SP@ TYPEZ Pop            ;WORD "
 db " WORD: CRLF      hex, 0D0A EMIT           ;WORD "
 db " WORD: CR        hex, 0D   EMIT           ;WORD "
 db " WORD: SPACE     BL EMIT                  ;WORD "

 db " WORD: (bHEX)     @ hex, ffff AND (swap_ab)  ;WORD "
 db " WORD: (wHEX)    DUP  1+ 1+ (bHEX)  >R  (bHEX)  R>   ;WORD "

 db " WORD: 2HEX.        (hex_pop2)    (hex_pop)    (hex_convert)    inverse_hexstr    hexstr    TYPEZ  ;WORD "
 db " WORD: HEX.         (clear_hex)   (hex_pop)    (hex_convert)    inverse_hexstr    hexstr    CELL+  CELL+  TYPEZ 

 ;WORD "

 db " WORD: bHEX.        (clear_hex)  (hex_pop) (hex_convert) hexstr (bHEX) EMIT SPACE ;WORD "
 db " WORD: wHEX.        (clear_hex)  (hex_pop) (hex_convert) hexstr (wHEX) EMIT EMIT SPACE ;WORD "

 db " WORD: (dump)   0 hex, 10 Do hexstr R@ + (bHEX) EMIT SPACE R> 1+ >R Loop  ;WORD "

 db ' WORD: DUMP   CRLF DUP 2@ (hex_pop2) (hex_pop) (hex_convert) (dump) ." - "  CELL+ CELL+ 2@ 

(hex_pop2) (hex_pop) (hex_convert) (dump) ;WORD '


 db " VARIABLE frame "
 db " WORD: fix_frame   SP@ frame !                 ;WORD "
 db " WORD: 1st         frame @ @                   ;WORD "
 db " WORD: 2nd         frame @ CELL- @             ;WORD "
 db " WORD: 3rd         frame @ CELL- CELL- @       ;WORD "
 db " WORD: 4th         frame @ CELL- CELL- CELL- @ ;WORD "
 db " WORD: 5th         frame @ hex, 5 - @          ;WORD "
 db " WORD: 1st+        1st + frame @ !             ;WORD "
 db " WORD: 2nd+        2nd + frame @ CELL- !       ;WORD "

 db " FORTH32 CONTEXT ! FORTH32 CURRENT ! "
 db " EXIT "

db     0
 alignhe20
