
macro alignhe20
{ virtual
       align 8192
       align 4096
       align 2048
       align 1024
       align 512
        algn = $ - $$
    end virtual
    db algn dup 20h
    }
;block 1
 db     " TYPEZ  "
 db     "  HERE   ASSEMBLER CURRENT !  ASSEMBLER CONTEXT  !   "
 db     "       0x C3 0x 1 opcode ret                "
 db     "       0x BA 0x 1 opcode mov_edx,#          "
 db     "       0x B8 0x 1 opcode mov_eax,#          "
 db     " 0x D2 0x FF 0x 2 opcode call_edx           "
 db     " 0x C5 0x 89 0x 2 opcode mov_ebp,eax        "
 db     " 0x C5 0x 2B 0x 2 opcode sub_eax,ebp        "
 db     " 0x 2 LOAD    "
 db     " 0x 4356 0x 1234 - HEX. HEX. EXIT "


 alignhe20
 ; block 2   - "minus" code
 db " FORTH32 CURRENT ! ASSEMBLER CONTEXT !  "
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

 alignhe20
