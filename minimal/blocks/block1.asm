;block1
 db     " TYPEZ                                                                         "
 db     " 0x 2 LOAD        0x 3 LOAD      "
 db     " 0x 4 LOAD        0x 5 LOAD      "
 db     " 0x 6 LOAD        0x 7 LOAD      "
 db     " 0x 8 LOAD        0x 9 LOAD      "
 db     " 0x A LOAD        0x B LOAD      "
 db     " 0x C LOAD        0x D LOAD      "

 db     " .( End of loads)   "
 db     " 0x F0F0 0x 4C0 !    init_rtc "

 db     "  FORTH32 CURRENT ! FORTH32 CONTEXT ! "
 db     '  WORD: badw      ." Very bad Word:" HERE 1+ TYPEZ CRLF ;WORD '
 db     " ' badw ' BADWORD CELL+ ! "

 db     "  0x  40       CONSTANT tibsize "
 db     "  VARIABLE tib$  0 tib$ !  "
 db     "  VARIABLE tib#  tibsize 0x 10 *  ALLOT     "
 db     "  WORD: tib      tib# tib$  @ +   ;WORD "

 db     " tibsize tib# clear "

 db     " WORD: set_console_input  0 BLOCK ! tibsize BLOCK CELL+ !  "
 db     '                        tib 1+  BLOCK CELL+ CELL+  !               ;WORD '

 db     ' WORD: key        KEY   eng   ;WORD '

 db     " WORD: do_backspace  1- 1- hex, 082008 SP@ TYPEZ  Pop  ;WORD   "
 db     " WORD: mask          hex, 3C0 AND  ;WORD "
 db     " WORD: prev_cmd      tib$ @ tibsize - mask  tib$ ! tib C@  BLOCK CELL+ !  ;WORD "
 db     " WORD: next_cmd      tib$ @ tibsize + mask  tib$ !   ;WORD "

 db     " WORD: ?do   Case           "
 db     '                   DUP      hex, 1C00 = Of    Pop  tib  - DUP BLOCK CELL+ ! tib C!    Pop  -1   EndOf  '
 db     "                   DUP      hex, E00  = Of    Pop Pop do_backspace  0     EndOf  "
 db     '                   DUP      hex, 4800 = Of    Pop Pop Pop prev_cmd set_console_input  CR ." OK>" tib 1+ TYPEZ tib C@ tib +  0  EndOf '
 db     "             SWAP C! 0   "
 db     ' EndCase      ;WORD '

 db     " WORD: EXPECT    tib      "
 db     '                 Begin  1+ DUP   key    ?do   Until      '
 db     "                 ;WORD "



 db     ' WORD: F-SYSTEM  '
 db     '                 Begin set_console_input CRLF ." SP:" SP@ HEX. ." HERE:" HERE HEX. ." TICKs:" TIMER@ 2HEX.  '
 db     '                 CRLF ." OK>" EXPECT   CRLF 0 >IN !  INTERPRET next_cmd Again ;WORD '

 db     "   F-SYSTEM   "

 db     " CR .( ----------) CR "


 db     "   "

 db     " CR .( Here:) HERE HEX. .( Ticks:) TIMER@ 2HEX. EXIT    "
 db     0
;

 alignhe20
