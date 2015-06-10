;block1
 db     " TYPEZ                                                                         "
 db     " 0x 7 LOAD        0x 2 LOAD      "
 db     " 0x 3 LOAD        0x 5 LOAD      "
 db     " 0x 4 LOAD        0x 6 LOAD      "
 db     " 0x 8 LOAD        0x 9 LOAD      "

 db     " .( End of loads)  "




 db     " WORD: key "
 db     " KEY  DUP  eng ;WORD "

; db     " WORD: EXPECT         0x_as_lit, 2020202020202020  0x_as_lit, 2000 ! 0x_as_lit, 1FFF  Begin  1+ DUP  key   SWAP  C! DUP  C@ DUP HEX.   0x_as_lit, 1C = Until  0x_as_lit, 2000 TYPEZ ;WORD "
; db     " CR 0x 40 0x B8010 C!  0x B8010 C@ HEX.    CR .( OK>) EXPECT  0 >IN ! INTERPRET  "

 db     " CR .( ----------) CR "


 db     "  .( KEY:) key "

 db     " CR .( Here:) HERE HEX. .( Ticks:) TIMER@ 2HEX. EXIT    "
 db     0
;

 alignhe20
