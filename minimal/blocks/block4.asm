
 ;block 4 CONSTANT 0 ) " VARIABLE LIT, ;Word Word: 0x, ', .( PAD Word+ S" exec.
 ; ," @HEX. make_badword   make_exit  VOCABULARY NOOP compiler
 ; BEGIN AGAIN UNTIL IF THEN ELSE IMMEDIATES ;WORD   WORD: [ ] 0x_as_lit, ."
 db " FORTH32 CURRENT ! FORTH32 CONTEXT !  "

 db " HEADER CONSTANT   interpret# ,           "
 db " ' HEADER , ' constant# , ' , , ' , ,   ' EXIT ,   "

 db " 0x 0  CONSTANT 0      "
 db " 0x 20 CONSTANT BL     "
 db " 0x 29 CONSTANT )      "
 db " 0x 22 CONSTANT QUOTE     "

 db " HEADER VARIABLE   interpret# ,    "
 db " ' HEADER , ' variable# , ' , , ' 0 , ' , ,  ' EXIT , "

 db " VARIABLE IJK 0 , "

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

 db " Word: exec.   ', exec_point ', HEX. ;Word "

 db ' Word: ,"  '
 db " ', lit#  ', SLIT   ', ,  ', HERE  ', QUOTE  ', WORD  ', C@ ', 1+ ', 1+ ', ALLOT    ;Word "

 db " Word: @HEX.  ', DUP ', @ ',  HEX. ',  CELL+ ;Word "

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

 db ' WORD: ."      ,"  '
 db "  [ ' 1+ LIT, ]  , [ ' TYPEZ LIT, ] ,  ;WORD  "


 db " Word: Begin       ', HERE ', CELL-  ;Word "
 db " Word: Until       ', lit#    ' ?OF ,  ', , ', , ;Word "
 db " Word: If          ', lit#    ' ?BRANCH ,  ', ,    ', HERE  0x, 0 ', ,  ;Word "
 db " Word: Then        ', HERE ', CELL- ', SWAP! ;Word "
 db " Word: Else        ', lit#    ' BRANCH ,  ', ,   ', HERE ', >R   0x, 0 ', ,    ', HERE ', CELL-  ', SWAP! ', R> ;Word   "

 db " WORD: 0x_as_lit,    0x, ;WORD "

 db " WORD: Case  0x_as_lit,  0  ;WORD "
 db " WORD: Of    [  ' ?OF  LIT,    ] ,   HERE  0x_as_lit,  0 ,  ;WORD   "
 db " WORD: EndOf    [ ' BRANCH LIT, ] , HERE >R 0x_as_lit,  0 ,  HERE  CELL-  SWAP! R>   ;WORD "
 db " WORD: EndCase   Begin DUP  0x_as_lit, 0 <>   If        "
 db "                                              0x_as_lit, FFFFFFFF Else  HERE CELL- SWAP!  0x_as_lit, 0 Then   "
 db "                 Until Pop  ;WORD "

 ;db " WORD: DO        HERE CELL-  [ ' >R LIT, ] , [ ' >R LIT, ] ,  ;WORD "
 ;db " WORD: LOOP     [ ' R> LIT, ] ,  [ ' 1+ LIT, ] , [ ' DUP LIT, ] ,  [ ' R@ LIT, ] , "
 ;db "       [ ' < LIT, ] ,  [ ' R> LIT, ] ,  [ ' SWAP LIT, ] , [ ' ?OF LIT, ] , , ;WORD "               ;

 db " WORD: DO          [ ' IJK LIT, ] , [ ' CELL+ LIT, ] , [ ' ! LIT, ] ,  HERE CELL- [ ' IJK LIT, ] , [ ' ! LIT, ] , ;WORD "
; db " WORD: LOOP       [ ' IJK LIT, ] ,   [ ' @ LIT, ] , [ ' 1+ LIT, ] , [ ' DUP LIT, ] , [ ' IJK LIT, ] , [ ' CELL+ LIT, ] , [ ' @ LIT, ] , "
; db "                  [ ' < LIT, ] , [ ' ?OF LIT, ] , , ;WORD "

  ;low high >R >R

  ;R> low
  ;1+ DUP low+ low+
  ;R@ low+ low+ high
  ;= low+ flag

 db " FORTH32 CURRENT !    IMMEDIATES UNLINK "

 db " EXIT "
 db  0

 alignhe20
