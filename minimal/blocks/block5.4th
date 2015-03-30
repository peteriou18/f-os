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

 HEADER AND        HERE CELL+ ,                
 mov_edx,# ' Pop @ ,   call_edx              
 mov_ebp,eax           
 call_edx                                                                                                                                                                  "
 and_eax,ebp          
 mov_edx,#  ' Push @ ,   call_edx            
 ret                                    

 ALIGN                    

 FORTH32 CONTEXT ! FORTH32 CURRENT !     

 EXIT 
