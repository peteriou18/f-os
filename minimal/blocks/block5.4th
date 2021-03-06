FORTH32 CURRENT ! ASSEMBLER CONTEXT !    

 HEADER BRANCH          HERE   CELL+ , 
  mov_eax,[esp+4]                        
  mov_eax,[eax+4]          
  push_eax                 
  mov_edx,#  ' Push @ ,           call_edx      
  mov_edx,#  ' HEX. @ ,           call_edx  
  pop_eax 
  mov_[esp+4],eax     
  ret    

 ALIGN 

 HEADER ?BRANCH          HERE   CELL+ , 
 mov_ecx,[esp+4]                        
 mov_ebp,[ecx+4]         
 add_ecx,4     
 mov_edx,#  ' Pop @ ,            call_edx      
 test_eax,eax 
 cmove_ecx,ebp    
 mov_eax,ecx       
 push_eax                 
 push_ecx                 
 mov_edx,#  ' Push @ ,           call_edx      
 mov_edx,#  ' HEX. @ ,           call_edx      
 pop_ecx    
 pop_eax 
 mov_[esp+4],ecx     
 ret    

 ALIGN 
 
 HEADER ?OF         HERE   CELL+ , 
 mov_ecx,[esp+4]        
 mov_ebp,[ecx+4]          
 add_ecx,4     
 mov_edx,#  ' Pop @ ,   call_edx      
 test_eax,eax 
 cmovne_ecx,ebp   
 mov_eax,ecx      
 mov_[esp+4],ecx     
 ret   

 ALIGN 

 HEADER AND        HERE CELL+ ,                
 mov_edx,# ' Pop @ ,   call_edx              
 mov_ebp,eax           
 call_edx                                                                                                                                                                  "
 and_eax,ebp          
 mov_edx,#  ' Push @ ,   call_edx            
 ret                                    

 ALIGN                    

 HEADER =        HERE CELL+ ,  
 mov_edx,# ' Pop @ ,   call_edx              
 mov_ebp,eax           
 call_edx                                                                                                                                                                  "
 cmp_eax,ebp          
 setne_al            
 and_eax,# 0x FF , 
 neg_eax   
 mov_edx,#  ' Push @ ,   call_edx            
 ret                                    
                                                
 ALIGN 
 
 HEADER <>        HERE CELL+ ,                
 mov_edx,# ' Pop @ ,   call_edx          
 mov_ebp,eax           
 call_edx                                                                                                                                                                  "
 cmp_eax,ebp          
 setne_al        
 and_eax,# 0x FF , 
 neg_eax   
 mov_edx,#  ' Push @ ,   call_edx            
 ret                                    
 
 ALIGN                  
 
 HEADER stop      HERE CELL+ ,
 hlt
 ret
 
 ALIGN
 
 HEADER break     HERE CELL+ ,
 add_d[esp+],# 0x 10 , 0x 8 ,
 ret
 
 ALIGN
 
 HEADER WITHIN     HERE CELL+ , 	    .( x low high )
 mov_edx,# ' Pop @ ,   call_edx              
 mov_esi,eax 
 call_edx    
 mov_edi,eax 
 call_edx    
 xor_ebx,ebx 
 xor_ecx,ecx 
 cmp_eax,edi 
 setnc_bl    
 cmp_eax,esi 
 setbe_cl    
 xor_eax,eax 
 and_ebx,ecx 
 sub_eax,ebx 
 mov_edx,#  ' Push @ ,   call_edx            
 ret 

 ALIGN     
 
 HEADER rWITHIN     HERE CELL+ ,       .(	low high x )
 mov_edx,# ' Pop @ ,   call_edx            
 mov_ebp,eax 
 call_edx    
 mov_edi,eax 
 call_edx    
 mov_esi,eax 
 xor_ebx,ebx 
 xor_ecx,ecx 
 mov_eax,ebp 
 cmp_eax,edi 
 setnc_bl    
 cmp_eax,esi 
 setc_cl    
 xor_eax,eax 
 and_ebx,ecx 
 sub_eax,ebx 
 mov_edx,#  ' Push @ ,   call_edx          
 ret 

 ALIGN     

 HEADER SP@ HERE CELL+ , 
 mov_edx,# ' Pop @ , call_edx   
 mov_edx,# ' Push @ , call_edx  
 mov_eax,ebx 
 add_eax,# 0x 8000 , 
 call_edx 
 ret 

 FORTH32 CONTEXT ! FORTH32 CURRENT !     

 EXIT 
