FORTH32 CURRENT ! FORTH32 CONTEXT !  


HEADER CONSTANT   interpret# ,           
                ' HEADER , ' constant# , ' , , ' , ,   ' EXIT ,   

0x 0  CONSTANT 0      
0x 29 CONSTANT )      
0x 22 CONSTANT QUOTE     

HEADER VARIABLE   interpret# ,    
                ' HEADER , ' variable# , ' , , ' 0 , ' , ,  ' EXIT , 

HEADER LIT,  interpret# , 
                ' lit# , ' lit# , ' , ,  ' , ,  ' EXIT , 

HEADER ;Word     interpret# ,   
                ' EXIT LIT,  ' , ,    ' EXIT , 

HEADER Word:     interpret# ,  
                ' HEADER , ' interpret# ,  ' , ,         ;Word 


Word: 0x,       ' 0x ,  '  LIT, ,                         ;Word 

Word: ',        ' ' ,  ' , ,                              ;Word       

Word: WORD      ', BLOCK  ', CELL+  ', CELL+  ', @  ', HERE  ', (WORD)  ;Word  



Word: .(        ', )  ', WORD  ', HERE  ', 1+  ', TYPEZ                 ;Word 

Word: PAD       0x, HERE 0x, 200  ', +                                  ;Word 

Word: Word+     ', BLOCK  ', CELL+  ', CELL+  ', @  ', PAD  ', (WORD)                               ;Word  

Word: S"        ', QUOTE  ', BLOCK  ', CELL+  ', CELL+  ', @  ', PAD  ', (WORD) ', PAD              ;Word 

Word: exec.     ', exec_point ', HEX.                                                               ;Word 

Word: ,"        ', lit#  ', SLIT   ', ,  ', HERE  ', QUOTE  ', WORD  ', C@ ', 1+ ', 1+ ', ALLOT     ;Word 

Word: @HEX.     ', DUP ', @ ',  HEX. ',  CELL+  ;Word

Word: make_badword     
                ," BADWORD"  ', DUP  ', HERE  ', strcopy   ', C@  ', CELL+  ', ALLOT  
                0x, 0  ', ,  ', lit#  ' BADWORD @ ,  ', ,  ', lit#  ', ABORT     ', ,               ;Word  

Word: make_exit
                 ," EXIT"  ', DUP  ', HERE ', strcopy  ', C@ ', CELL+  ', ALLOT  ', ,  ', lit#  ', EXIT ', ,  ;Word
                 
Word: VOCABULARY
                ', VARIABLE   ', HERE ', CELL  ', HERE ', make_badword  
                ', HERE  ', >R  ', make_exit ', R>  ', SWAP!                                     ;Word
                 
Word: NOOP        ;Word

Word: compiler    ', CONTEXT ', @ ', SFIND ', ,  ;Word
                
Word: BEGIN    ', HERE ', CELL-                  ;Word
Word: AGAIN    ', lit#    '  BRANCH ,  ', , ', , ;Word 
Word: UNTIL    ', lit#    ' ?BRANCH ,  ', , ', , ;Word

Word: IF       ', lit#    ' ?BRANCH ,  ', , ', HERE 0x, 0 ', , ;Word 
Word: THEN     ', HERE ', SWAP! ;Word
Word: ELSE     ', HERE ', CELL+ ', CELL+  ', SWAP!  ', lit#    ' BRANCH ,  ', , ', HERE 0x, 0 ', , ;Word 

VOCABULARY IMMEDIATES
IMMEDIATES CURRENT !  

Word: ;WORD    ', lit#  ' EXIT ,  ', ,  ', break ;Word

FORTH32 CURRENT !
IMMEDIATES FORTH32 LINK

IMMEDIATES CONTEXT !

' compiler  ' BADWORD CELL+ !

FORTH32 CONTEXT !   IMMEDIATES UNLINK

Word: WORD:
                ', Word:  BEGIN ', PARSE ', IMMEDIATES ', SFIND  ', EXECUTE   AGAIN  ;Word 
                
IMMEDIATES CURRENT !

WORD: [   IMMEDIATES CONTEXT @ LINK       ;WORD
WORD: ]   IMMEDIATES UNLINK     ;WORD

WORD: 0x_as_lit,    0x, ;WORD


WORD: ."      ,"  [ ' 1+ LIT, ]  , [ ' TYPEZ LIT, ] ,  ;WORD 

FORTH32 CURRENT !    IMMEDIATES UNLINK
 
 EXIT
