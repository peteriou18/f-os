
 ;block 3    opcodes 2

 db     "       ASSEMBLER CURRENT !  ASSEMBLER CONTEXT  !                     "


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
 db     "                   0x 07 0x 89 0x 2 opcode mov_[edi],eax             "
 db     "                   0x 03 0x 01 0x 2 opcode add_[ebx],eax             "
 db     "                   0x 01 0x 01 0x 2 opcode add_[ecx],eax             "
 db     "                   0x 05 0x 01 0x 2 opcode add_[],eax                "
 db     "                   0x D8 0x F7 0x 2 opcode neg_eax                   "
 db     "                   0x D0 0x F7 0x 2 opcode not_eax                   "

 db     "                   0x C8 0x 0F 0x 2 opcode bswap_eax                 "
 db     "                   0x CB 0x 0F 0x 2 opcode bswap_ebx                 "
 db     "                   0x C9 0x 0F 0x 2 opcode bswap_ecx                 "
 db     "                   0x CA 0x 0F 0x 2 opcode bswap_edx                 "

 db     "                   0x 31 0x 0F 0x 2 opcode rdtsc                     "
 db     "                   0x A2 0x 0F 0x 2 opcode cpuid                     "
 db     "                   0x 32 0x 0F 0x 2 opcode rdmsr                     "

 db     "                   0x D2 0x FF 0x 2 opcode call_edx                  "
 db     "                   0x E0 0x D1 0x 2 opcode shl_eax,1                 "
 db     "                   0x E0 0x D3 0x 2 opcode shl_eax,cl                "
 db     "                   0x E0 0x C0 0x 2 opcode shl_al,#                  "
 db     "                   0x E0 0x C1 0x 2 opcode shl_eax,#                 "
 db     "                   0x E1 0x C1 0x 2 opcode shl_ecx,#                 "
 db     "                   0x E8 0x D1 0x 2 opcode shr_eax,1                 "
 db     "                   0x E8 0x D3 0x 2 opcode shr_eax,cl                "
 db     "                   0x E9 0x C0 0x 2 opcode shr_cl,#                  "
 db     "                   0x C5 0x 89 0x 2 opcode mov_ebp,eax               "
 db     "                   0x C3 0x 89 0x 2 opcode mov_ebx,eax               "
 db     "                   0x C1 0x 89 0x 2 opcode mov_ecx,eax               "
 db     "                   0x E8 0x 89 0x 2 opcode mov_eax,ebp               "
 db     "                   0x C2 0x 89 0x 2 opcode mov_edx,eax               "
 db     "                   0x C6 0x 89 0x 2 opcode mov_esi,eax               "
 db     "                   0x C7 0x 89 0x 2 opcode mov_edi,eax               "
 db     "                   0x F7 0x 89 0x 2 opcode mov_edi,esi               "
 db     "                   0x F8 0x 89 0x 2 opcode mov_eax,edi               "
 db     "                   0x C8 0x 89 0x 2 opcode mov_eax,ecx               "
 db     "                   0x D8 0x 89 0x 2 opcode mov_eax,ebx               "
 db     "                   0x D0 0x 89 0x 2 opcode mov_eax,edx               "
 db     "                   0x D5 0x 89 0x 2 opcode mov_ebp,edx               "
 db     "                   0x CA 0x 89 0x 2 opcode mov_edx,ecx               "
 db     "                   0x EA 0x 89 0x 2 opcode mov_edx,ebp               "
 db     "                   0x 0E 0x 8A 0x 2 opcode mov_cl,[esi]              "
 db     "                   0x C1 0x 88 0x 2 opcode mov_cl,al                 "
 db     "                   0x E5 0x 88 0x 2 opcode mov_ch,ah                 "
 db     "                   0x C8 0x 88 0x 2 opcode mov_al,cl                 "
 db     "                   0x E8 0x 88 0x 2 opcode mov_al,ch                 "
 db     "                   0x C4 0x 88 0x 2 opcode mov_ah,al                 "
 db     "                   0x CC 0x 88 0x 2 opcode mov_ah,cl                 "
 db     "                   0x EC 0x 88 0x 2 opcode mov_ah,ch                 "
 db     "                   0x C4 0x 86 0x 2 opcode xchg_al,ah                "
 db     "                   0x A5 0x F3 0x 2 opcode rep_movsd                 "
 db     "                   0x A4 0x F3 0x 2 opcode rep_movsb                 "
 db     "                   0x AA 0x F3 0x 2 opcode rep_stosb                 "
 db     "                   0x AB 0x 66 0x 2 opcode stosw                     "
 db     "                   0x D8 0x 01 0x 2 opcode add_eax,ebx               "
 db     "                   0x E8 0x 01 0x 2 opcode add_eax,ebp               "
 db     "                   0x C7 0x 01 0x 2 opcode add_esi,eax               "
 db     "                   0x CF 0x 01 0x 2 opcode add_edi,ecx               "
 db     "                   0x C7 0x 83 0x 2 opcode add_edi,b#                 "
 db     "                   0x CB 0x 21 0x 2 opcode and_ebx,ecx               "
 db     "                   0x E8 0x 21 0x 2 opcode and_eax,ebp               "
 db     "                   0x E1 0x 80 0x 2 opcode and_cl,#                  "
 db     "                   0x D8 0x 29 0x 2 opcode sub_eax,ebx               "
 db     "                   0x F8 0x 29 0x 2 opcode sub_eax,edi               "
 db     "                   0x C5 0x 2B 0x 2 opcode sub_eax,ebp               "
 db     "                   0x 05 0x 2B 0x 2 opcode sub_eax,[]                "
 db     "                   0x C1 0x 29 0x 2 opcode sub_ecx,eax               "
 db     "                   0x 05 0x 29 0x 2 opcode sub_[],eax                "
 db     "                   0x 05 0x FF 0x 2 opcode inc_d[]                   "
 db     "                   0x 0D 0x FF 0x 2 opcode dec_d[]                   "
 db     "                   0x C0 0x 31 0x 2 opcode xor_eax,eax               "
 db     "                   0x DB 0x 31 0x 2 opcode xor_ebx,ebx               "
 db     "                   0x C9 0x 31 0x 2 opcode xor_ecx,ecx               "
 db     "                   0x D2 0x 31 0x 2 opcode xor_edx,edx               "
 db     "                   0x D8 0x 31 0x 2 opcode xor_eax,ebx               "
 db     "                   0x E8 0x 31 0x 2 opcode xor_eax,ebp               "
 db     "                   0x 35 0x 81 0x 2 opcode xor_d[],#                 "
 db     "                   0x C8 0x 09 0x 2 opcode or_eax,ecx                "
 db     "                   0x E8 0x 09 0x 2 opcode or_eax,ebp                "
 db     "                   0x C9 0x 80 0x 2 opcode or_cl,#                   "
 db     "                   0x 05 0x 09 0x 2 opcode or_[],eax                 "
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
 db     "                   0x EF 0x 66 0x 2 opcode out_dx,ax                 "
 db     "                   0x ED 0x 66 0x 2 opcode in_ax,dx                  "

 db     "                   0x 82 0x 0F 0x 2 opcode jb                        "
 db     "                   0x 84 0x 0F 0x 2 opcode je                        "
 db     "                   0x 85 0x 0F 0x 2 opcode jne                       "


 db     " EXIT                                                                "

 db 0

db     0
 alignhe20
