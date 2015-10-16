; block 5   CELL-  lit# hex_dot_value sixes efes sevens zeroes hexstr inverse_hexstr (hex_dot)
 ;   2HEX.  HEX.  SWAP- +  TIMER@  lit# 1+ 1- 2* 2/ C@ C! ALLOT SLIT  DUP >R R> R@ SWAP!
 db " FORTH32 CURRENT ! ASSEMBLER CONTEXT !    "

 db " HEADER  CELL-     HERE CELL+ ,             "
 db " mov_edx,#  ' Pop @ , call_edx            "
 db " sub_eax,4                                "
 db " mov_edx,#  ' Push @ ,   call_edx         "
 db " ret                                      "

 db " HEADER lit#       HERE CELL+ ,        "
 db " mov_eax,[esp+4]                        "
 db " mov_eax,[eax+4]          "
 db " mov_edx,#  ' Push @ ,           call_edx      "
 db " add_d[esp+4],4      "
 db " ret    "



 db " ASSEMBLER FORTH32 LINK                        "



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
 db " HEADER LIT,  interpret# , "
 db "  ' lit# , ' lit# , ' , ,  ' , ,  ' EXIT , "

 db " HEADER ;Word     interpret# ,   ' EXIT LIT,  ' , ,    ' EXIT , "

 db " HEADER Word:     interpret# ,  "
 db "        ' HEADER , ' interpret# ,  ' , ,  ;Word "

 db " Word: CONSTANT    ' HEADER , ' interpret# @ LIT,  ' , , ' , ,  ;Word  "

 db " 0x 0        CONSTANT 0      "
 db " 0x 1        CONSTANT 1      "
 db " 0x FFFFFFFF CONSTANT -1 "
 db " 0x 20       CONSTANT BL     "
 db " 0x 29       CONSTANT )      "
 db " 0x 22       CONSTANT QUOTE     "
 db " ' BADWORD @ CONSTANT vect#  "
 db " ' CONTEXT @ CONSTANT variable# "

 db " EXIT    " ,0

 alignhe20
