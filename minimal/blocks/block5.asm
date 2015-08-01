; block 5   CELL-  hex_dot_value sixes efes sevens zeroes hexstr inverse_hexstr (hex_dot)
 ;   2HEX.  HEX. - SWAP- +  TIMER@  lit# 1+ 1- 2* 2/ C@ C! ALLOT SLIT  DUP >R R> R@ SWAP!
 db " FORTH32 CURRENT ! ASSEMBLER CONTEXT !    "

 db " HEADER  CELL-     HERE CELL+ ,             "
 db " mov_edx,#  ' Pop @ , call_edx            "
 db " sub_eax,4                                "
 db " mov_edx,#  ' Push @ ,   call_edx         "
 db " ret                                      "


 db " HEADER   hex_dot_value  variable#  , 0xd 0 , , 0xd 0 , ,                                  "
 db " HEADER   sixes          variable#  , 0xd 0606060606060606 , , 0xd   0606060606060606 , ,  "
 db " HEADER   efes           variable#  , 0xd 0F0F0F0F0F0F0F0F , , 0xd   0F0F0F0F0F0F0F0F , ,  "
 db " HEADER   sevens         variable#  , 0xd 0707070707070707 , , 0xd   0707070707070707 , ,  "
 db " HEADER   zeroes         variable#  , 0xd 3030303030303030 , , 0xd   3030303030303030 , ,  "
 db " HEADER   hexstr         variable#  , 0xd 3332323536394143 , , 0xd 20 , , 0x 20 ,            "

 db " ASSEMBLER FORTH32 LINK                           "

 db " HEADER    inverse_hexstr  HERE CELL+ ,           "
 db " mov_eax,[] hexstr ,                              "
 db " mov_ebx,[] hexstr CELL+ ,                        "
 db " mov_ecx,[] hexstr CELL+ CELL+ ,                  "
 db " mov_edx,[] hexstr CELL+ CELL+ CELL+ ,            "
 db " bswap_eax  bswap_ebx    bswap_ecx   bswap_edx    "
 db " mov_[],edx hexstr ,                              "
 db " mov_[],ecx hexstr CELL+ ,                        "
 db " mov_[],ebx hexstr CELL+ CELL+ ,                  "
 db " mov_[],eax hexstr CELL+ CELL+ CELL+ ,            "
 db " ret                                              "

 db " ALIGN                                            "

 db " HEADER (hex_dot) HERE CELL+ ,                    "

 db " mov_edx,#  ' Pop @ ,                             "
 db " call_edx                                                                                                                                                                  "
 db " mov_[],eax   hex_dot_value  ,                    "
 db " movdqu_xmm0,[]   hex_dot_value  ,                "
 db " pxor_xmm1,xmm1                                   "
 db " punpcklbw_xmm0,xmm1                              "
 db " movdqa_xmm1,xmm0                                 "
 db " movdqu_xmm2,[] efes ,                            "
 db " pand_xmm1,xmm2                                   "
 db " psllq_xmm0,4                                     "
 db " pand_xmm0,xmm2                                   "
 db " por_xmm0,xmm1                                    "
 db " movdqa_xmm1,xmm0                                 "
 db " movdqu_xmm4,[] sixes ,                           "
 db " paddb_xmm1,xmm4                                  "
 db " psrlq_xmm1,4                                     "
 db " pand_xmm1,xmm2                                   "
 db " pxor_xmm3,xmm3                                   "
 db " psubb_xmm3,xmm1                                  "
 db " movdqu_xmm2,[] sevens ,                          "
 db " pand_xmm3,xmm2                                   "
 db " paddb_xmm0,xmm3                                  "
 db " movdqu_xmm2,[] zeroes ,                     "
 db " paddb_xmm0,xmm2                                  "
 db " movdqu_[],xmm0 hexstr ,                   "
 db " ret                                              "

 db " ALIGN                                           "
 db " ASSEMBLER FORTH32 LINK                        "

 db " HEADER 2HEX.   HERE CELL+ ,                  "
 db " mov_edx,#  ' Pop @ ,            call_edx "
 db " mov_[],eax   hex_dot_value CELL+ ,                "
 db " mov_edx,#  ' (hex_dot) @ ,      call_edx       "
 db " mov_edx,#  ' inverse_hexstr @ , call_edx         "

 db " mov_eax,# hexstr ,                             "
 db " mov_edx,#  ' Push @ ,           call_edx         "
 db " mov_edx,#  ' TYPEZ @ ,          call_edx        "
 db " ret                                              "

 db " ALIGN       "

 db " HEADER HEX.   HERE CELL+ ,                  "
 db " pxor_xmm0,xmm0                             "
 db " movdqu_[],xmm0  hex_dot_value  ,           "
 db " mov_edx,#  ' (hex_dot) @ ,      call_edx   "
 db " mov_edx,#  ' inverse_hexstr @ , call_edx        "
 db " mov_eax,# hexstr CELL+ CELL+  ,            "
 db " mov_edx,#  ' Push @ ,           call_edx        "
 db " mov_edx,#  ' TYPEZ @ ,          call_edx     "
 db " ret                                            "

 db " ALIGN        "
 db " ASSEMBLER FORTH32 LINK                        "

 db " HEADER -      HERE CELL+ ,      "
 db " mov_edx,# ' Pop @ ,     "
 db " call_edx           "
 db " mov_ebp,eax                                 "
 db " call_edx          "
 db " sub_eax,ebp       "
 db " mov_edx,#  ' Push @ ,                       "
 db " call_edx    "
 db " ret         "

 db " ALIGN          "

 db " HEADER SWAP-           HERE CELL+ ,     "
 db " mov_edx,# ' Pop @ ,      "
 db " call_edx      "
 db " mov_ebp,eax         "
 db " call_edx            "
 db " sub_eax,ebp  neg_eax     "
 db " mov_edx,#  ' Push @ ,      "
 db " call_edx                                  "
 db " ret           "

 db " ALIGN           "

 db " HEADER +        HERE CELL+ ,                "                    ; code field
 db " mov_edx,# ' Pop @ ,   call_edx              "
 db " mov_ebp,eax           "
 db " call_edx                                                                                                                                                                  "
 db " add_eax,ebp          "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret                                     "

 db " ALIGN                    "

 db " HEADER *        HERE CELL+ ,                "
 db " mov_edx,# ' Pop @ ,   call_edx              "
 db " mov_ebp,eax           "
 db " call_edx                                                                                                                                                                  "
 db " imul_eax,ebp          "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret                                     "

 db " ALIGN  "

 db " HEADER TIMER@     HERE CELL+ ,       "
 db " rdtsc         "
 db " mov_ebp,edx                  "
 db " mov_edx,#  ' Push @ ,          call_edx         "
 db " mov_eax,ebp           "
 db " call_edx       "
 db " ret       "

 db " ALIGN    "

 db " HEADER 1+         HERE CELL+ ,       "
 db " mov_edx,#  ' Pop @ ,            call_edx       "
 db " inc_eax            "
 db " mov_edx,#  ' Push @ ,           call_edx           "
 db " ret        "

 db " ALIGN    "

 db " HEADER 1-         HERE CELL+ ,       "
 db " mov_edx,#  ' Pop @ ,            call_edx       "
 db " dec_eax            "
 db " mov_edx,#  ' Push @ ,           call_edx           "
 db " ret        "

 db " ALIGN    "

 db " HEADER 2*         HERE CELL+ ,       "
 db " mov_edx,#  ' Pop @ ,            call_edx       "
 db " shl_eax,1            "
 db " mov_edx,#  ' Push @ ,           call_edx           "
 db " ret        "

 db " ALIGN    "

 db " HEADER 2/         HERE CELL+ ,       "
 db " mov_edx,#  ' Pop @ ,            call_edx       "
 db " shr_eax,1            "
 db " mov_edx,#  ' Push @ ,           call_edx           "
 db " ret        "

 db " ALIGN    "
 db " HEADER C@         HERE CELL+ ,   "
 db " mov_edx,#  ' Pop @ ,            call_edx      "
 db " movzx_eax,b[eax]         "
 db " mov_edx,#  ' Push @ ,           call_edx       "
 db " ret        "

 db " ALIGN        "

 db " HEADER C!         HERE CELL+ ,   "
 db " mov_edx,#  ' Pop @ ,            call_edx      "
 db " mov_esi,eax  "
 db " call_edx         "
 db " mov_[esi],al      "
 db " ret        "

 db " ALIGN        "

 db " HEADER ALLOT      HERE CELL+ ,          "
 db " mov_edx,#  ' Pop @ ,            call_edx        "
 db " add_[],eax ' HERE CELL+ ,         "
 db " mov_edx,# ' ALIGN @ ,   call_edx       "
 db " ret          "

 db " ALIGN         "

 db " HEADER SLIT          HERE CELL+ ,   "
 db " mov_eax,[esp+4]          "     ; get addresinterpretator point
 db " add_eax,4                 "
 db " mov_edx,#  ' Push @ ,           call_edx         "
 db " mov_eax,[esp+4]        "
 db " movzx_ebx,b[eax+4]     "
 db " inc_ebx  inc_ebx       "
 db " add_eax,ebx          "
 db " and_eax,-4     "
 db " and_ebx,3                  "             ; align it
 db " setne_bl               "
 db " shl_ebx,2              "
 db " add_eax,ebx             "
 db " mov_[esp+4],eax          "
 db " ret              "

 db " ALIGN                   "




 db " HEADER DUP        HERE CELL+ ,     "
 db " mov_edx,#  ' Pop @ ,            call_edx     "
 db " mov_edx,#  ' Push @ ,  call_edx  call_edx     "
 db " ret      "

 db " ALIGN     "

 db " HEADER >R         HERE CELL+ ,       "
 db " mov_edx,#  ' Pop @ ,            call_edx      "
 db " pop_ebx            "
 db " pop_ecx          "
 db " push_eax        "
 db " push_ecx             "
 db " push_ebx         "
 db " ret                "

 db " ALIGN    "

 db " HEADER R>         HERE CELL+ ,    "
 db " pop_ebx            "
 db " pop_ecx            "
 db " pop_eax                              "
 db " push_ecx           "
 db " push_ebx         "
 db " mov_edx,#  ' Push @ ,  call_edx          "
 db " ret   "

 db " ALIGN    "

 db " HEADER R@         HERE CELL+ ,       "
 db " pop_ebx                    "
 db " pop_ecx               "
 db " pop_eax             "
 db " push_eax           "
 db " push_ecx         "
 db " push_ebx        "
 db " mov_edx,#  ' Push @ ,  call_edx      "
 db " ret      "

 db " ALIGN   "

 db " HEADER SWAP!         HERE CELL+ ,         "
 db " mov_edx,#  ' Pop @ ,            call_edx       "
 db " mov_ebp,eax            "
 db " call_edx            "
 db " mov_[eax],ebp             "
 db " ret       "

 db " ALIGN "

 db " FORTH32 CONTEXT ! FORTH32 CURRENT !     "

 db " EXIT    " ,0

 alignhe20
