
 ;block 4 CONSTANT 0 -1 BL ) QUOTE VARIABLE LIT, ;Word Word: 0x, ', WORD .( PAD Word+ S"
 ; ," make_badword   make_exit  VOCABULARY NOOP compiler
 ; BEGIN AGAIN UNTIL   IF THEN ELSE    ENDOF OF   IMMEDIATES ;WORD   WORD: [ ] ."
 ; .((  Begin  Until  Again  If  Then   Else  hex,  Case  Of  EndOf  EndCase   Do  Loop

 db " FORTH32 CURRENT ! FORTH32 CONTEXT !  "

 db " HEADER CONSTANT   interpret# ,           "
 db " ' HEADER , ' constant# , ' , , ' , ,   ' EXIT ,   "

 db " 0x 0        CONSTANT 0      "
 db " 0x FFFFFFFF CONSTANT -1 "
 db " 0x 20       CONSTANT BL     "
 db " 0x 29       CONSTANT )      "
 db " 0x 22       CONSTANT QUOTE     "

 db " HEADER VARIABLE   interpret# ,    "
 db " ' HEADER , ' variable# , ' , , ' 0 , ' , ,  ' EXIT , "

 db " HEADER LIT,  interpret# , "
 db "  ' lit# , ' lit# , ' , ,  ' , ,  ' EXIT , "

 db " HEADER ;Word     interpret# ,   ' EXIT LIT,  ' , ,    ' EXIT , "

 db " HEADER Word:     interpret# ,  "
 db "        ' HEADER , ' interpret# ,  ' , ,  ;Word "


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

 db "  Word: compiler    ', CONTEXT ', @ ', SFIND ', ,  ;Word "


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



 db " FORTH32 CURRENT !    IMMEDIATES UNLINK "

 db " EXIT "
 db  0

 alignhe20
