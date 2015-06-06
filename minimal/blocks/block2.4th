
;block 2    opcodes  3, 4, 5

 db     "       ASSEMBLER CURRENT !  ASSEMBLER CONTEXT  !                     "



 db     "             0x 04 0x C0 0x 83 0x 3 opcode add_eax,4                 "
 db     "             0x 04 0x C1 0x 83 0x 3 opcode add_ecx,4                 "
 db     "             0x 04 0x E8 0x 83 0x 3 opcode sub_eax,4                 "
 db     "             0x 03 0x E0 0x 83 0x 3 opcode and_eax,3                 "
 db     "             0x FC 0x E0 0x 83 0x 3 opcode and_eax,-4                "
 db     "             0x 03 0x E3 0x 83 0x 3 opcode and_ebx,3                 "
 db     "             0x C0 0x 97 0x 0F 0x 3 opcode seta_al                   "
 db     "             0x C0 0x 94 0x 0F 0x 3 opcode sete_al                   "
 db     "             0x C0 0x 92 0x 0F 0x 3 opcode setc_al                   "
 db     "             0x C0 0x 95 0x 0F 0x 3 opcode setne_al                  "
 db     "             0x C3 0x 95 0x 0F 0x 3 opcode setne_bl                  "
 db     "             0x C0 0x 93 0x F0 0x 3 opcode setnc_al                  "
 db     "             0x C3 0x 93 0x 0F 0x 3 opcode setnc_bl                  "
 db     "             0x C1 0x 92 0x 0F 0x 3 opcode setc_cl                   "
 db     "             0x C1 0x 96 0x 0F 0x 3 opcode setbe_cl                  "
 db     "             0x 02 0x E0 0x C0 0x 3 opcode shl_al,2                  "
 db     "             0x 02 0x E0 0x C1 0x 3 opcode shl_eax,2                 "
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
 db     "             0x CD 0x 45 0x 0F 0x 3 opcode cmovne_ecx,ebp            "
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
