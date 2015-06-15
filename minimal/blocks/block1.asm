;block1
 db     " TYPEZ                                                                         "
 db     " 0x 7 LOAD        0x 2 LOAD      "
 db     " 0x 3 LOAD        0x 5 LOAD      "
 db     " 0x 4 LOAD        0x 6 LOAD      "
 db     " 0x 8 LOAD        0x 9 LOAD      "

 db     " .( End of loads)   "

 db     "   "

 db     "  0x  20202020 CONSTANT 4Spaces "
 db     "  0x  54495845 CONSTANT 'exit'  "
 db     "  0x  400      CONSTANT tibsize "
 db     "  VARIABLE tib tibsize ALLOT     "


 db     " WORD: key      KEY   eng  ;WORD "

 db     " WORD: do_backspace  1- 1- hex, 082008 SP@ TYPEZ Pop   ;WORD   "

 db     " WORD: ?do   Case           "
 db     "                  DUP hex, 1C = Of   Pop  -1            EndOf  "
 db     "                      hex, E  = Of   do_backspace 0     EndOf  "
 db     "                  0   "
 db     " EndCase     ;WORD "

 db     " WORD: EXPECT    4Spaces  tib ! tib 1-        "
 db     "                 Begin  1+ DUP   key   SWAP  C! DUP   C@  ?do  Until      "
 db     "                 DUP 4Spaces SWAP! CELL+ DUP 'exit' SWAP! CELL+  0 SWAP!  ;WORD "


 db     ' WORD: F-SYSTEM  0 BLOCK ! tibsize BLOCK CELL+ ! tib BLOCK CELL+ CELL+ ! '
 db     '                 Begin CR TIMER@ 2HEX. ."  OK>" EXPECT  CR 0 >IN ! INTERPRET Again ;WORD '

 db     "   F-SYSTEM   "

 db     " CR .( ----------) CR "


 db     "   "

 db     " CR .( Here:) HERE HEX. .( Ticks:) TIMER@ 2HEX. EXIT    "
 db     0
;

 alignhe20
