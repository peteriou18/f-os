
FORTH32 CURRENT ! ASSEMBLER CONTEXT !  													

HEADER CELL-           HERE CELL+ ,  															
mov_edx,#  ' Pop @ , 	call_edx 																					
sub_eax,4 																				
mov_edx,#  ' Push @ , call_edx 																					
ret 																						


HEADER   hex_dot_value  variable#  , 0xd 0 , , 0xd 0 , ,   								
HEADER   sixes          variable#  , 0xd 0606060606060606 , , 0xd   0606060606060606 , ,
HEADER   efes           variable#  , 0xd 0F0F0F0F0F0F0F0F , , 0xd   0F0F0F0F0F0F0F0F , ,
HEADER   sevens         variable#  , 0xd 0707070707070707 , , 0xd   0707070707070707 , ,
HEADER   zeroes         variable#  , 0xd 3030303030303030 , , 0xd   3030303030303030 , ,
HEADER   hexstr         variable#  , 0xd 3332323536394143 , , 0xd 0 , , 0x 0 ,  			

ASSEMBLER FORTH32 LINK       																


HEADER inverse_hexstr   HERE CELL+ , 													
mov_eax,[] hexstr , 																		
mov_ebx,[] hexstr CELL+ , 																
mov_ecx,[] hexstr CELL+ CELL+ , 															
mov_edx,[] hexstr CELL+ CELL+ CELL+ , 													
bswap_eax  bswap_ebx    bswap_ecx   bswap_edx 											
mov_[],edx hexstr , 																		
mov_[],ecx hexstr CELL+ , 																
mov_[],ebx hexstr CELL+ CELL+ , 															
mov_[],eax hexstr CELL+ CELL+ CELL+ , 													
ret 																						

ALIGN 																					

HEADER (hex_dot)        HERE CELL+ , 															
mov_edx,#  ' Pop @ , 	call_edx 																					
mov_[],eax   hex_dot_value  ,  															
movdqu_xmm0,[]   hex_dot_value  , 														
pxor_xmm1,xmm1 																			
punpcklbw_xmm0,xmm1 																		
movdqa_xmm1,xmm0    																		
movdqu_xmm2,[] efes , 																	
pand_xmm1,xmm2 																			
psllq_xmm0,4 																				
pand_xmm0,xmm2     																		
por_xmm0,xmm1     																		
movdqa_xmm1,xmm0  																		
movdqu_xmm4,[] sixes , 																	
paddb_xmm1,xmm4      																		
psrlq_xmm1,4  																			
pand_xmm1,xmm2     																		
pxor_xmm3,xmm3       																		
psubb_xmm3,xmm1      																		
movdqu_xmm2,[] sevens , 																	
pand_xmm3,xmm2      																		
paddb_xmm0,xmm3     																		
movdqu_xmm2,[] zeroes , 																	
paddb_xmm0,xmm2       																	
movdqu_[],xmm0 hexstr ,   																
ret 																						

ALIGN 								

ASSEMBLER FORTH32 LINK      																


HEADER 2HEX.   HERE CELL+ , 		
mov_edx,#  ' Pop @ ,            call_edx 													
mov_[],eax   hex_dot_value CELL+ ,  														
mov_edx,#  ' (hex_dot) @ ,      call_edx 													
mov_edx,#  ' inverse_hexstr @ , call_edx 													
mov_eax,# hexstr , 																		
mov_edx,#  ' Push @ ,           call_edx 													
mov_edx,#  ' TYPEZ @ ,          call_edx 													
ret 																						


ALIGN 																					

HEADER HEX.   HERE CELL+ , 																
pxor_xmm0,xmm0  																			
movdqu_[],xmm0  hex_dot_value  ,   														
mov_edx,#  ' (hex_dot) @ ,      call_edx 													
mov_edx,#  ' inverse_hexstr @ , call_edx 													
mov_eax,# hexstr CELL+ CELL+ , 																		
mov_edx,#  ' Push @ ,           call_edx 													
mov_edx,#  ' TYPEZ @ ,          call_edx 													
ret 																						

ALIGN 																					
ASSEMBLER FORTH32 LINK       																

HEADER -  	HERE CELL+ ,   																			
mov_edx,# ' Pop @ ,   call_edx 																					
mov_ebp,eax 																				
call_edx 																					
sub_eax,ebp  																				
mov_edx,#  ' Push @ , call_edx 																					
ret 																						

ALIGN 																					

HEADER SWAP-           HERE CELL+ ,
mov_edx,# ' Pop @ ,  call_edx
mov_ebp,eax
call_edx
sub_eax,ebp  neg_eax
mov_edx,#  ' Push @ , call_edx 																					
ret 																						

ALIGN 	

HEADER +  	HERE CELL+ ,   																			
mov_edx,# ' Pop @ ,  call_edx 																					
mov_ebp,eax 																				
call_edx 																					
add_eax,ebp  																				
mov_edx,#  ' Push @ , call_edx 																					
ret 																						

ALIGN 																					
HEADER TIMER@     HERE CELL+ , 															
rdtsc 																					
mov_ebp,edx       																		
mov_edx,#  ' Push @ , call_edx 													
mov_eax,ebp  																				
call_edx     																				
ret          																				

ALIGN 																					

HEADER lit#       HERE CELL+ , 															
mov_eax,[esp+4] 																			
mov_eax,[eax+4] 																			
mov_edx,#  ' Push @ , call_edx 													
add_d[esp+4],4    																		
ret 																						

ALIGN 																					

HEADER 1+         HERE CELL+ , 															
mov_edx,#  ' Pop @ ,            call_edx 													
inc_eax    																				
mov_edx,#  ' Push @ ,           call_edx 													
ret        																				

ALIGN 																					

HEADER 1-         HERE CELL+ ,       
mov_edx,#  ' Pop @ ,            call_edx       
dec_eax            
mov_edx,#  ' Push @ ,           call_edx       
ret        

ALIGN       

HEADER C@         HERE CELL+ , 															
mov_edx,#  ' Pop @ ,            call_edx 													
movzx_eax,b[eax]  																		
mov_edx,#  ' Push @ ,           call_edx 													
ret 																						

ALIGN 																					

HEADER ALLOT      HERE CELL+ ,    														
mov_edx,#  ' Pop @ ,            call_edx 													
add_[],eax ' HERE CELL+ , 																
mov_edx,# ' ALIGN @ ,   call_edx  														
ret 																						

ALIGN 																					

HEADER SLIT          HERE CELL+ ,  														
mov_eax,[esp+4] 																			
add_eax,4     																			
mov_edx,#  ' Push @ ,           call_edx 													
mov_eax,[esp+4]     																		
movzx_ebx,b[eax+4]  																		
inc_ebx  inc_ebx 																			
add_eax,ebx         																		
and_eax,-4          																		
and_ebx,3  																				
setne_bl   																				
shl_ebx,2    																				
add_eax,ebx 																				
mov_[esp+4],eax    																		
ret 																						

ALIGN 																					

HEADER exec_point          HERE CELL+ , 													
mov_eax,[esp+C] 																			
mov_edx,#  ' Push @ ,           call_edx 													
ret 																						

ALIGN 																					

HEADER strcopy            HERE CELL+ , 													
mov_edx,#  ' Pop @ ,            call_edx 													
mov_edi,eax  																				
mov_edx,#  ' Pop @ ,            call_edx 													
mov_esi,eax  																				
movzx_ecx,b[esi]  																		
shr_ecx,2         																		
inc_ecx           																		
cld               																		
rep_movsd         																		
ret    																					

ALIGN 																					

HEADER DUP        HERE CELL+ , 															
mov_edx,#  ' Pop @ ,            call_edx 													
mov_edx,#  ' Push @ ,  call_edx  call_edx 												
ret 																						

ALIGN 																					

HEADER >R         HERE CELL+ , 															
mov_edx,#  ' Pop @ ,            call_edx 													
pop_ebx    																				
pop_ecx    																				
push_eax   																				
push_ecx   																				
push_ebx   																				
ret 																						

ALIGN 																					

HEADER R>         HERE CELL+ , 															
pop_ebx    																				
pop_ecx    																				
pop_eax    																				
push_ecx   																				
push_ebx   																				
mov_edx,#  ' Push @ ,  call_edx 															
ret 																						

ALIGN 																					

HEADER R@         HERE CELL+ , 															
pop_ebx    																				
pop_ecx    																				
pop_eax    																				
push_eax   																				
push_ecx   																				
push_ebx   																				
mov_edx,#  ' Push @ ,  call_edx 															
ret

ALIGN   

HEADER SWAP!         HERE CELL+ ,         
mov_edx,#  ' Pop @ ,   call_edx       
mov_ebp,eax            
call_edx            
mov_[eax],ebp             
ret   

ALIGN 																					

FORTH32 CONTEXT ! FORTH32 CURRENT ! 														

EXIT 																						

