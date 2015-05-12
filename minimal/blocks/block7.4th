ASSEMBLER CURRENT !  ASSEMBLER CONTEXT  !      

                          0x C3 0x 1 opcode ret                       
                          0x CF 0x 1 opcode iretd                     
                          0x F4 0x 1 opcode hlt                       
                          0x FC 0x 1 opcode cld                       
                          0x CE 0x 1 opcode into   
                          0x CC 0x 1 opcode int3
                          0x BA 0x 1 opcode mov_edx,#                 
                          0x B8 0x 1 opcode mov_eax,#                 
                          0x 25 0x 1 opcode and_eax,# 
                          0x 3D 0x 1 opcode cmp_eax,# 
                          0x A9 0x 1 opcode test_eax,#
                          0x A3 0x 1 opcode mov_[],eax                
                          0x A1 0x 1 opcode mov_eax,[]                
                          0x 40 0x 1 opcode inc_eax                   
                          0x 43 0x 1 opcode inc_ebx                   
                          0x 41 0x 1 opcode inc_ecx  
                          0x 48 0x 1 opcode dec_eax
                          0x 58 0x 1 opcode pop_eax                   
                          0x 5B 0x 1 opcode pop_ebx                   
                          0x 59 0x 1 opcode pop_ecx                   
                          0x 50 0x 1 opcode push_eax                  
                          0x 53 0x 1 opcode push_ebx                  
                          0x 51 0x 1 opcode push_ecx                  
                          0x 60 0x 1 opcode pushad                    
                          0x 61 0x 1 opcode popad
                          0x E9 0x 1 opcode jmp
 
                    0x 1D 0x 8B 0x 2 opcode mov_ebx,[]
                    0x 0D 0x 8B 0x 2 opcode mov_ecx,[]
                    0x 15 0x 8B 0x 2 opcode mov_edx,[]
                    0x 3D 0x 8B 0x 2 opcode mov_edi,[]
                    0x 15 0x 89 0x 2 opcode mov_[],edx
                    0x 0D 0x 89 0x 2 opcode mov_[],ecx
                    0x 1D 0x 89 0x 2 opcode mov_[],ebx 
                    0x 05 0x C7 0x 2 opcode mov_d[],#
                    0x 05 0x C6 0x 2 opcode mov_b[],#
                    0x 28 0x 89 0x 2 opcode mov_[eax],ebp
                    0x 06 0x 88 0x 2 opcode mov_[esi],al 
                    0x 05 0x 01 0x 2 opcode add_[],eax   
                    0x D8 0x F7 0x 2 opcode neg_eax  
                    
                    0x C8 0x 0F 0x 2 opcode bswap_eax
                    0x CB 0x 0F 0x 2 opcode bswap_ebx
                    0x C9 0x 0F 0x 2 opcode bswap_ecx
                    0x CA 0x 0F 0x 2 opcode bswap_edx
                    
                    0x 31 0x 0F 0x 2 opcode rdtsc
                     
                    0x D2 0x FF 0x 2 opcode call_edx
                    0x C5 0x 89 0x 2 opcode mov_ebp,eax
                    0x C1 0x 89 0x 2 opcode mov_ecx,eax
                    0x E8 0x 89 0x 2 opcode mov_eax,ebp
                    0x C2 0x 89 0x 2 opcode mov_edx,eax
                    0x C6 0x 89 0x 2 opcode mov_esi,eax
                    0x C7 0x 89 0x 2 opcode mov_edi,eax
                    0x F8 0x 89 0x 2 opcode mov_eax,edi
                    0x C8 0x 89 0x 2 opcode mov_eax,ecx
                    0x D0 0x 89 0x 2 opcode mov_eax,edx
                    0x D5 0x 89 0x 2 opcode mov_ebp,edx
                    0x A5 0x F3 0x 2 opcode rep_movsd
                    0x AB 0x 66 0x 2 opcode stosw
                    0x D8 0x 01 0x 2 opcode add_eax,ebx
                    0x E8 0x 01 0x 2 opcode add_eax,ebp
                    0x CF 0x 01 0x 2 opcode add_edi,ecx
                    0x CB 0x 21 0x 2 opcode and_ebx,ecx
                    0x E8 0x 21 0x 2 opcode and_eax,ebp
                    0x D8 0x 29 0x 2 opcode sub_eax,ebx
                    0x C5 0x 2B 0x 2 opcode sub_eax,ebp
                    0x C0 0x 31 0x 2 opcode xor_eax,eax
                    0x DB 0x 31 0x 2 opcode xor_ebx,ebx
                    0x C9 0x 31 0x 2 opcode xor_ecx,ecx
                    0x 35 0x 81 0x 2 opcode xor_d[],# 
                    0x 0D 0x 81 0x 2 opcode or_d[],#
                    0x 25 0x 81 0x 2 opcode and_d[],#
                    0x E8 0x 39 0x 2 opcode cmp_eax,ebp
                    0x F8 0x 39 0x 2 opcode cmp_eax,edi
                    0x F0 0x 39 0x 2 opcode cmp_eax,esi
                    0x 3D 0x 81 0x 2 opcode cmp_d[],#
                    0x C0 0x 85 0x 2 opcode test_eax,eax
                    
                    
  
  FORTH32 CONTEXT ! FORTH32 CURRENT !
  EXIT                                                
