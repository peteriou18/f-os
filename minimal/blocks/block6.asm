
 ;block 6
 db " FORTH32 CURRENT !  "

 db " VARIABLE key     "
 db " VARIABLE key_flags "
 db " VARIABLE idtr 0 , "
 db " VOCABULARY interrupts "



 db " ASSEMBLER CONTEXT ! ASSEMBLER FORTH32 LINK  "

 db " WORD: forward>   HERE  0 ,   HERE        ;WORD "
 db " WORD: >forward   HERE  SWAP- SWAP!       ;WORD "
 db " WORD: backward<  HERE    ;WORD "
 db " WORD: <backward  HERE CELL+ -  ,         ;WORD "

 db " ASSEMBLER  FORTH32 LINK  "

 db " HEADER make_interrupt_gate        HERE CELL+ ,   "
 db " mov_edx,# ' Pop @ ,   call_edx              " ;Interrupt No
 db " mov_ecx,eax "
 db " sidt_[]  idtr  , "
 db " mov_edi,[]  idtr  0x 2 +  ,   "
 db " shl_ecx,3         "
 db " add_edi,ecx       "
 db " call_edx          "      ; link to handler
 db " push_eax          "
 db " stosw             "
 db " mov_eax,# 0x 8 ,          "
 db " stosw             "
 db " mov_eax,# 0x 8E00 , "
 db " stosw     "
 db " pop_eax   "
 db " shr_eax,16        "
 db " stosw             "

 db "        "
 db " ret "

 db " ALIGN      "

 db "  interrupts CURRENT !  interrupts ASSEMBLER LINK  interrupts CONTEXT ! "

  db ' WORD: by_0_msg      ." Divide by zero:"            ;WORD '
  db ' WORD: debug_msg     ." Debug:"                     ;WORD '
  db ' WORD: nmi_msg       ." NMI"                        ;WORD '
  db ' WORD: break_msg     ." BREAKPOINT"                 ;WORD '
  db ' WORD: overflow_msg  ." Overflow"                   ;WORD '
  db ' WORD: bound_msg     ." Bound exception"            ;WORD '
  db ' WORD: ud_msg        HEX. ." Invalid opcode"             ;WORD '
  db ' WORD: nomath_msg    ." No Math exception"          ;WORD '
  db ' WORD: df_msg        ." Double fault"               ;WORD '
  db ' WORD: mf_msg        ." Coprocessor segment fault"  ;WORD '
  db ' WORD: tss_msg       ." Invalid TSS"                ;WORD '
  db ' WORD: np_msg        ." Segment not present"        ;WORD '
  db ' WORD: ss_msg        ." Stack segment fault"        ;WORD '
  db ' WORD: gp_msg        ." General protection"         ;WORD '
  db ' WORD: pf_msg        ." Page fault"                 ;WORD '

  db ' WORD: mf_msg        ." Floating point error"       ;WORD '
  db ' WORD: ac_msg        ." Alignment check"            ;WORD '
  db ' WORD: mc_msg        ." Machine check"              ;WORD '
  db ' WORD: xm_msg        ." SIMD FP exception"          ;WORD '

 db " HEADER div_by_zero      HERE CELL+ , "
 db " mov_eax,# '  by_0_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN      "

 db " HEADER debug_int   HERE CELL+ , "
 db " mov_eax,# '  debug_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN      "

 db " HEADER nmi_int   HERE CELL+ , "
 db " mov_eax,# '  debug_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN  "

 db " HEADER break_int HERE CELL+ , "
 db " mov_eax,# '  break_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN      "

 db " HEADER overflow HERE CELL+ , "
 db " mov_eax,# '  overflow_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN      "

 db " HEADER bound_int HERE CELL+ , "
 db " mov_eax,# '  bound_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN      "

 db " HEADER ud_int HERE CELL+ , "
 db " mov_eax,[esp] "
 db " mov_edx,# ' Push @ ,   call_edx "
 db " mov_eax,# ' ud_msg , "
 db " call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "

 db " hlt iretd "

 db " ALIGN  "

 db " HEADER nomath_int HERE CELL+ , "
 db " mov_eax,# ' nomath_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN      "

 db " HEADER df_int HERE CELL+ , "
 db " mov_eax,# ' df_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN  "

 db " HEADER mf_int HERE CELL+ , "
 db " mov_eax,# ' mf_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN      "

 db " HEADER tss_int HERE CELL+ , "
 db " mov_eax,# ' tss_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN  "

 db " HEADER np_int HERE CELL+ , "
 db " mov_eax,# ' np_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN  "

 db " HEADER ss_int HERE CELL+ , "
 db " mov_eax,# ' ss_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN  "

 db " HEADER gp_int HERE CELL+ , "
 db " mov_eax,# ' gp_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN   "


 db " HEADER pf_int HERE CELL+ , "
 db " mov_eax,# ' pf_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN      "


 db " HEADER mf_int HERE CELL+ , "
 db " mov_eax,# ' mf_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN      "

 db " HEADER ac_int HERE CELL+ , "
 db " mov_eax,# ' ac_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN      "

 db " HEADER mc_int HERE CELL+ , "
 db " mov_eax,# ' mc_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN      "

 db " HEADER xm_int HERE CELL+ , "
 db " mov_eax,# ' xm_msg , "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " iretd "

 db " ALIGN      "


 db " HEADER key_int    HERE  CELL+  , "
 db " pushad "
 db " xor_eax,eax "
 db " in_al,60h "
 db " cmp_eax,# 0x 58 , "  ;F12
 db " je  forward> "
 db " cmp_eax,# 0x 3A , "  ;CAPS
 db " je forward> "
 db " cmp_eax,# 0x 2A , "
 db " je forward> "
 db " cmp_eax,# 0x AA  , "
 db " je forward> "
 db " cmp_eax,# 0x 36  , "
 db " je forward> "
 db " cmp_eax,# 0x B6  , "
 db " je forward> "
 db " cmp_eax,# 0x BA  , "
 db " je forward> "
 db " test_eax,# 0x 80 , "
 db " jne forward> "
 db " mov_[],eax  key , "
 db " >forward "
 db " add_[],eax 0x B8000 ,  "
 db " eoi "
 db " popad "
 db " iretd "

 db " >forward "
 db " eoi "
 db " popad "
 db " iretd "

 db " >forward "
 db " and_d[],# key_flags ,  0x FFFC00FF  , "
 db " eoi "
 db " popad "
 db " iretd "

 db " >forward "
 db " or_d[],# key_flags , 0x 1FF00 , "
 db " eoi "
 db " popad "
 db " iretd "


 db " >forward "
 db " and_d[],# key_flags ,  0x FFFC00FF  , "
 db " eoi "
 db " popad "
 db " iretd "


 db " >forward "
 db " or_d[],# key_flags , 0x 2FF00 , "
 db " eoi "
 db " popad "
 db " iretd "


 db " >forward "
 db " xor_d[],# key_flags , 0x FF , "
 db " eoi "
 db " popad "
 db " iretd "


 db "  >forward "
 db " backward< DUP "
 db " in_al,64h "
 db " test_eax,# 0x 2 , "
 db " jne <backward "
 db " mov_eax,# 0x FE , "
 db " out_64h,al "
 db " jmp <backward  "

 db " ALIGN      "


 db " FORTH32 CONTEXT ! FORTH32 CURRENT ! "

 db     0
 alignhe20
