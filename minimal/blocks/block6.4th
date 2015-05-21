FORTH32 CONTEXT !   FORTH32 CURRENT !  

VARIABLE key     
VARIABLE key_flags 
VARIABLE idtr 0 , 
VOCABULARY interrupts 


ASSEMBLER CONTEXT ! ASSEMBLER FORTH32 LINK  

WORD: forward>      HERE  0 ,   HERE        ;WORD 
WORD: >forward      HERE  SWAP- SWAP!       ;WORD 
WORD: backward<     HERE                    ;WORD 
WORD: <backward     HERE CELL+ -  ,         ;WORD 

ASSEMBLER  FORTH32 LINK  

HEADER make_interrupt_gate        HERE CELL+ ,   
mov_edx,# ' Pop @ ,   call_edx          
mov_ecx,eax 
sidt_[]  idtr  , 
mov_edi,[]  idtr  0x 2 +  ,   
shl_ecx,3         
add_edi,ecx       
call_edx          
push_eax          
stosw             
mov_eax,# 0x 8 ,  
stosw             
mov_eax,# 0x 8E00 , 
stosw     
pop_eax   
shr_eax,16        
stosw             
ret 

ALIGN      

interrupts CURRENT !  interrupts ASSEMBLER LINK  interrupts CONTEXT ! 

 WORD: by_0_msg      ." Divide by zero:"            ;WORD 
 WORD: debug_msg     ." Debug:"                     ;WORD 
 WORD: nmi_msg       ." NMI"                        ;WORD 
 WORD: break_msg     ." BREAKPOINT"                 ;WORD 
 WORD: overflow_msg  ." Overflow"                   ;WORD 
 WORD: bound_msg     ." Bound exception"            ;WORD 
 WORD: ud_msg        HEX. ." Invalid opcode"        ;WORD 
 WORD: nomath_msg    ." No Math exception"          ;WORD 
 WORD: df_msg        ." Double fault"               ;WORD 
 WORD: mf_msg        ." Coprocessor segment fault"  ;WORD 
 WORD: tss_msg       ." Invalid TSS"                ;WORD 
 WORD: np_msg        ." Segment not present"        ;WORD 
 WORD: ss_msg        ." Stack segment fault"        ;WORD 
 WORD: gp_msg        ." General protection"         ;WORD 
 WORD: pf_msg        ." Page fault"                 ;WORD 

 WORD: mf_msg        ." Floating point error"       ;WORD 
 WORD: ac_msg        ." Alignment check"            ;WORD 
 WORD: mc_msg        ." Machine check"              ;WORD 
 WORD: xm_msg        ." SIMD FP exception"          ;WORD 

HEADER div_by_zero      HERE CELL+ , 
mov_eax,# '  by_0_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN     

HEADER debug_int   HERE CELL+ , 
mov_eax,# '  debug_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx
iretd 

ALIGN 

HEADER nmi_int   HERE CELL+ , 
mov_eax,# '  debug_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN 

HEADER break_int HERE CELL+ , 
mov_eax,# '  break_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN    

HEADER overflow HERE CELL+ , 
mov_eax,# '  overflow_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN      

HEADER bound_int HERE CELL+ , 
mov_eax,# '  bound_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN      

HEADER ud_int HERE CELL+ , 
mov_eax,[esp] 
mov_edx,# ' Push @ ,   call_edx 
mov_eax,# ' ud_msg , 
call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
hlt iretd 

ALIGN  

HEADER nomath_int HERE CELL+ , 
mov_eax,# ' nomath_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN      

HEADER df_int HERE CELL+ , 
mov_eax,# ' df_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN 

HEADER mf_int HERE CELL+ , 
mov_eax,# ' mf_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx
iretd 

ALIGN      

HEADER tss_int HERE CELL+ , 
mov_eax,# ' tss_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN 

HEADER np_int HERE CELL+ , 
mov_eax,# ' np_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx
iretd 

ALIGN 

HEADER ss_int HERE CELL+ , 
mov_eax,# ' ss_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN  

HEADER gp_int HERE CELL+ , 
mov_eax,# ' gp_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN   

HEADER pf_int HERE CELL+ , 
mov_eax,# ' pf_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN      

HEADER mf_int HERE CELL+ , 
mov_eax,# ' mf_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN      

HEADER ac_int HERE CELL+ , 
mov_eax,# ' ac_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN      

HEADER mc_int HERE CELL+ , 
mov_eax,# ' mc_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN      

HEADER xm_int HERE CELL+ , 
mov_eax,# ' xm_msg , 
mov_edx,# ' Push @ , call_edx   
mov_edx,# ' EXECUTE @ , call_edx   
iretd 

ALIGN      

HEADER key_int    HERE  CELL+  , 
pushad 
xor_eax,eax 
in_al,60h 
cmp_eax,# 0x 58 , 
je  forward> 
cmp_eax,# 0x 3A , 
je forward> 
cmp_eax,# 0x 2A , 
je forward> 
cmp_eax,# 0x AA  , 
je forward> 
cmp_eax,# 0x 36  , 
je forward> 
cmp_eax,# 0x B6  , 
je forward> 
cmp_eax,# 0x BA  , 
je forward> 
test_eax,# 0x 80 , 
jne forward> 
mov_[],eax  key , 
>forward 
add_[],eax 0x B8000 ,  
eoi 
popad 
iretd 

>forward 
eoi 
popad 
iretd 

>forward 
and_d[],# key_flags ,  0x FFFC00FF  , 
eoi 
popad 
iretd 

>forward 
or_d[],# key_flags , 0x 1FF00 , 
eoi 
popad 
iretd 


>forward 
and_d[],# key_flags ,  0x FFFC00FF  , 
eoi 
popad 
iretd 


>forward 
or_d[],# key_flags , 0x 2FF00 , 
eoi 
popad 
iretd 


>forward 
xor_d[],# key_flags , 0x FF , 
eoi 
popad 
iretd 

 >forward 
backward< DUP 
in_al,64h 
test_eax,# 0x 2 , 
jne <backward 
mov_eax,# 0x FE , 
out_64h,al 
jmp <backward  

ALIGN      


FORTH32 CONTEXT ! FORTH32 CURRENT ! 


EXIT
