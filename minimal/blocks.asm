
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
 db     " TYPEZ  "
 db     " 0x 2 LOAD  "
 db     " 0x 3 LOAD  "
 db     "  TIMER@ 2HEX. TIMER@ HEX.  HEX. "
 db     " 0x 55555  HEADER ttt constant# , ,  ttt HEX. "
 db     " 0x 4 LOAD    "

 db     " 0x AAAA CONSTANT mmm   mmm  HEX. "
 db     " EXIT "
 db     0
 alignhe20

;block 2    opcodes

 db     "       ASSEMBLER CURRENT !  ASSEMBLER CONTEXT  !               "
 db     "                         0x C3 0x 1 opcode ret                       "
 db     "                         0x BA 0x 1 opcode mov_edx,#                 "
 db     "                         0x B8 0x 1 opcode mov_eax,#                 "
 db     "                         0x A3 0x 1 opcode mov_[],eax                "
 db     "                         0x A1 0x 1 opcode mov_eax,[]                "

 db     "                   0x 1D 0x 8B 0x 2 opcode mov_ebx,[]                "
 db     "                   0x 0D 0x 8B 0x 2 opcode mov_ecx,[]                "
 db     "                   0x 15 0x 8B 0x 2 opcode mov_edx,[]                "
 db     "                   0x 15 0x 89 0x 2 opcode mov_[],edx                "
 db     "                   0x 0D 0x 89 0x 2 opcode mov_[],ecx                "
 db     "                   0x 1D 0x 89 0x 2 opcode mov_[],ebx                "

 db     "                   0x C8 0x 0F 0x 2 opcode bswap_eax                 "
 db     "                   0x CB 0x 0F 0x 2 opcode bswap_ebx                 "
 db     "                   0x C9 0x 0F 0x 2 opcode bswap_ecx                 "
 db     "                   0x CA 0x 0F 0x 2 opcode bswap_edx                 "

 db     "                   0x 31 0x 0F 0x 2 opcode rdtsc                     "

 db     "                   0x D2 0x FF 0x 2 opcode call_edx                  "
 db     "                   0x C5 0x 89 0x 2 opcode mov_ebp,eax               "
 db     "                   0x E8 0x 89 0x 2 opcode mov_eax,ebp               "
 db     "                   0x C2 0x 89 0x 2 opcode mov_edx,eax               "
 db     "                   0x D0 0x 89 0x 2 opcode mov_eax,edx               "
 db     "                   0x D5 0x 89 0x 2 opcode mov_ebp,edx               "
 db     "                   0x C5 0x 2B 0x 2 opcode sub_eax,ebp               "


 db     "             0x 04 0x E8 0x 83 0x 3 opcode sub_eax,4                 "

 db     "       0x 05 0x 6F 0x 0F 0x 66 0x 4 opcode movdqa_xmm0,[]            "
 db     "       0x 05 0x 7F 0x 0F 0x 66 0x 4 opcode movdqa_[],xmm0            "
 db     "       0x C0 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm0,xmm0            "
 db     "       0x C9 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm1,xmm1            "
 db     "       0x DB 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm3,xmm3            "
 db     "       0x C1 0x EB 0x 0F 0x 66 0x 4 opcode por_xmm0,xmm1             "
 db     "       0x D9 0x F8 0x 0F 0x 66 0x 4 opcode psubb_xmm3,xmm1           "
 db     "       0x C3 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm0,xmm3           "
 db     "       0x C1 0x 60 0x 0F 0x 66 0x 4 opcode punpcklbw_xmm0,xmm1       "
 db     "       0x C8 0x 6F 0x 0F 0x 66 0x 4 opcode movdqa_xmm1,xmm0          "
 db     "       0x 0D 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm1,[]              "
 db     "       0x 05 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm0,[]              "
 db     "       0x 1D 0x DB 0x 0F 0x 66 0x 4 opcode pand_xmm3,[]              "
 db     "       0x 0D 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm1,[]             "
 db     "       0x 05 0x FC 0x 0F 0x 66 0x 4 opcode paddb_xmm0,[]             "

 db     " 0x 04 0x F0 0x 73 0x 0F 0x 66 0x 5 opcode psllq_xmm0,4        "
 db     " 0x 04 0x D1 0x 73 0x 0F 0x 66 0x 5 opcode psrlq_xmm1,4        "

 db     " EXIT "
 db 0

  alignhe20
 ; block 3   CELL-  hex_dot_value sixes efes sevens zeroes hexstr inverse_hexstr
 ;           (hex_dot) 2HEX.  "minus"  TIMER@
 db " FORTH32 CURRENT ! ASSEMBLER CONTEXT !  "

 db " HEADER   CELL-  HERE CELL+ ,  "
 db " mov_edx,#  ' Pop @ , "
 db " call_edx "
 db " sub_eax,4 "
 db " mov_edx,#  ' Push @ , "
 db " call_edx "
 db " ret "

 db " HEADER   hex_dot_value  variable#  , 0xd 0 , , 0xd 0 , ,   "
 db " HEADER   sixes          variable#  , 0xd 0606060606060606 , , 0xd   0606060606060606 , , "
 db " HEADER   efes           variable#  , 0xd 0F0F0F0F0F0F0F0F , , 0xd   0F0F0F0F0F0F0F0F , , "
 db " HEADER   sevens         variable#  , 0xd 0707070707070707 , , 0xd   0707070707070707 , , "
 db " HEADER   zeroes         variable#  , 0xd 3030303030303030 , , 0xd   3030303030303030 , , "
 db " HEADER   hexstr         variable#  , 0xd 3332323536394143 , , 0xd 0 , , 0x 0 ,  "

 db " ASSEMBLER FORTH32 LINK       "

 db " HEADER    inverse_hexstr  HERE CELL+ , "
 db " mov_eax,[] hexstr , "
 db " mov_ebx,[] hexstr CELL+ , "
 db " mov_ecx,[] hexstr CELL+ CELL+ , "
 db " mov_edx,[] hexstr CELL+ CELL+ CELL+ , "
 db " bswap_eax  bswap_ebx    bswap_ecx   bswap_edx "
 db " mov_[],edx hexstr , "
 db " mov_[],ecx hexstr CELL+ , "
 db " mov_[],ebx hexstr CELL+ CELL+ , "
 db " mov_[],eax hexstr CELL+ CELL+ CELL+ , "
 db " ret "

 db " ALIGN "

 db " HEADER (hex_dot) HERE CELL+ , "

 db " mov_edx,#  ' Pop @ , "
 db " call_edx "
 db " mov_[],eax   hex_dot_value  ,  "
 db " movdqa_xmm0,[]   hex_dot_value  , "
 db " pxor_xmm1,xmm1 "
 db " punpcklbw_xmm0,xmm1 "
 db " movdqa_xmm1,xmm0    "
 db " pand_xmm1,[] efes , "
 db " psllq_xmm0,4 "
 db " pand_xmm0,[] efes , "
 db " por_xmm0,xmm1     "
 db " movdqa_xmm1,xmm0  "
 db " paddb_xmm1,[] sixes , "
 db " psrlq_xmm1,4  "
 db " pand_xmm1,[]  efes , "
 db " pxor_xmm3,xmm3       "
 db " psubb_xmm3,xmm1      "
 db " pand_xmm3,[] sevens , "
 db " paddb_xmm0,xmm3     "
 db " paddb_xmm0,[] zeroes , "
 db " movdqa_[],xmm0 hexstr ,   "
 db " ret "

 db " ALIGN "
 db " ASSEMBLER FORTH32 LINK       "

 db " HEADER 2HEX.   HERE CELL+ , "
 db " mov_edx,#  ' Pop @ ,            call_edx "
 db " mov_[],eax   hex_dot_value CELL+ ,  "
 db " mov_edx,#  ' (hex_dot) @ ,      call_edx "
 db " mov_edx,#  ' inverse_hexstr @ , call_edx "

 db " mov_eax,# hexstr , "
 db " mov_edx,#  ' Push @ ,           call_edx "
 db " mov_edx,#  ' TYPEZ @ ,          call_edx "
 db " ret "

 db " ALIGN "

 db " HEADER HEX.   HERE CELL+ , "
 db " pxor_xmm0,xmm0  "
 db " movdqa_[],xmm0  hex_dot_value  ,   "
 db " mov_edx,#  ' (hex_dot) @ ,      call_edx "
 db " mov_edx,#  ' inverse_hexstr @ , call_edx "
 db " mov_eax,# hexstr , "
 db " mov_edx,#  ' Push @ ,           call_edx "
 db " mov_edx,#  ' TYPEZ @ ,          call_edx "
 db " ret "

 db " ALIGN "

 db " HEADER -  "                     ;name+link fields
 db " HERE CELL+ ,   "               ; code field
 db " mov_edx,# ' Pop @ ,   "    ;parameters field
 db " call_edx "
 db " mov_ebp,eax "
 db " call_edx "
 db " sub_eax,ebp HERE "
 db " mov_edx,#  ' Push @ , "
 db " call_edx "
 db " ret "

 db " ALIGN "

 db " HEADER TIMER@     HERE CELL+ , "
 db " rdtsc "
 db " mov_ebp,edx       "
 db " mov_edx,#  ' Push @ ,           call_edx "
 db " mov_eax,ebp  "
 db " call_edx     "
 db " ret          "

 db " ALIGN "

 db " FORTH32 CONTEXT ! FORTH32 CURRENT ! "

 db " EXIT " ,0

 alignhe20
 ;block 4 CONSTANT VARIABLE
 db " FORTH32 CURRENT ! FORTH32 CONTEXT !  "

 db " HEADER CONSTANT   interpret# ,           "

 db " ' HEADER , ' constant# , ' , , ' , ,   ' EXIT ,   "
 ;db " mov_ebp,eax                            "
 ;db " call_edx                               "
 db  0
 alignhe20
 ;block 5
 db     0
