
 ;block 6    COMPILE BRANCH ?OF ?BRANCH  AND  OR XOR =  <> < stop break exec_point WITNIN rWITHIN  SP@
 ;           SWAP OVER NEGATE NOT CELLs strcopy clear

 db " FORTH32 CURRENT ! ASSEMBLER CONTEXT !    "


 db " HEADER COMPILE       HERE CELL+ ,        "
 db " mov_eax,[esp+4]                        "
 db " mov_eax,[eax+4]          "
 db " mov_edx,#  ' Push @ ,           call_edx      "
 db " add_d[esp+4],4      "
 db " mov_edx,# ' , @ ,  call_edx "
 db " ret    "

 db " ALIGN    "

 db " HEADER BRANCH          HERE   CELL+ , "
 db " mov_eax,[esp+4]                        "
 db " mov_eax,[eax+4]          "
 db " mov_[esp+4],eax     "
 db " ret    "

 db " ALIGN "

 db " HEADER ?OF          HERE   CELL+ , "
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

 db " HEADER ?BRANCH         HERE   CELL+ , "
 db " mov_ecx,[esp+4]         " ; addrr interpr point
 db " mov_ebp,[ecx+4]          "               ; branch value
 db " add_ecx,4     "                          ; next cell
 db " mov_edx,#  ' Pop @ ,   call_edx      "
 db " test_eax,eax "
 db " cmovne_ecx,ebp     " ; if true-> branch
 db " mov_eax,ecx       "
 db " mov_[esp+4],ecx     "
 db " ret    "

 db " ALIGN "

 db " HEADER AND        HERE CELL+ ,                "                    ; code field
 db " mov_edx,# ' Pop @ ,   call_edx              "
 db " mov_ebp,eax           "
 db " call_edx                    "
 db " and_eax,ebp          "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret                                     "

 db " ALIGN                    "

 db " HEADER OR        HERE CELL+ ,                "                    ; code field
 db " mov_edx,# ' Pop @ ,   call_edx              "
 db " mov_ebp,eax           "
 db " call_edx                   "
 db " or_eax,ebp          "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret                                     "

 db " ALIGN     "

 db " HEADER XOR        HERE CELL+ ,                "                    ; code field
 db " mov_edx,# ' Pop @ ,   call_edx              "
 db " mov_ebp,eax           "
 db " call_edx                   "
 db " xor_eax,ebp          "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret                                     "

 db " ALIGN     "
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

 db " ALIGN  "

 db " HEADER <        HERE CELL+ ,                "                    ; code field
 db " mov_edx,# ' Pop @ ,   call_edx              "
 db " mov_ebp,eax           "
 db " call_edx                          "
 db " cmp_eax,ebp          "
 db " seta_al            "
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

 db " HEADER SP@ HERE CELL+ , "
 db " mov_edx,# ' Pop @ , call_edx   "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_eax,ebx "
 db " add_eax,# 0x 80000 , "
 db " call_edx "
 db " ret "

 db " ALIGN      "

 db " HEADER SWAP HERE CELL+ , "
 db " mov_edx,# ' Pop @ , call_edx   "
 db " mov_ebp,eax "
 db " call_edx    "
 db " xchg_eax,ebp "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_eax,ebp "
 db " call_edx "
 db " ret "

 db " ALIGN      "

 db " HEADER OVER HERE CELL+ , "
 db " mov_edx,# ' Pop @ , call_edx   "
 db " mov_ebp,eax "
 db " call_edx    "
 db " mov_ecx,eax "
 db " mov_edx,# ' Push @ , call_edx   "
 db " mov_eax,ebp "
 db " call_edx "
 db " mov_eax,ecx "
 db " call_edx "
 db " ret "

 db " ALIGN      "


 db " HEADER NEGATE         HERE CELL+ ,       "
 db " mov_edx,#  ' Pop @ ,            call_edx       "
 db " neg_eax            "
 db " mov_edx,#  ' Push @ ,           call_edx           "
 db " ret        "

 db " ALIGN    "


 db " HEADER NOT         HERE CELL+ ,       "
 db " mov_edx,#  ' Pop @ ,            call_edx       "
 db " not_eax            "
 db " mov_edx,#  ' Push @ ,           call_edx           "
 db " ret        "

 db " ALIGN    "


 db " HEADER CELLs         HERE CELL+ ,       "
 db " mov_edx,#  ' Pop @ ,            call_edx       "
 db " shl_eax,2            "
 db " mov_edx,#  ' Push @ ,           call_edx           "
 db " ret        "

 db " ALIGN    "

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

 db " HEADER clear            HERE CELL+ ,                      "
 db " mov_edx,#  ' Pop @ ,  call_edx      "   ; addr
 db " mov_edi,eax        "
 db " mov_edx,#  ' Pop @ ,    call_edx         "   ; count in bytes
 db " mov_ecx,eax                "
 db " xor_eax,eax                "
 db " cld               "
 db " rep_stosb                  "
 db " ret      "

 db " ALIGN    "
 db " FORTH32 CONTEXT ! FORTH32 CURRENT !     "

 db " EXIT "

 db     0
 alignhe20
