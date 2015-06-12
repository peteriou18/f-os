;block1
 db     " TYPEZ                                                                         "
 db     " 0x 7 LOAD        0x 2 LOAD      "
 db     " 0x 3 LOAD        0x 5 LOAD      "
 db     " 0x 4 LOAD        0x 6 LOAD      "
 db     " 0x 8 LOAD        0x 9 LOAD      "

 db     " .( End of loads)   "



 db     "  0x  20202020 CONSTANT 4Spaces "
 db     "  0x  54495845 CONSTANT 'exit'  "

 db     " WORD: key      KEY   eng  ;WORD "

 db     " WORD: do_backspace  HEX.  1- 1-  ;WORD   "

 db     " WORD: ?do   Case           "
 db     "                  DUP hex, 1C = Of   Pop  -1            EndOf  "
 db     "                      hex, 8  = Of      do_backspace    EndOf  "
 db     "                  0   "
 db     " EndCase     ;WORD "

 db     " WORD: EXPECT    4Spaces  hex, 2000 ! hex, 1FFF        "
 db     "                 Begin  1+ DUP   key   SWAP  C! DUP   C@  ?do  Until      "
 db     "                 DUP 4Spaces SWAP! CELL+ DUP 'exit' SWAP! CELL+  0 SWAP!  ;WORD "


 db     ' WORD: F-SYSTEM  Begin CR TIMER@ 2HEX. ."  OK>" EXPECT  CR 0 >IN ! INTERPRET Again ;WORD '

 db     "   F-SYSTEM   "

 db     " CR .( ----------) CR "


 db     "   "

 db     " CR .( Here:) HERE HEX. .( Ticks:) TIMER@ 2HEX. EXIT    "
 db     0
;

 alignhe20
