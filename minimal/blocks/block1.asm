;block1
 db     " TYPEZ                                                                         "
 db     " 0x 7 LOAD        0x 2 LOAD      "
 db     " 0x 3 LOAD        0x 5 LOAD      "
 db     " 0x 4 LOAD        0x 6 LOAD      "
 db     " 0x 8 LOAD        0x 9 LOAD      "

 db     " .( End of loads)   "



 db     "  0x  20202020 CONSTANT 4spaces "
 db     "  0x  54495845 CONSTANT 'exit'  "
 db     " WORD: key "
 db     " KEY   eng  ;WORD "

 db     " WORD: EXPECT    4spaces  hex, 2000 ! hex, 1FFF  Begin  1+ DUP   key   SWAP  C! DUP   C@  hex, 1C = Until DUP 4spaces SWAP! CELL+ DUP 'exit' SWAP! CELL+  0 SWAP!  ;WORD "
 db     ' WORD: F-SYSTEM  Begin CR ." OK>" EXPECT  0 >IN ! INTERPRET Again ;WORD '

 db     " CR 0x 40 0x B8010 C!  0x B8010 C@ HEX.   F-SYSTEM   "

 db     " CR .( ----------) CR "


 db     "  .( KEY:) key "

 db     " CR .( Here:) HERE HEX. .( Ticks:) TIMER@ 2HEX. EXIT    "
 db     0
;

 alignhe20
