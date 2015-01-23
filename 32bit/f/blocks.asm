        macro alignhe20
{ virtual
       align 4096
       align 2048
       align 1024
       align 512
        algn = $ - $$
    end virtual
    db algn dup 20h
    }
        ; Block 4
db      "  0xd  BA5ED8888  2HEX. CR  "
db      "   HEADER  to_code'  interpret# ,   ' '  ,  ' @ ,   ' code_here ,   ' ! ,   ' LIT ,  0x 4 , ' RESn , '  EXIT ,  "
;db      " RESn ,   ret# ,     "
db      ' VOCABULARY ASSEMBLER    ASSEMBLER CURRENT ! '
;db     " HEADER RESn  interpret# , ' code_here CELL+ @ +   ' code_here CELL+ ! ret# ,  "
db      "             0x 90 0x 1 opcode nop "
db      '             0x CC 0x 1 opcode int3 '
db      '             0x C3 0x 1 opcode ret '
db      " >IN @ HEX. "
db      '             0x B8 0x 1 opcode mov_eax,# '
db      '             0x BA 0x 1 opcode mov_edx,# '
db      '             0x D0 0x FF 0x 2 opcode call_eax '
db      "             0x D2 0x FF 0x 2 opcode call_edx "
db      " >IN @ HEX. "
db      "             0x 00 0x 8B 0x 2 opcode mov_eax,[eax] "
db      "             0x C2 0x 89 0x 2 opcode mov_edx,eax "
db      "             0x C5 0x 89 0x 2 opcode mov_ebp,eax "
db      "             0x D0 0x 29 0x 2 opcode sub_eax,edx "
db      "             0x C5 0x 2B 0x 2 opcode sub_eax,ebp "
;db      ' 0x D3 0x FF 0x 41 0x 3 opcode call_r11 '
; db    ' 0x 13 0x FF 0x 41 0x 3 opcode call_[r11] '

db      ' FORTH32 CURRENT ! '
db      ' ASSEMBLER FORTH32 LINK     ASSEMBLER CONTEXT !  '
db      " HEADER -   code_here  ,   mov_edx,#   to_code' Pop "
db      "  call_edx  mov_ebp,eax  "
db      "  call_edx  sub_eax,ebp  mov_edx,#  to_code' Push    call_edx  ret "
db      " FORTH32 CONTEXT ! "
;db      " EXIT "
dq      2
alignhe20

        ; Block 5
db      " VOCABULARY cc cc CURRENT ! cc FORTH32 LINK cc CONTEXT ! "
db      " VARIABLE kk  0x ACED kk ! "
db      "  HEADER jj  interpret# ,  ' LIT ,  0x FACE12  ,  ' HEX. ,  ret# ,  "
db      " FORTH32 CURRENT ! "
db      "  " 
dq      2
alignhe20
