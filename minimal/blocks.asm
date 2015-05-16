
macro alignhe20
{ virtual
       align 8192
;       align 4096
;       align 2048
;       align 1024
;       align 512
        algn = $ - $$
    end virtual
    db algn dup 20h
    }

;block1
 db     " TYPEZ                                                                         "
 db     " 0x 7 LOAD        0x 2 LOAD      "
 db     " 0x 3 LOAD        0x 5 LOAD      "
 db     " 0x 4 LOAD        0x 6 LOAD      "
 db     " 0x 8 LOAD        "

 db     " .( End of loads) SP@ DUP HEX. TYPEZ 0x 417 @ HEX. 0 0x 417 ! "

 db     " WORD: key "
 db     " KEY  DUP  "
 db     " 0x_as_lit, 10  0x_as_lit, 19  WITHIN  "
 db     " If 0x_as_lit, 10 -  qwerty CELL+ + upper_shift_caps   0x_as_lit, A  AND + C@ SP@  TYPEZ  Then "
 db     " DUP  "
 db     " 0x_as_lit, 1E  0x_as_lit, 26  WITHIN  "
 db     " If 0x_as_lit, 1E -  asdfgh CELL+ + upper_shift_caps   0x_as_lit, 9  AND + C@ SP@  TYPEZ  Then "
 db     " DUP  "
 db     " 0x_as_lit, 2C  0x_as_lit, 32  WITHIN  "
 db     " If 0x_as_lit, 2C -  zxcvbn CELL+ + upper_shift_caps   0x_as_lit, 7  AND + C@ SP@  TYPEZ  Then "
 db     " ;WORD "
 db     " key "

 db     " HERE HEX. TIMER@ 2HEX. EXIT    "
 db     0
 alignhe20

;block 2    opcodes  2, 3, 4, 5

 db     "       ASSEMBLER CURRENT !  ASSEMBLER CONTEXT  !                     "



 db     "             0x 04 0x C0 0x 83 0x 3 opcode add_eax,4                 "
 db     "             0x 04 0x C1 0x 83 0x 3 opcode add_ecx,4                 "
 db     "             0x 04 0x E8 0x 83 0x 3 opcode sub_eax,4                 "
 db     "             0x 03 0x E0 0x 83 0x 3 opcode and_eax,3                 "
 db     "             0x FC 0x E0 0x 83 0x 3 opcode and_eax,-4                "
 db     "             0x 03 0x E3 0x 83 0x 3 opcode and_ebx,3                 "
 db     "             0x C0 0x 94 0x 0F 0x 3 opcode sete_al                   "
 db     "             0x C0 0x 92 0x 0F 0x 3 opcode setc_al                   "
 db     "             0x C0 0x 95 0x 0F 0x 3 opcode setne_al                  "
 db     "             0x C3 0x 95 0x 0F 0x 3 opcode setne_bl                  "
 db     "             0x C3 0x 93 0x 0F 0x 3 opcode setnc_bl                  "
 db     "             0x C1 0x 92 0x 0F 0x 3 opcode setc_cl                   "
 db     "             0x C1 0x 96 0x 0F 0x 3 opcode setbe_cl                  "
 db     "             0x 02 0x E0 0x C0 0x 3 opcode shl_al,2                  "
 db     "             0x 02 0x E3 0x C1 0x 3 opcode shl_ebx,2                 "
 db     "             0x 03 0x E1 0x C1 0x 3 opcode shl_ecx,3                 "
 db     "             0x 10 0x E8 0x C1 0x 3 opcode shr_eax,16                "
 db     "             0x 02 0x E9 0x C1 0x 3 opcode shr_ecx,2                 "
 db     "             0x 24 0x 0C 0x 8B 0x 3 opcode mov_eax,[esp]             "
 db     "             0x 04 0x 40 0x 8B 0x 3 opcode mov_eax,[eax+4]           "
 db     "             0x 04 0x 69 0x 8B 0x 3 opcode mov_ebp,[ecx+4]           "
 db     "             0x 00 0x B6 0x 0F 0x 3 opcode movzx_eax,b[eax]          "
 db     "             0x 0E 0x B6 0x 0F 0x 3 opcode movzx_ecx,b[esi]          "
 db     "             0x 05 0x BE 0x 0F 0x 3 opcode movsx_eax,b[]             "
 db     "             0x 00 0x BE 0x 0F 0x 3 opcode movsx_eax,b[eax]          "
 db     "             0x 1D 0x BE 0x 0F 0x 3 opcode movsx_ebx,b[]             "
 db     "             0x 18 0x BE 0x 0F 0x 3 opcode movsx_ebx,b[eax]          "
 db     "             0x CD 0x 44 0x 0F 0x 3 opcode cmove_ecx,ebp             "
 db     "             0x 24 0x 84 0x 81 0x 3 opcode add_d[esp+],#             "
 db     "             0x C2 0x 10 0x 00 0x 3 opcode retn_10h                  "
 db     "             0x 0D 0x 01 0x 0F 0x 3 opcode sidt_[]                   "

 db     "       0x 05 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm0,[]            "
 db     "       0x 15 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm2,[]            "
 db     "       0x 25 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm4,[]            "
 db     "       0x 35 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm6,[]            "
 db     "       0x 3D 0x 6F 0x 0F 0x F3 0x 4 opcode movdqu_xmm7,[]            "
 db     "       0x 05 0x 7F 0x 0F 0x F3 0x 4 opcode movdqu_[],xmm0            "
 db     "       0x C0 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm0,xmm0            "
 db     "       0x C9 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm1,xmm1            "
 db     "       0x DB 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm3,xmm3            "
 db     "       0x C1 0x EB 0x 0F 0x 66 0x 4 opcode por_xmm0,xmm1             "
 db     "       0x D9 0x F8 0x 0F 0x 66 0x 4 opcode psubb_xmm3,xmm1           "
 db     "       0x C3 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm0,xmm3           "
 db     "       0x C1 0x 60 0x 0F 0x 66 0x 4 opcode punpcklbw_xmm0,xmm1       "
 db     "       0x C8 0x 6F 0x 0F 0x 66 0x 4 opcode movdqa_xmm1,xmm0          "
 db     "       0x 0D 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm1,[]              "
 db     "       0x CA 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm1,xmm2            "
 db     "       0x 05 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm0,[]              "
 db     "       0x C2 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm0,xmm2            "
 db     "       0x 1D 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm3,[]              "
 db     "       0x DA 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm3,xmm2            "
 db     "       0x 0D 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm1,[]             "
 db     "       0x CC 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm1,xmm4           "
 db     "       0x 05 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm0,[]             "
 db     "       0x C2 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm0,xmm2           "


 db     "       0x 04 0x 24 0x 44 0x 8B 0x 4 opcode mov_eax,[esp+4]               "
 db     "       0x 04 0x 24 0x 4C 0x 8B 0x 4 opcode mov_ecx,[esp+4]               "
 db     "       0x 0C 0x 24 0x 44 0x 8B 0x 4 opcode mov_eax,[esp+C]               "
 db     "       0x 04 0x 24 0x 44 0x 89 0x 4 opcode mov_[esp+4],eax               "
 db     "       0x 04 0x 24 0x 4C 0x 89 0x 4 opcode mov_[esp+4],ecx               "
 db     "       0x 0C 0x 24 0x 44 0x 89 0x 4 opcode mov_[esp+C],eax               "
 db     "       0x 04 0x 24 0x 44 0x 01 0x 4 opcode add_[esp+4],eax               "
 db     "       0x 04 0x 40 0x B6 0x 0F 0x 4 opcode movzx_eax,b[eax+4]            "
 db     "       0x 04 0x 58 0x B6 0x 0F 0x 4 opcode movzx_ebx,b[eax+4]            "

 db     "       0x 20 0x E6 0x 20 0x B0 0x 4 opcode eoi                           "

 db     " 0x 04 0x 04 0x 24 0x 44 0x 83 0x 5 opcode add_d[esp+4],4                "
 db     " 0x 08 0x 10 0x 24 0x 44 0x 83 0x 5 opcode add_d[esp+10],8                "
 db     " 0x 04 0x F0 0x 73 0x 0F 0x 66 0x 5 opcode psllq_xmm0,4                  "
 db     " 0x 04 0x D1 0x 73 0x 0F 0x 66 0x 5 opcode psrlq_xmm1,4                  "

 db     " EXIT                                                                                                                            "
 db 0

  alignhe20
 ; block 3   CELL-  hex_dot_value sixes efes sevens zeroes hexstr inverse_hexstr (hex_dot)
 ;   2HEX.  - SWAP- +  TIMER@  lit# 1+ 1- C@ C! ALLOT SLIT exec_point strcopy DUP >R R> R@ SWAP!
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
 db " HEADER   hexstr         variable#  , 0xd 3332323536394143 , , 0xd 0 , , 0x 0 ,            "

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
 db " pand_xmm0,xmm2                                                  "
 db " por_xmm0,xmm1                                                                                                                                                     "
 db " movdqa_xmm1,xmm0                                                 "
 db " movdqu_xmm4,[] sixes ,                                         "
 db " paddb_xmm1,xmm4                                   "
 db " psrlq_xmm1,4                                      "
 db " pand_xmm1,xmm2                                    "
 db " pxor_xmm3,xmm3                                    "
 db " psubb_xmm3,xmm1                                   "
 db " movdqu_xmm2,[] sevens ,                           "
 db " pand_xmm3,xmm2                                    "
 db " paddb_xmm0,xmm3                                   "
 db " movdqu_xmm2,[] zeroes ,                     "
 db " paddb_xmm0,xmm2                                       "
 db " movdqu_[],xmm0 hexstr ,                   "
 db " ret                                               "

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

 db " HEADER TIMER@     HERE CELL+ ,       "
 db " rdtsc         "
 db " mov_ebp,edx                  "
 db " mov_edx,#  ' Push @ ,          call_edx         "
 db " mov_eax,ebp           "
 db " call_edx       "
 db " ret       "

 db " ALIGN    "

 db " HEADER lit#       HERE CELL+ ,        "
 db " mov_eax,[esp+4]                        "
 db " mov_eax,[eax+4]          "
 db " mov_edx,#  ' Push @ ,           call_edx      "
 db " add_d[esp+4],4      "
 db " ret    "

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



 db " HEADER strcopy            HERE CELL+ ,                      "
 db " mov_edx,#  ' Pop @ ,            call_edx      "   ; copy to
 db " mov_edi,eax        "
 db " mov_edx,#  ' Pop @ ,            call_edx         "   ; copy from
 db " mov_esi,eax                "
 db " movzx_ecx,b[esi]            "     ;counter
 db " shr_ecx,2                "
 db " inc_ecx           "
 db " cld               "
 db " rep_movsd                       "
 db " ret      "

 db " ALIGN    "

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
 ;block 4 CONSTANT 0 ) " VARIABLE LIT, ;Word Word: 0x, ', .( PAD Word+ S" exec.
 ; ," @HEX. make_badword   make_exit  VOCABULARY NOOP compiler
 ; BEGIN AGAIN UNTIL IF THEN ELSE IMMEDIATES ;WORD   WORD: [ ] 0x_as_lit, ."
 db " FORTH32 CURRENT ! FORTH32 CONTEXT !  "


 db " HEADER CONSTANT   interpret# ,           "
 db " ' HEADER , ' constant# , ' , , ' , ,   ' EXIT ,   "

 db " 0x 0  CONSTANT 0      "
 db " 0x 29 CONSTANT )      "
 db " 0x 22 CONSTANT QUOTE     "

 db " HEADER VARIABLE   interpret# ,    "
 db " ' HEADER , ' variable# , ' , , ' 0 , ' , ,  ' EXIT , "

 db " HEADER LIT,  interpret# , "
 db "  ' lit# , ' lit# , ' , ,  ' , ,  ' EXIT , "

 db " HEADER ;Word     interpret# ,   ' EXIT LIT,  ' , ,    ' EXIT , "

 db " HEADER Word:     interpret# ,  "
 db "        ' HEADER , ' interpret# ,  ' , ,  ;Word "


 db " Word: 0x,     ' 0x ,  '  LIT, ,    ;Word "

 db " Word: ',      ' ' ,  ' , ,  ;Word       "

 db " Word: WORD       ', BLOCK  ', CELL+  ', CELL+  ', @  ', HERE  ', (WORD)  ;Word  "



 db " Word: .(   ', )  ', WORD  ', HERE  ', 1+  ', TYPEZ  ;Word "

 db " Word: PAD          0x, HERE 0x, 200  ', +   ;Word "

 db " Word: Word+       ', BLOCK  ', CELL+  ', CELL+  ', @  ', PAD  ', (WORD)  ;Word  "

 db ' Word: S"  '
 db "  ', QUOTE  ', BLOCK  ', CELL+  ', CELL+  ', @  ', PAD  ', (WORD) ', PAD  ;Word "

 db " Word: exec.   ', exec_point ', HEX. ;Word "


 db ' Word: ,"  '
 db " ', lit#  ', SLIT   ', ,  ', HERE  ', QUOTE  ', WORD  ', C@ ', 1+ ', 1+ ', ALLOT    ;Word "

 db " Word: @HEX.  ', DUP ', @ ',  HEX. ',  CELL+ ;Word "

 db " Word: make_badword          "
 db ' ," BADWORD"   '
 db "  ', DUP  "
 db "  ', HERE ', strcopy  ', C@ ', CELL+ ', ALLOT "
 db " 0x, 0 ', , ', lit#  ' BADWORD @ ,  ', , ', lit# ', ABORT ', , ;Word  "

 db " Word: make_exit           "
 db ' ," EXIT" '
 db "  ', DUP  "
 db "  ', HERE ', strcopy  ', C@ ', CELL+  ', ALLOT "
 db " ', ,  ', lit#  ', EXIT ', ,  ;Word  "


 db " Word: VOCABULARY               "
 db " ', VARIABLE   ', HERE ', CELL- "
 db " ', HERE ', make_badword        "
 db " ', HERE  ', >R  ', make_exit   "
 db " ', R>  ', SWAP!          ;Word "

 db " Word: NOOP        ;Word     "

 db "  Word: compiler    ', CONTEXT ', @ ', SFIND ', ,  ;Word "


 db " Word: BEGIN    ', HERE ', CELL-   ;Word       "
 db " Word: AGAIN    ', lit#    '  BRANCH ,  ', , ', , ;Word "
 db " Word: UNTIL    ', lit#    ' ?BRANCH ,  ', , ', , ;Word "

 db " Word: IF       ', lit#    ' ?BRANCH ,  ', , ', HERE 0x, 0 ', , ;Word   "
 db " Word: THEN     ', HERE ', SWAP! ;Word "
 db " Word: ELSE     ', HERE ', CELL+ ', CELL+  ', SWAP!  ', lit#    ' BRANCH ,  ', , ', HERE 0x, 0 ', , ;Word   "


 db " VOCABULARY IMMEDIATES "
 db " IMMEDIATES CURRENT !  "

 db " Word: ;WORD    ', lit#  ' EXIT ,  ', ,  ', break ;Word  "

 db " FORTH32 CURRENT ! "
 db " IMMEDIATES FORTH32 LINK "


 db " IMMEDIATES CONTEXT ! "

 db " ' compiler  ' BADWORD CELL+ !   "

 db " FORTH32 CONTEXT !   IMMEDIATES UNLINK "

 db " Word: WORD: "
 db " ', Word:  BEGIN ', PARSE ', IMMEDIATES ', SFIND  ', EXECUTE   AGAIN  ;Word "

 db " IMMEDIATES CURRENT ! "

 db " WORD: [   IMMEDIATES CONTEXT @ LINK       ;WORD "
 db " WORD: ]   IMMEDIATES UNLINK     ;WORD "

 db " Word: Begin       ', HERE ', CELL-  ;Word "
 db " Word: Until       ', lit#    ' ?BRANCH ,  ', , ', , ;Word "
 db " Word: If          ', lit#    ' ?BRANCH ,  ', , ', HERE 0x, 0 ', , ;Word "
 db " Word: Then        ', HERE ', CELL- ', SWAP! ;Word "

 db " WORD: 0x_as_lit,    0x, ;WORD "


 db ' WORD: ."      ,"  '
 db "  [ ' 1+ LIT, ]  , [ ' TYPEZ LIT, ] ,  ;WORD  "




 db " FORTH32 CURRENT !    IMMEDIATES UNLINK "

 db " EXIT "
 db  0

 alignhe20
 ;block 5    BRANCH ?BRANCH AND  =  <> stop break
 db " FORTH32 CURRENT ! ASSEMBLER CONTEXT !    "

 db " HEADER BRANCH          HERE   CELL+ , "
 db " mov_eax,[esp+4]                        "
 db " mov_eax,[eax+4]          "
 db " mov_[esp+4],eax     "
 db " ret    "

 db " ALIGN "

 db " HEADER ?BRANCH          HERE   CELL+ , "
 db " mov_ecx,[esp+4]                        " ; addrr interpr point
 db " mov_ebp,[ecx+4]          "               ; branch value
 db " add_ecx,4     "                          ; next cell
 db " mov_edx,#  ' Pop @ ,            call_edx      "
 db " test_eax,eax "
 db " cmove_ecx,ebp     " ; if false-> branch
 db " mov_eax,ecx       "
 db " mov_[esp+4],ecx     "
 db " ret    "

 db " ALIGN "

 db " HEADER AND        HERE CELL+ ,                "                    ; code field
 db " mov_edx,# ' Pop @ ,   call_edx              "
 db " mov_ebp,eax           "
 db " call_edx                                                                                                                                                                  "
 db " and_eax,ebp          "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret                                     "

 db " ALIGN                    "

 db " HEADER =        HERE CELL+ ,                "                    ; code field
 db " mov_edx,# ' Pop @ ,   call_edx              "
 db " mov_ebp,eax           "
 db " call_edx                 "
 db " cmp_eax,ebp          "
 db " sete_al            "
 db " and_eax,# 0x FF , "
 db " neg_eax   "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret                                     "


 db " ALIGN                    "

 db " HEADER <>        HERE CELL+ ,                "                    ; code field
 db " mov_edx,# ' Pop @ ,   call_edx              "
 db " mov_ebp,eax           "
 db " call_edx                          "
 db " cmp_eax,ebp          "
 db " setne_al            "
 db " and_eax,# 0x FF , "
 db " neg_eax   "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret                                     "

 db " ALIGN                    "

 db " HEADER stop HERE CELL+ , "
 db " hlt "
 db " ret "

 db " ALIGN                    "

 db " HEADER break HERE CELL+ , "
 db  " add_d[esp+],# 0x 10 , 0x 8 , "
 db " ret "

 db " ALIGN      "

 db " HEADER exec_point          HERE CELL+ ,                   "
 db " mov_eax,[esp+C]              "
 db " mov_edx,#  ' Push @ ,           call_edx        "
 db " ret                   "

 db " ALIGN  "

 db " HEADER WITHIN     HERE CELL+ , "      ; x low high
 db " mov_edx,# ' Pop @ ,   call_edx              "
 db " mov_esi,eax "
 db " call_edx    "
 db " mov_edi,eax "
 db " call_edx    "
 db " xor_ebx,ebx "
 db " xor_ecx,ecx "
 db " cmp_eax,edi "
 db " setnc_bl    "
 db " cmp_eax,esi "
 db " setbe_cl    "
 db " xor_eax,eax "
 db " and_ebx,ecx "
 db " sub_eax,ebx "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret "

 db " ALIGN      "

 db " HEADER rWITHIN     HERE CELL+ , "      ;  low high x
 db " mov_edx,# ' Pop @ ,   call_edx              "
 db " mov_ebp,eax "
 db " call_edx    "
 db " mov_edi,eax "
 db " call_edx    "
 db " mov_esi,eax "
 db " xor_ebx,ebx "
 db " xor_ecx,ecx "
 db " mov_eax,ebp "
 db " cmp_eax,edi "
 db " setnc_bl    "
 db " cmp_eax,esi "
 db " setc_cl    "
 db " xor_eax,eax "
 db " and_ebx,ecx "
 db " sub_eax,ebx "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret "

 db " ALIGN      "
 db " FORTH32 CONTEXT ! FORTH32 CURRENT !     "

 db " EXIT "

 db     0
 alignhe20
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
 ;db " mov_eax,edi       "
 ;db " mov_edx,# ' Push @ ,   call_edx              "
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

 db ' WORD: msg_caps ." CAPS " ;WORD '
 db ' WORD: msg_Lshift_pressed  ." Lshift pressed " ;WORD '
 db ' WORD: msg_Lshift_release  ." Lshift released " ;WORD '
 db ' WORD: msg_Rshift_pressed  ." Rshift pressed " ;WORD '
 db ' WORD: msg_Rshift_release  ." Rshift released " ;WORD '
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
 db " mov_[],eax  key , "
 db " add_[],eax 0x B8000 ,  "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_eax,# ' HEX.  ,    "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " eoi "
 db " popad "
 db " iretd "

 db " >forward "
 db " eoi "
 db " popad "
 db " iretd "

 db " >forward "
 db " and_d[],# key_flags ,  0x FFFC00FF  , "
; db " mov_eax,# ' msg_Rshift_release ,     "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_edx,# ' EXECUTE @ , call_edx   "
; db " mov_eax,# key_flags ,      "
; db " mov_eax,[eax]       "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_eax,# ' HEX.  ,    "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " eoi "
 db " popad "
 db " iretd "

 db " >forward "
 db " or_d[],# key_flags , 0x 1FF00 , "
; db " mov_eax,# ' msg_Rshift_pressed ,     "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_edx,# ' EXECUTE @ , call_edx   "
; db " mov_eax,# key_flags ,      "
; db " mov_eax,[eax]       "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_eax,# ' HEX.  ,    "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " eoi "
 db " popad "
 db " iretd "


 db " >forward "
 db " and_d[],# key_flags ,  0x FFFC00FF  , "
; db " mov_eax,# ' msg_Lshift_release ,     "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_edx,# ' EXECUTE @ , call_edx   "
; db " mov_eax,# key_flags ,      "
; db " mov_eax,[eax]       "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_eax,# ' HEX.  ,    "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " eoi "
 db " popad "
 db " iretd "


 db " >forward "
 db " or_d[],# key_flags , 0x 2FF00 , "
; db " mov_eax,# ' msg_Lshift_pressed ,     "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_edx,# ' EXECUTE @ , call_edx   "
; db " mov_eax,# key_flags ,      "
; db " mov_eax,[eax]       "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_eax,# ' HEX.  ,    "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_edx,# ' EXECUTE @ , call_edx   "
 db " eoi "
 db " popad "
 db " iretd "


 db " >forward "
 db " xor_d[],# key_flags , 0x FF , "
; db " mov_eax,# ' msg_caps ,     "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_edx,# ' EXECUTE @ , call_edx   "
; db " mov_eax,# key_flags ,      "
; db " mov_eax,[eax]       "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_eax,# ' HEX.  ,    "
; db " mov_edx,# ' Push @ , call_edx   "
; db " mov_edx,# ' EXECUTE @ , call_edx   "

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
 ;block 7    opcodes 1
 db     "       ASSEMBLER CURRENT !  ASSEMBLER CONTEXT  !                     "
 db     "                         0x C3 0x 1 opcode ret                       "
 db     "                         0x CF 0x 1 opcode iretd                     "
 db     "                         0x F4 0x 1 opcode hlt                       "
 db     "                         0x FC 0x 1 opcode cld                       "
 db     "                         0x CE 0x 1 opcode into                      "
 db     "                         0x CC 0x 1 opcode int3                      "
 db     "                         0x BA 0x 1 opcode mov_edx,#                 "
 db     "                         0x B8 0x 1 opcode mov_eax,#                 "
 db     "                         0x 05 0x 1 opcode add_eax,#                 "
 db     "                         0x 25 0x 1 opcode and_eax,#                 "
 db     "                         0x 3D 0x 1 opcode cmp_eax,#                 "
 db     "                         0x A9 0x 1 opcode test_eax,#                "
 db     "                         0x A3 0x 1 opcode mov_[],eax                "
 db     "                         0x A1 0x 1 opcode mov_eax,[]                "
 db     "                         0x 40 0x 1 opcode inc_eax                   "
 db     "                         0x 43 0x 1 opcode inc_ebx                   "
 db     "                         0x 41 0x 1 opcode inc_ecx                   "
 db     "                         0x 48 0x 1 opcode dec_eax                   "
 db     "                         0x 58 0x 1 opcode pop_eax                   "
 db     "                         0x 5B 0x 1 opcode pop_ebx                   "
 db     "                         0x 59 0x 1 opcode pop_ecx                   "
 db     "                         0x 50 0x 1 opcode push_eax                  "
 db     "                         0x 53 0x 1 opcode push_ebx                  "
 db     "                         0x 51 0x 1 opcode push_ecx                  "
 db     "                         0x 60 0x 1 opcode pushad                    "
 db     "                         0x 61 0x 1 opcode popad                     "
 db     "                         0x E9 0x 1 opcode jmp                       "

 db     "                   0x 1D 0x 8B 0x 2 opcode mov_ebx,[]                "
 db     "                   0x 0D 0x 8B 0x 2 opcode mov_ecx,[]                "
 db     "                   0x 15 0x 8B 0x 2 opcode mov_edx,[]                "
 db     "                   0x 3D 0x 8B 0x 2 opcode mov_edi,[]                "
 db     "                   0x 15 0x 89 0x 2 opcode mov_[],edx                "
 db     "                   0x 0D 0x 89 0x 2 opcode mov_[],ecx                "
 db     "                   0x 1D 0x 89 0x 2 opcode mov_[],ebx                "
 db     "                   0x 05 0x C7 0x 2 opcode mov_d[],#                 "
 db     "                   0x 05 0x C6 0x 2 opcode mov_b[],#                 "
 db     "                   0x 00 0x 8B 0x 2 opcode mov_eax,[eax]             "
 db     "                   0x 28 0x 89 0x 2 opcode mov_[eax],ebp             "
 db     "                   0x 06 0x 88 0x 2 opcode mov_[esi],al              "
 db     "                   0x 05 0x 01 0x 2 opcode add_[],eax                "
 db     "                   0x D8 0x F7 0x 2 opcode neg_eax                   "

 db     "                   0x C8 0x 0F 0x 2 opcode bswap_eax                 "
 db     "                   0x CB 0x 0F 0x 2 opcode bswap_ebx                 "
 db     "                   0x C9 0x 0F 0x 2 opcode bswap_ecx                 "
 db     "                   0x CA 0x 0F 0x 2 opcode bswap_edx                 "

 db     "                   0x 31 0x 0F 0x 2 opcode rdtsc                     "

 db     "                   0x D2 0x FF 0x 2 opcode call_edx                  "
 db     "                   0x C5 0x 89 0x 2 opcode mov_ebp,eax               "
 db     "                   0x C1 0x 89 0x 2 opcode mov_ecx,eax               "
 db     "                   0x E8 0x 89 0x 2 opcode mov_eax,ebp               "
 db     "                   0x C2 0x 89 0x 2 opcode mov_edx,eax               "
 db     "                   0x C6 0x 89 0x 2 opcode mov_esi,eax               "
 db     "                   0x C7 0x 89 0x 2 opcode mov_edi,eax               "
 db     "                   0x F8 0x 89 0x 2 opcode mov_eax,edi               "
 db     "                   0x C8 0x 89 0x 2 opcode mov_eax,ecx               "
 db     "                   0x D8 0x 89 0x 2 opcode mov_eax,ebx               "
 db     "                   0x D0 0x 89 0x 2 opcode mov_eax,edx               "
 db     "                   0x D5 0x 89 0x 2 opcode mov_ebp,edx               "
 db     "                   0x A5 0x F3 0x 2 opcode rep_movsd                 "
 db     "                   0x AB 0x 66 0x 2 opcode stosw                     "
 db     "                   0x D8 0x 01 0x 2 opcode add_eax,ebx               "
 db     "                   0x E8 0x 01 0x 2 opcode add_eax,ebp               "
 db     "                   0x CF 0x 01 0x 2 opcode add_edi,ecx               "
 db     "                   0x CB 0x 21 0x 2 opcode and_ebx,ecx               "
 db     "                   0x E8 0x 21 0x 2 opcode and_eax,ebp               "
 db     "                   0x D8 0x 29 0x 2 opcode sub_eax,ebx               "
 db     "                   0x C5 0x 2B 0x 2 opcode sub_eax,ebp               "
 db     "                   0x C0 0x 31 0x 2 opcode xor_eax,eax               "
 db     "                   0x DB 0x 31 0x 2 opcode xor_ebx,ebx               "
 db     "                   0x C9 0x 31 0x 2 opcode xor_ecx,ecx               "
 db     "                   0x D8 0x 31 0x 2 opcode xor_eax,ebx               "
 db     "                   0x 35 0x 81 0x 2 opcode xor_d[],#                 "
 db     "                   0x 0D 0x 81 0x 2 opcode or_d[],#                  "
 db     "                   0x 25 0x 81 0x 2 opcode and_d[],#                 "
 db     "                   0x E8 0x 39 0x 2 opcode cmp_eax,ebp               "
 db     "                   0x F8 0x 39 0x 2 opcode cmp_eax,edi               "
 db     "                   0x F0 0x 39 0x 2 opcode cmp_eax,esi               "
 db     "                   0x 3D 0x 81 0x 2 opcode cmp_d[],#                 "
 db     "                   0x C0 0x 85 0x 2 opcode test_eax,eax              "

 db     "                   0x 60 0x E4 0x 2 opcode in_al,60h                 "
 db     "                   0x 64 0x E4 0x 2 opcode in_al,64h                 "
 db     "                   0x 64 0x E6 0x 2 opcode out_64h,al                "

 db     "                   0x 84 0x 0F 0x 2 opcode je                        "
 db     "                   0x 85 0x 0F 0x 2 opcode jne                       "

 db     " EXIT                                                                "

 db 0

db     0
 alignhe20
 ;block 8


 db "  .( Interrupts setup ) "

 db " interrupts FORTH32 LINK   "
 db " interrupts CONTEXT !   "

 db     " ' div_by_zero @     0x 0   make_interrupt_gate  "
 db     " ' debug_int   @     0x 1   make_interrupt_gate  "
 db     " ' nmi_int     @     0x 2   make_interrupt_gate  "
 db     " ' break_int   @     0x 3   make_interrupt_gate  "
 db     " ' overflow    @     0x 4   make_interrupt_gate  "
 db     " ' bound_int   @     0x 5   make_interrupt_gate  "
 db     " ' ud_int      @     0x 6   make_interrupt_gate  "
 db     " ' nomath_int  @     0x 7   make_interrupt_gate  "
 db     " ' df_int      @     0x 8   make_interrupt_gate  "
 db     " ' mf_int      @     0x 9   make_interrupt_gate  "
 db     " ' tss_int     @     0x A   make_interrupt_gate  "
 db     " ' np_int      @     0x B   make_interrupt_gate  "
 db     " ' ss_int      @     0x C   make_interrupt_gate  "
 db     " ' gp_int      @     0x D   make_interrupt_gate  "
 db     " ' pf_int      @     0x E   make_interrupt_gate  "

 db     " ' mf_int      @     0x 10  make_interrupt_gate  "
 db     " ' ac_int      @     0x 11  make_interrupt_gate  "
 db     " ' mc_int      @     0x 12  make_interrupt_gate  "
 db     " ' xm_int      @     0x 13  make_interrupt_gate  "
; db     " ' xm_int      @     0x 14  make_interrupt_gate  "

 db     " ' key_int     @     0x 21  make_interrupt_gate  "

 db " FORTH32 CONTEXT ! FORTH32 CURRENT ! "

 db " WORD: CHAR      PARSE HERE 1+ C@  ;WORD "
 db " WORD: B,        HERE C! [ ' HERE CELL+ LIT, ] @ 1+ [ ' HERE CELL+ LIT, ] ! ;WORD "
 db " WORD: b,        1+ DUP C@ DUP HEX.  B, ;WORD  "

 db " WORD: CHAR,     CHAR B, ;WORD 0x A "

 db " WORD: CHArs,  NOOP  Begin DUP  HEX.   1-  DUP     "
 db ' ." cyckel " '
 db " 0x_as_lit, 0  =   Until Pop      ;WORD "

; db " Word: CHARs,    BEGIN    ', CHAR ', B,  ', 1-  ', DUP  0x, 0   ', =  UNTIL   ', Pop     ;Word "
 db " WORD: CHARs,    Begin   CHAR  B,   1-   DUP  0x_as_lit, 0   =  Until    Pop     ;WORD "
 db " ASSEMBLER CONTEXT ! ASSEMBLER FORTH32 LINK  "
 db " FORTH32 CURRENT !  "



 db " VARIABLE windows-1251      "
 db "  0x C  CHARs, 1 2 3 4 5 6 7 8 9 0 - =   0x 0 B, " ; 0 - Esc, E - Backspase

 db " VARIABLE qwerty  "
 db "  0x 14 CHARs, q w e r t y u i o p  Q W E R T Y U I O P " ; F - tab, 1C - Enter
 db " VARIABLE asdfgh  "
 db "  0x 12 CHARs, a s d f g h j k l    A S D F G H J K L "
 db " VARIABLE zxcvbn  "
 db "  0x  E CHARs, z x c v b n m        Z X C V B N M  "

 db "  0x 0 B,   0x C  CHARs, a s d f g h j k l ; ' `            " ; 1D - Ctl,
 db "  0x 0 B,   0x B  CHARs, \ z x c v b n m , . /    0x 0 B, " ; 2A - Lshift, 36 - Rshift
 db "  0x 0 B,   CHAR *  0x 0 B, 0x 20 B,  0x 0 B,                        "                   ;

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
 ;db " mov_eax,# key_flags ,      "
 ;db " inc_eax   "
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


 db " HEADER SP@ HERE CELL+ , "
 db " mov_edx,# ' Pop @ , call_edx   "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_eax,ebx "
 db " add_eax,# 0x 8000 , "
 db " call_edx "
 db " ret "

 db " ALIGN      "

 db " FORTH32 CONTEXT ! FORTH32 CURRENT ! "
 db " EXIT "

db     0
 alignhe20
 ;block 9
