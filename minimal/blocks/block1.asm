;block1
 db     " TYPEZ                                                                         "
 db     " 0x 7 LOAD        0x 2 LOAD      "
 db     " 0x 3 LOAD        0x 5 LOAD      "
 db     " 0x 4 LOAD        0x 6 LOAD      "
 db     " 0x 8 LOAD        0x 9 LOAD      "

 db     " .( End of loads)   "

 db     "  FORTH32 CURRENT ! FORTH32 CONTEXT ! "
 db     '  WORD: badw      ." Very bad Word:" HERE 1+ TYPEZ ;WORD '
 db     " ' badw ' BADWORD CELL+ ! "

 db     "  0x  20202020 CONSTANT 4Spaces "
 db     "  0x  54495845 CONSTANT 'exit'  "
 db     "  0x  40       CONSTANT tibsize "
 db     "  VARIABLE tib$  0 tib$ !  "
 db     "  VARIABLE tib#  tibsize 0x 10 *  ALLOT     "
 db     "  WORD: tib      tib# tib$  @ +   ;WORD "



 db     " WORD: key      KEY   eng  ;WORD "

 db     " WORD: do_backspace  1- 1- hex, 082008 SP@ TYPEZ Pop   ;WORD   "
 db     " WORD: mask          hex, 3C0 AND  ;WORD "
 db     " WORD: prev_cmd      tib$ @ tibsize - mask  tib$ !   ;WORD "
 db     " WORD: next_cmd      tib$ @ tibsize + mask  tib$ !   ;WORD "
 db     " WORD: do_enter      DUP 4Spaces SWAP! CELL+ DUP 'exit' SWAP! CELL+  0 SWAP!  ;WORD "

 db     " WORD: ?do   Case           "
 db     "                  DUP    hex, 1C = Of   do_enter next_cmd Pop  -1   EndOf  "
 db     "                  DUP    hex, E  = Of   do_backspace 0     EndOf  "
 db     '                         hex, 48 = Of   ." do up" prev_cmd hex, 0A TYPEZ Pop   tib TYPEZ 0 EndOf '
 db     "                  0   "
 db     " EndCase     ;WORD "

 db     " WORD: EXPECT    4Spaces  tib ! tib 1-        "
 db     "                 Begin  1+ DUP   key  SWAP  C! DUP   C@  ?do  Until      "
 db     "                 ;WORD "

 db     " WORD: set_console_input  0 BLOCK ! tibsize BLOCK CELL+ !  "
 db     "                        tib BLOCK CELL+ CELL+ !               ;WORD "

 db     ' WORD: F-SYSTEM  '
 db     '                 Begin set_console_input CR ." SP:" SP@ HEX. ." HERE:" HERE HEX. ." TICKs:" TIMER@ 2HEX.  '
 db     '                 ."  OK>" EXPECT  CR 0 >IN ! INTERPRET Again ;WORD '

 db     "   F-SYSTEM   "

 db     " CR .( ----------) CR "


 db     "   "

 db     " CR .( Here:) HERE HEX. .( Ticks:) TIMER@ 2HEX. EXIT    "
 db     0
;

 alignhe20
