;block1
 db     " TYPEZ                                                                         "
 db     " 0x 7 LOAD        0x 2 LOAD      "
 db     " 0x 3 LOAD        0x 5 LOAD      "
 db     " 0x 4 LOAD        0x 6 LOAD      "
 db     " 0x 8 LOAD        0x 9 LOAD      "

 db     " .( End of loads)  "
 db " WORD: CR        0x_as_lit, 0D0A  SP@ TYPEZ ;WORD "


 db     " WORD: key "
 db     " KEY  DUP  eng ;WORD "

 db     " WORD: EXPECT          Begin key  Again ;WORD "
 db     " CR .( OK>) EXPECT "

 db     " CR .( ----------) CR "


 db     "  .( KEY:) key "

 db     " CR .( Here:) HERE HEX. .( Ticks:) TIMER@ 2HEX. EXIT    "
 db     0
;

 alignhe20
