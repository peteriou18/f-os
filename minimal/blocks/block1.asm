;block1
 db     " TYPEZ                                                                         "
 db     " 0x 7 LOAD        0x 2 LOAD      "
 db     " 0x 3 LOAD        0x 5 LOAD      "
 db     " 0x 4 LOAD        0x 6 LOAD      "
 db     " 0x 8 LOAD        0x 9 LOAD      "

 db     " .( End of loads)   "

 db     "  FORTH32 CURRENT ! FORTH32 CONTEXT ! "
 db     '  WORD: badw      ." Very bad Word:" HERE 1+ TYPEZ CR ;WORD '
 db     " ' badw ' BADWORD CELL+ ! "

 db     "  0x  20202020 CONSTANT 4Spaces "
 db     "  0x  54495845 CONSTANT 'exit'  "
 db     "  0x  40       CONSTANT tibsize "
 db     "  VARIABLE tib$  0 tib$ !  "
 db     "  VARIABLE tib#  tibsize 0x 10 *  ALLOT     "
 db     "  WORD: tib      tib# tib$  @ +   ;WORD "
 ;db     "  4Spaces fixframe tib DUP 1st SWAP! DUP CELL+ 1st  SWAP!  DUP CELL+ 1st  SWAP! DUP CELL+ 1st  SWAP! DUP CELL+ 1st  SWAP! "
; db      " tib HEX.   tib @ HEX.    'exit' tib !   tib @ HEX. "
 db     " WORD: test5      fix_frame  5th HEX. 4th HEX. 3rd HEX. 2nd HEX. 1st HEX. ;WORD "



 db     ' WORD: key        KEY   eng   ;WORD '

 db     " WORD: do_backspace  1- 1- hex, 082008 SP@ TYPEZ  Pop  ;WORD   "
 db     " WORD: mask          hex, 3C0 AND  ;WORD "
 db     " WORD: prev_cmd      tib$ @ tibsize - mask  tib$ ! tib C@  BLOCK CELL+ !  ;WORD "
 db     " WORD: next_cmd      tib$ @ tibsize + mask  tib$ !   ;WORD "
 db     " WORD: do_enter      DUP 4spaces SWAP! CELL+ DUP 'exit' SWAP! CELL+ DUP 4spaces SWAP! CELL+  0 SWAP!  ;WORD "

 db     " WORD: ?do   Case           "
 db     '                   DUP      hex, 1C00 = Of    Pop tib  - DUP BLOCK CELL+ ! tib C!  next_cmd   Pop  -1   EndOf  '
 db     "                   DUP      hex, E00  = Of    Pop Pop do_backspace  0     EndOf  "
 db     '                   DUP      hex, 4800 = Of    Pop HEX. prev_cmd  tib HEX. tib tib C@ + DUP HEX. tib 1+ TYPEZ Pop 0 EndOf '
 db     "             SWAP C! 0   "
 db     ' EndCase      ;WORD '

 db     " WORD: EXPECT    tib      "
 db     '                 Begin  1+ DUP   key    ?do   Until      '
 db     "                 ;WORD "

 db     " WORD: set_console_input  0 BLOCK ! tibsize BLOCK CELL+ !  "
 db     "                        tib 1+ BLOCK CELL+ CELL+ !               ;WORD "

 db     ' WORD: F-SYSTEM  '
 db     '                 Begin set_console_input CR  tib 1+ TYPEZ CR ." SP:" SP@ HEX. ." HERE:" HERE HEX. ." TICKs:" TIMER@ 2HEX.  '
 db     '                 CR ." OK>" EXPECT   CR 0 >IN ! INTERPRET Again ;WORD '

 db     "   F-SYSTEM   "

 db     " CR .( ----------) CR "


 db     "   "

 db     " CR .( Here:) HERE HEX. .( Ticks:) TIMER@ 2HEX. EXIT    "
 db     0
;

 alignhe20
