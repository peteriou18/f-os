
 ;block 2    opcodes 1,2

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
 db     "                         0x B5 0x 1 opcode mov_ch,#                  "
 db     "                         0x A3 0x 1 opcode mov_[],eax                "
 db     "                         0x A1 0x 1 opcode mov_eax,[]                "
 db     "                         0x 40 0x 1 opcode inc_eax                   "
 db     "                         0x 43 0x 1 opcode inc_ebx                   "
 db     "                         0x 41 0x 1 opcode inc_ecx                   "
 db     "                         0x 46 0x 1 opcode inc_esi                   "
 db     "                         0x 48 0x 1 opcode dec_eax                   "
 db     "                         0x 49 0x 1 opcode dec_ecx                   "
 db     "                         0x 4D 0x 1 opcode dec_ebp                   "
 db     "                         0x 4F 0x 1 opcode dec_edi                   "
 db     "                         0x 58 0x 1 opcode pop_eax                   "
 db     "                         0x 5B 0x 1 opcode pop_ebx                   "
 db     "                         0x 59 0x 1 opcode pop_ecx                   "
 db     "                         0x 5D 0x 1 opcode pop_ebp                   "
 db     "                         0x 50 0x 1 opcode push_eax                  "
 db     "                         0x 53 0x 1 opcode push_ebx                  "
 db     "                         0x 51 0x 1 opcode push_ecx                  "
 db     "                         0x 55 0x 1 opcode push_ebp                  "
 db     "                         0x 60 0x 1 opcode pushad                    "
 db     "                         0x 61 0x 1 opcode popad                     "
 db     "                         0x 95 0x 1 opcode xchg_eax,ebp              "
 db     "                         0x 96 0x 1 opcode xchg_eax,esi              "
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
 db     "                   0x E0 0x D1 0x 2 opcode shl_eax,1                 "
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
 db     "                   0x EA 0x 89 0x 2 opcode mov_edx,ebp               "
 db     "                   0x 0E 0x 8A 0x 2 opcode mov_cl,[esi]              "
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
