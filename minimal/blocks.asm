
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
 db     " 0x 2 LOAD                                                             "
 db     " 0x 3 LOAD 0x 5 LOAD                                          "

; db     "  TIMER@  2HEX.              "

 db     " 0x 4 LOAD                                  "
 db     ' S" Test of type "  1+ TYPEZ                                       '

  db " FORTH32 CURRENT ! FORTH32 CONTEXT ! "
 db        "   .( WORD:) WORD:  nnb    HERE    HEX. 0x_as_lit, 333777 HEX.   "
 db        ' ." Test print in nnb word "    ;WORD '
; db        " .( tt_test) HERE  WORD: dde tt ;WORD @HEX. @HEX. @HEX. @HEX. @HEX. .( tt_aftre) "
 db     "  nnb TIMER@ 2HEX.           "
  db     "  "
 db     " EXIT                                                                          "
 db     0
 alignhe20

;block 2    opcodes

 db     "       ASSEMBLER CURRENT !  ASSEMBLER CONTEXT  !                     "

 db     "                         0x C3 0x 1 opcode ret                       "
 db     "                         0x F4 0x 1 opcode hlt                       "
 db     "                         0x FC 0x 1 opcode cld                       "
 db     "                         0x BA 0x 1 opcode mov_edx,#                 "
 db     "                         0x B8 0x 1 opcode mov_eax,#                 "
 db     "                         0x 25 0x 1 opcode and_eax,#                 "
 db     "                         0x A3 0x 1 opcode mov_[],eax                "
 db     "                         0x A1 0x 1 opcode mov_eax,[]                "
 db     "                         0x 40 0x 1 opcode inc_eax                   "
 db     "                         0x 43 0x 1 opcode inc_ebx                   "
 db     "                         0x 41 0x 1 opcode inc_ecx                   "
 db     "                         0x 58 0x 1 opcode pop_eax                   "
 db     "                         0x 5B 0x 1 opcode pop_ebx                   "
 db     "                         0x 59 0x 1 opcode pop_ecx                   "
 db     "                         0x 50 0x 1 opcode push_eax                  "
 db     "                         0x 53 0x 1 opcode push_ebx                  "
 db     "                         0x 51 0x 1 opcode push_ecx                  "

 db     "                   0x 1D 0x 8B 0x 2 opcode mov_ebx,[]                "
 db     "                   0x 0D 0x 8B 0x 2 opcode mov_ecx,[]                "
 db     "                   0x 15 0x 8B 0x 2 opcode mov_edx,[]                "
 db     "                   0x 15 0x 89 0x 2 opcode mov_[],edx                "
 db     "                   0x 0D 0x 89 0x 2 opcode mov_[],ecx                "
 db     "                   0x 1D 0x 89 0x 2 opcode mov_[],ebx                "
 db     "                   0x 05 0x C7 0x 2 opcode mov_d[],#                 "
 db     "                   0x 05 0x C6 0x 2 opcode mov_b[],#                 "
 db     "                   0x 28 0x 89 0x 2 opcode mov_[eax],ebp             "
 db     "                   0x 05 0x 01 0x 2 opcode add_[],eax                "
 db     "                   0x D8 0x F7 0x 2 opcode neg_eax                   "

 db     "                   0x C8 0x 0F 0x 2 opcode bswap_eax                 "
 db     "                   0x CB 0x 0F 0x 2 opcode bswap_ebx                 "
 db     "                   0x C9 0x 0F 0x 2 opcode bswap_ecx                 "
 db     "                   0x CA 0x 0F 0x 2 opcode bswap_edx                 "

 db     "                   0x 31 0x 0F 0x 2 opcode rdtsc                     "

 db     "                   0x D2 0x FF 0x 2 opcode call_edx                  "
 db     "                   0x C5 0x 89 0x 2 opcode mov_ebp,eax               "
 db     "                   0x E8 0x 89 0x 2 opcode mov_eax,ebp               "
 db     "                   0x C2 0x 89 0x 2 opcode mov_edx,eax               "
 db     "                   0x C6 0x 89 0x 2 opcode mov_esi,eax               "
 db     "                   0x C7 0x 89 0x 2 opcode mov_edi,eax               "
 db     "                   0x C8 0x 89 0x 2 opcode mov_eax,ecx               "
 db     "                   0x D0 0x 89 0x 2 opcode mov_eax,edx               "
 db     "                   0x D5 0x 89 0x 2 opcode mov_ebp,edx               "
 db     "                   0x A5 0x F3 0x 2 opcode rep_movsd                 "
 db     "                   0x D8 0x 01 0x 2 opcode add_eax,ebx               "
 db     "                   0x E8 0x 01 0x 2 opcode add_eax,ebp               "
 db     "                   0x E8 0x 21 0x 2 opcode and_eax,ebp               "
 db     "                   0x C5 0x 2B 0x 2 opcode sub_eax,ebp               "
 db     "                   0x DB 0x 31 0x 2 opcode xor_ebx,ebx               "
 db     "                   0x 25 0x 83 0x 2 opcode and_d[],#                 "
 db     "                   0x E8 0x 39 0x 2 opcode cmp_eax,ebp               "
 db     "                   0x C0 0x 85 0x 2 opcode test_eax,eax              "

 db     "             0x 04 0x C0 0x 83 0x 3 opcode add_eax,4                 "
 db     "             0x 04 0x C1 0x 83 0x 3 opcode add_ecx,4                 "
 db     "             0x 04 0x E8 0x 83 0x 3 opcode sub_eax,4                 "
 db     "             0x 03 0x E0 0x 83 0x 3 opcode and_eax,3                 "
 db     "             0x FC 0x E0 0x 83 0x 3 opcode and_eax,-4                "
 db     "             0x 03 0x E3 0x 83 0x 3 opcode and_ebx,3                 "
 db     "             0x C0 0x 94 0x 0F 0x 3 opcode sete_al                   "
 db     "             0x C0 0x 95 0x 0F 0x 3 opcode setne_al                  "
 db     "             0x C3 0x 95 0x 0F 0x 3 opcode setne_bl                  "
 db     "             0x 02 0x E0 0x C0 0x 3 opcode shl_al,2                  "
 db     "             0x 02 0x E3 0x C1 0x 3 opcode shl_ebx,2                 "
 db     "             0x 02 0x E9 0x C1 0x 3 opcode shr_ecx,2                 "
 db     "             0x 04 0x 40 0x 8B 0x 3 opcode mov_eax,[eax+4]           "
 db     "             0x 04 0x 69 0x 8B 0x 3 opcode mov_ebp,[ecx+4]           "
 db     "             0x 00 0x B6 0x 0F 0x 3 opcode movzx_eax,b[eax]          "
 db     "             0x 0E 0x B6 0x 0F 0x 3 opcode movzx_ecx,b[esi]          "
 db     "             0x CD 0x 44 0x 0F 0x 3 opcode cmove_ecx,ebp             "
 db     "             0x 24 0x 84 0x 81 0x 3 opcode add_d[esp+],#             "
 db     "             0x C2 0x 10 0x 00 0x 3 opcode retn_10h                  "

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

 db     " 0x 04 0x 04 0x 24 0x 44 0x 83 0x 5 opcode add_d[esp+4],4                "
 db     " 0x 08 0x 10 0x 24 0x 44 0x 83 0x 5 opcode add_d[esp+10],8                "
 db     " 0x 04 0x F0 0x 73 0x 0F 0x 66 0x 5 opcode psllq_xmm0,4                  "
 db     " 0x 04 0x D1 0x 73 0x 0F 0x 66 0x 5 opcode psrlq_xmm1,4                  "

 db     " EXIT                                                                                                                            "
 db 0

  alignhe20
 ; block 3   CELL-  hex_dot_value sixes efes sevens zeroes hexstr inverse_hexstr (hex_dot)
 ;   2HEX.  - +  TIMER@  lit# 1+ C@ ALLOT SLIT exec_point strcopy DUP >R R> R@ SWAP!
 db " FORTH32 CURRENT ! ASSEMBLER CONTEXT !    "

 db " HEADER   CELL-  HERE CELL+ ,             "
 db " mov_edx,#  ' Pop @ ,                     "
 db " call_edx                                 "
 db " sub_eax,4                                "
 db " mov_edx,#  ' Push @ ,                    "
 db " call_edx                                 "
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

 db " HEADER -                                     "                     ;name+link fields
 db " HERE CELL+ ,                              "                    ; code field
 db " mov_edx,# ' Pop @ ,                          "        ;parameters field
 db " call_edx                                    "
 db " mov_ebp,eax                                 "
 db " call_edx                                    "
 db " sub_eax,ebp                                  "
 db " mov_edx,#  ' Push @ ,                       "
 db " call_edx                                  "
 db " ret                                        "

 db " ALIGN                                      "

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

 db " HEADER C@         HERE CELL+ ,   "
 db " mov_edx,#  ' Pop @ ,            call_edx      "
 db " movzx_eax,b[eax]         "
 db " mov_edx,#  ' Push @ ,           call_edx       "
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

 db " HEADER exec_point          HERE CELL+ ,                   "
 db " mov_eax,[esp+C]              "
 db " mov_edx,#  ' Push @ ,           call_edx        "
 db " ret                   "

 db " ALIGN  "

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
 ; BEGIN AGAIN UNTIL IF THEN ELSE IMMEDIATES ;WORD   WORD:  0x_as_lit,
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

 db " WORD: 0x_as_lit,    0x, ;WORD "

  db " .( tt_define)  WORD: tt   [ ' 1+ LIT, ]  , [ ' TYPEZ LIT, ] ,    ;WORD "


 db ' WORD: ."      ,"  '
 db "  [ ' 1+ LIT, ]  , [ ' TYPEZ LIT, ] ,  ;WORD  "




 ;db " ', lit#  ', SLIT   ', ,  ', HERE  ', QUOTE  ', WORD  ', C@ ', 1+ ', 1+ ', ALLOT  "
 ;db " ', lit# ' 1+ , ', ,  ', lit# ' TYPEZ , ', , ;Word "

 db " FORTH32 CURRENT !    IMMEDIATES UNLINK "
 ;db " LATEST 1+ TYPEZ "
 ; db " .( mm_define ) WORD: mm      TIMER@ [ TIMER@  2HEX. ] 2HEX. ;WORD  "

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

 db " FORTH32 CONTEXT ! FORTH32 CURRENT !     "

 db " EXIT "

 db     0
 alignhe20
 ;block 6

 db     0
