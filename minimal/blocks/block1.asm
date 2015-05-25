;block1
 db     " TYPEZ                                                                         "
 db     " 0x 7 LOAD        0x 2 LOAD      "
 db     " 0x 3 LOAD        0x 5 LOAD      "
 db     " 0x 4 LOAD        0x 6 LOAD      "
 db     " 0x 8 LOAD        "

 db     " .( End of loads)  "
 db " WORD: CR        0x_as_lit, 0D0A  SP@ TYPEZ ;WORD "
 db "  "
 db " WORD: dotest 0x_as_lit, 1 0x_as_lit, 12   DO  CR TIMER@ 2HEX.  LOOP   NOOP ;WORD "



 db     " WORD: key "
 db     " KEY    "
 db     " Case "
 db     " DUP 0x_as_lit, 10  0x_as_lit, 19  WITHIN Of "
 db     " 0x_as_lit, 10 -  qwerty CELL+ + upper_shift_caps   0x_as_lit, A  AND + C@ SP@  TYPEZ  EndOf "
 db     " DUP  "
 db     " 0x_as_lit, 1E  0x_as_lit, 26  WITHIN  Of "
 db     " 0x_as_lit, 1E -  asdfgh CELL+ + upper_shift_caps   0x_as_lit, 9  AND + C@ SP@  TYPEZ  EndOf "
 db     " DUP  "
 db     " 0x_as_lit, 2C  0x_as_lit, 32  WITHIN Of "
 db     " 0x_as_lit, 2C -  zxcvbn CELL+ + upper_shift_caps   0x_as_lit, 7  AND + C@ SP@  TYPEZ  EndOf "
 db     " DUP  "
 db     " 0x_as_lit, 2   0x_as_lit,  D  WITHIN  Of "
 db     " 0x_as_lit,  2 -  numkys  + upper_shift_only   0x_as_lit, C  AND + C@ SP@  TYPEZ  EndOf "
 db     " DUP  "

 db     " 0x_as_lit, 1A  0x_as_lit, 1B  WITHIN  Of "
 db     " 0x_as_lit, 1A -  numky1 CELL+ + upper_shift_only   0x_as_lit, 2  AND + C@ SP@  TYPEZ  EndOf "
 db     " DUP  "
 db     " 0x_as_lit, 27  0x_as_lit, 29  WITHIN  Of "
 db     " 0x_as_lit, 27 -  numky2 CELL+ + upper_shift_only   0x_as_lit, 3  AND + C@ SP@  TYPEZ  EndOf "
 db     " DUP  "

 db     " 0x_as_lit, 2B  =  Of  "
 db     " 0x_as_lit, 2B -  numky3 CELL+ + upper_shift_only   0x_as_lit, 1  AND + C@ SP@  TYPEZ  EndOf  "

 db     " DUP  "
 db     " 0x_as_lit, 33  0x_as_lit, 35  WITHIN  Of "
 db     " 0x_as_lit, 33 -  numky4 CELL+ + upper_shift_only   0x_as_lit, 3  AND + C@ SP@  TYPEZ  EndOf "
 db     " DUP  "

 db     " 0x_as_lit, 39  =  Of "
 db     " 0x_as_lit, 39 -  space_ CELL+ +  C@ SP@  TYPEZ  EndOf  "
 db     ' EndCase Pop  ;WORD '
 db     " CR .( ----------) CR "

; db     " WORD: key2 "
; db     ' KEY    '
; db     ' Case    '
; db     ' DUP  0x_as_lit, 1 =   Of  ." Escape " EndOf   '
; db     ' DUP  0x_as_lit, 2 =   Of  ." One " EndOf    '
; db     ' ." Another "   EndCase    ;WORD '

 db     "  .( KEY:) key "
  db " dotest "
 db     " CR .( Here:) HERE HEX. .( Ticks:) TIMER@ 2HEX. EXIT    "
 db     0
;

 alignhe20
