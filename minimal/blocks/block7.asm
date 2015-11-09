
 ;block 7
 ; - + hex_dot_value  sixes   efes   sevens     zeroes      hexstr         
;  inverse_hexstr   (hex_dot)  2HEX.   HEX.  
; set_cursor VARIABLE  0x,  ',  WORD  .( PAD Word+   S"  ,"       
 ;  make_badword   make_exit	VOCABULARY NOOP compiler  ( 
 ; BEGIN AGAIN UNTIL   IF THEN ELSE    ENDOF OF   
; IMMEDIATES ;WORD   WORD: [ ] ." .((	((                              CONSTANT 0 1 -1 BL ) QUOTE LIT, ;Word Word: 
 ;  Begin  Until  Again	If  Then   Else  hex,  Case  Of  EndOf	EndCase   Do  Loop
; DOES> CHAR B, W, CREATE 


 db " ASSEMBLER FORTH32 LINK    "
 db " FORTH32 CURRENT ! ASSEMBLER CONTEXT !    "

 db " HEADER -      HERE CELL+ ,      "
 db " mov_edx,# ' Pop @ ,     "
 db " call_edx           "
 db " mov_ebp,eax                                 "
 db " call_edx          "
 db " sub_eax,ebp       "
 db " mov_edx,#  ' Push @ ,                       "
 db " call_edx    "
 db " ret         "

 db " ALIGN          "

 db " HEADER +        HERE CELL+ ,                "		       ; code field
 db " mov_edx,# ' Pop @ ,   call_edx              "
 db " mov_ebp,eax           "
 db " call_edx                                                                                                                                                                  "
 db " add_eax,ebp          "
 db " mov_edx,#  ' Push @ ,   call_edx            "
 db " ret                                     "

 db " HEADER   hex_dot_value  variable#  , 0xd 0 , , 0xd 0 , ,                                  "
 db " HEADER   sixes          variable#  , 0xd 0606060606060606 , , 0xd   0606060606060606 , ,  "
 db " HEADER   efes           variable#  , 0xd 0F0F0F0F0F0F0F0F , , 0xd   0F0F0F0F0F0F0F0F , ,  "
 db " HEADER   sevens         variable#  , 0xd 0707070707070707 , , 0xd   0707070707070707 , ,  "
 db " HEADER   zeroes         variable#  , 0xd 3030303030303030 , , 0xd   3030303030303030 , ,  "
 db " HEADER   hexstr         variable#  , 0xd 3332323536394143 , , 0xd 20 , , 0x 20 ,            "

 db " ASSEMBLER FORTH32 LINK                           "

 db " ALIGN    "

 db " HEADER    inverse_hexstr  HERE CELL+ ,           "
 db " mov_eax,[] hexstr ,                              "
 db " mov_ebx,[] hexstr CELL+ ,                        "
 db " mov_ecx,[] hexstr CELL+ CELL+ ,                  "
 db " mov_edx,[] hexstr CELL+ CELL+ CELL+ ,            "
 db " bswap_eax  bswap_ebx    bswap_ecx   bswap_edx    "
 db " mov_[],edx hexstr ,                              "
 db " mov_[],ecx hexstr CELL+ ,                        "
 db " mov_[],ebx hexstr CELL+ CELL+ ,                  "
 db " mov_[],eax hexstr CELL+ CELL+ CELL+ ,            "
 db " ret                                              "

 db " ALIGN                                            "

 db " HEADER (hex_dot) HERE CELL+ ,                    "

 db " mov_edx,#  ' Pop @ ,                             "
 db " call_edx                                                                                                                                                                  "
 db " mov_[],eax   hex_dot_value  ,                    "
 db " movdqu_xmm0,[]   hex_dot_value  ,                "
 db " pxor_xmm1,xmm1                                   "
 db " punpcklbw_xmm0,xmm1                              "
 db " movdqa_xmm1,xmm0                                 "
 db " movdqu_xmm2,[] efes ,                            "
 db " pand_xmm1,xmm2                                   "
 db " psllq_xmm0,4                                     "
 db " pand_xmm0,xmm2                                   "
 db " por_xmm0,xmm1                                    "
 db " movdqa_xmm1,xmm0                                 "
 db " movdqu_xmm4,[] sixes ,                           "
 db " paddb_xmm1,xmm4                                  "
 db " psrlq_xmm1,4                                     "
 db " pand_xmm1,xmm2                                   "
 db " pxor_xmm3,xmm3                                   "
 db " psubb_xmm3,xmm1                                  "
 db " movdqu_xmm2,[] sevens ,                          "
 db " pand_xmm3,xmm2                                   "
 db " paddb_xmm0,xmm3                                  "
 db " movdqu_xmm2,[] zeroes ,                     "
 db " paddb_xmm0,xmm2                                  "
 db " movdqu_[],xmm0 hexstr ,                   "
 db " ret                                              "

 db " ALIGN                                           "

 db " ASSEMBLER FORTH32 LINK                        "

 db " HEADER 2HEX.   HERE CELL+ ,                  "
 db " mov_edx,#  ' Pop @ ,            call_edx "
 db " mov_[],eax   hex_dot_value CELL+ ,                "
 db " mov_edx,#  ' (hex_dot) @ ,      call_edx       "
 db " mov_edx,#  ' inverse_hexstr @ , call_edx         "

 db " mov_eax,# hexstr ,                             "
 db " mov_edx,#  ' Push @ ,           call_edx         "
 db " mov_edx,#  ' TYPEZ @ ,          call_edx        "
 db " ret                                              "

 db " ALIGN       "

 db " HEADER HEX.   HERE CELL+ ,                  "
 db " pxor_xmm0,xmm0                             "
 db " movdqu_[],xmm0  hex_dot_value  ,           "
 db " mov_edx,#  ' (hex_dot) @ ,      call_edx   "
 db " mov_edx,#  ' inverse_hexstr @ , call_edx        "
 db " mov_eax,# hexstr CELL+ CELL+  ,            "
 db " mov_edx,#  ' Push @ ,           call_edx        "
 db " mov_edx,#  ' TYPEZ @ ,          call_edx     "
 db " ret                                            "

 db " ALIGN        "
db " HEADER set_cursor HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx "
db " mov_ecx,eax "
db " mov_edx,# 0x 3D4 , "
db " mov_eax,# 0x 030F , "
db " mov_ah,cl "
db " out_dx,ax "
db " mov_eax,# 0x 040E , "
db " mov_ah,ch "
db " out_dx,ax "
db " ret "
db " ALIGN    "

 db " FORTH32 CURRENT ! FORTH32 CONTEXT !  "



 db " Word: VARIABLE    ' HEADER , ' variable# ,  ' , , ' 0 , ' , , ;Word "

 db " Word: 0x,     ' 0x ,  '  LIT, ,    ;Word "

 db " Word: ',      ' ' ,  ' , ,  ;Word       "

 db " Word: WORD       ', BLOCK  ', CELL+  ', CELL+  ', @  ', HERE  ', (WORD)  ;Word  "



 db " Word: .(   ', )  ', WORD  ', HERE  ', 1+  ', TYPEZ  ;Word "

 db " Word: PAD          0x, HERE 0x, 200  ', +   ;Word "

 db " Word: Word+       ', BLOCK  ', CELL+  ', CELL+  ', @  ', PAD  ', (WORD)  ;Word  "

 db ' Word: S"  '
 db "  ', QUOTE  ', BLOCK  ', CELL+  ', CELL+  ', @  ', PAD  ', (WORD) ', PAD  ;Word "

 db ' Word: ,"  '
 db " ', lit#  ', SLIT   ', ,  ', HERE  ', QUOTE  ', WORD  ', C@ ', 1+ ', 1+ ', ALLOT    ;Word "

 db " Word: make_badword          "
 db ' ," BADWORD"   '
 db "  ', DUP  "
 db "  ', HERE ', strcopy  ', C@ ', CELL+ ', ALLOT "
 db " 0x, 0 ', , ', lit#  ' BADWORD @ ,  ', , ', lit# ', ABORT ', , ;Word  "

 db " Word: make_exit           "
 db ' ," EXIT" '
 db "  ', DUP  "
 db "  ', HERE ', strcopy  ', C@ ', CELL+  ', ALLOT "
 db " ', ,  ', lit#  ', EXIT ', ,  ;Word  "


 db " Word: VOCABULARY               "
 db " ', VARIABLE   ', HERE ', CELL- "
 db " ', HERE ', make_badword        "
 db " ', HERE  ', >R  ', make_exit   "
 db " ', R>  ', SWAP!          ;Word "

 db " Word: NOOP        ;Word     "

 db " Word: compiler    ', CONTEXT ', @ ', SFIND ', ,  ;Word "

 db " Word: (           ', )  ', WORD ;Word "

 db " Word: BEGIN    ', HERE ', CELL-   ;Word       "
 db " Word: AGAIN    ', lit#    '  BRANCH ,  ', , ', , ;Word "
 db " Word: UNTIL    ', lit#    ' ?OF ,  ', , ', , ;Word "

 db " Word: IF       ', lit#    ' ?BRANCH ,  ', ,    ', HERE  0x, 0 ', , ;Word   "
 db " Word: THEN     ', HERE    ', CELL- ', SWAP!  ;Word "
 db " Word: ELSE     ', lit#    ' BRANCH ,  ', ,   ', HERE ', >R   0x, 0 ', ,    ', HERE ', CELL-  ', SWAP! ', R>   ;Word   "

 db " Word: ENDOF       ',   COMPILE ', BRANCH  ', HERE ', >R  ', COMPILE ', 0 ', THEN  ', R> ;Word "
 db " Word: OF          ',   COMPILE ', ?OF     ', HERE        ', COMPILE ', 0                ;Word "


 db " VOCABULARY IMMEDIATES "
 db " IMMEDIATES CURRENT !  "

 db " Word: ;WORD    ', lit#  ' EXIT ,  ', ,  ', break ;Word  "

 db " FORTH32 CURRENT ! "
 db " IMMEDIATES FORTH32 LINK "


 db " IMMEDIATES CONTEXT ! "

 db " ' compiler  ' BADWORD CELL+ !   "

 db " FORTH32 CONTEXT !   IMMEDIATES UNLINK "

 db " Word: WORD: "
 db " ', Word:  BEGIN ', PARSE ', IMMEDIATES ', SFIND  ', EXECUTE   AGAIN  ;Word "


 db " IMMEDIATES CURRENT ! "

 db " WORD: [   IMMEDIATES CONTEXT @ LINK       ;WORD "
 db " WORD: ]   IMMEDIATES UNLINK     ;WORD "

 db ' WORD: ."      ," '
 db " COMPILE 1+    COMPILE TYPEZ  ;WORD "

 db " WORD: .((     .(              ;WORD "
 db " WORD: ((   ) WORD             ;WORD   "



 db " WORD: Begin       BEGIN  ;WORD "
 db " WORD: Until       UNTIL  ;WORD "
 db " WORD: Again       AGAIN  ;WORD "
 db " WORD: If          IF     ;WORD "
 db " WORD: Then        THEN   ;WORD "
 db " WORD: Else        ELSE   ;WORD "

 db " WORD: hex,        0x,     ;WORD "

 db " WORD: Case       hex,  0  ;WORD "
 db " WORD: Of         COMPILE ?OF     HERE    COMPILE 0    ;WORD "
 db " WORD: EndOf      COMPILE BRANCH  HERE >R COMPILE 0 THEN  R>    ;WORD "
 db " WORD: EndCase    Begin DUP   0 <>   If   -1 Else   THEN  0 Then   Until Pop  ;WORD "
	     ;
 db " WORD: Do        BEGIN    COMPILE >R   COMPILE >R   ;WORD "
 db " WORD: Loop      COMPILE R>   COMPILE 1+   COMPILE DUP   COMPILE R@   COMPILE <   COMPILE R>   COMPILE SWAP "
 db "                 COMPILE ?OF ,             COMPILE Pop   COMPILE Pop ;WORD      "


 db " WORD: DOES>  COMPILE COMPILE COMPILE BRANCH   HERE  CELL+ CELL+ CELL+  LIT,  COMPILE ,  ;Word   ;WORD "

 db " FORTH32 CURRENT !    IMMEDIATES UNLINK "

 db " WORD: CHAR      PARSE HERE 1+ C@  ;WORD "
 db " WORD: B,        HERE C!  [ ' HERE CELL+ LIT, ]  @ 1+ [ ' HERE CELL+ LIT, ] ! ;WORD "
 db " WORD: W,	HERE W! [ ' HERE CELL+ LIT, ] @ 2+ [ ' HERE CELL+ LIT, ] ! ;WORD "

 db " WORD: CREATE      HEADER variable# , ;WORD "

 db " EXIT "
 db  0

 alignhe20
