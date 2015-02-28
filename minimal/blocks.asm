
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
 db     " 0x 2 LOAD EXIT "
 db     0
 alignhe20

;block 2    opcodes

 db     "       ASSEMBLER CURRENT !  ASSEMBLER CONTEXT  !   "
 db     "       0x C3 0x 1 opcode ret                "
 db     "       0x BA 0x 1 opcode mov_edx,#          "
 db     "       0x B8 0x 1 opcode mov_eax,#          "
 db     "       0x A3 0x 1 opcode mov_[],eax         "
 db     " 0x D2 0x FF 0x 2 opcode call_edx           "
 db     " 0x C5 0x 89 0x 2 opcode mov_ebp,eax        "
 db     " 0x C5 0x 2B 0x 2 opcode sub_eax,ebp        "
 db     " 0x 05 0x 6F 0x 0F 0x 66 0x 4 opcode movdqa_xmm0,[] "
 db     " 0x C9 0x EF 0x 0F 0x 66 0x 4 opcode pxor_xmm1,xmm1 "
 db     " 0x 3 LOAD    "
 db     " EXIT "
 db 0

  alignhe20
 ; block 3   HEX. , "minus" code
 db " FORTH32 CURRENT ! ASSEMBLER CONTEXT !  "
 db "  "
 db " HEADER   hex_dot_value  variable#  , 0x 0 , 0x 0 , 0x 0 , 0x 0 ,  FORTH32 CONTEXT !  "
 db "   hex_dot_value "
 db " HEADER (hex_dot) HERE CELL+ , "
 db "  ASSEMBLER CONTEXT ! "
 db " mov_edx,#  ' Pop @ , "
 db " call_edx "
 db " mov_[],eax   hex_dot_value  ,  "
 db " movdqa_xmm0,[]   hex_dot_value  , "
 db " pxor_xmm1,xmm1 "
 db " ret "
 db " HEADER 2HEX.   HERE CELL+ , "
 db " mov_edx,#  ' Pop @ , "
 db " call_edx "
 db " mov_[],eax  hex_dot_value CELL+ ,  "
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
 db " FORTH32 CONTEXT ! FORTH32 CURRENT ! "
 db " EXIT " ,0

 align 8192
 db 0
