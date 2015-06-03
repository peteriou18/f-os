; block 9

db ' WORD: chr   HERE 1+ @  ;WORD '
db " VOCABULARY span's "
db " span's CURRENT ! "

db " QUOTE CONSTANT QUOTE "
db " BL CONSTANT BL  "
db " WORD:    0x    0x       ;WORD    "

db " FORTH32 CURRENT ! "



db " span's FORTH32 LINK    span's CONTEXT ! "
db " ' chr ' BADWORD CELL+ ! "
db " FORTH32 CONTEXT ! "
db " span's UNLINK "


 db " IMMEDIATES CURRENT ! "
 db " WORD: (span)          OVER OVER SWAP- + 1+ DO    BL WORD  span's SFIND EXECUTE  SP@ TYPEZ B, LOOP  ;WORD "
 db " FORTH32 CURRENT !    "

 db ' WORD: span            >R >R  WITHIN  HEX.  R> R> HEX. HEX.    ;WORD '

 db " WORD: tesst       [ 0x 10 0x 19 ]   (span)  q w e r t y u i o p  Q W E R T Y U I O P   HERE HEX. HEX. ;WORD "
 db ' WORD: tsts        ." begin test" stop BRANCH [ HERE ] 0  0x_as_lit, DDEEFF  HEX. [ DUP HEX. HERE CELL- SWAP! ] ." end test " ;WORD '
 db " tsts "
; db " tesst "
 ;db " WORD: layout:           [ ', WORD: ]    ;WORD "
 ;db " WORD: ;layout           [ ', ;WORD ]    ;WORD "

 ;db " WORD: eng                      "
;db "           upper_shift_caps "
 ;db '          HERE   SP@ HEX.   span  q w e r t y u i o p  Q W E R T Y U I O P SP@ HEX.   '
; db "        stop         0x 1E  0x 26 span  a s d f g h j k l    A S D F G H J K L "
; db "                 0x 2C  0x 32 span  z x c v b n m        Z X C V B N M "

;db "          upper_shift_only "

; db "                 0x 02  0x 0D span 1 2 3 4 5 6 7 8 9 0 - =  ! @ # $ % ^ & * ( ) _ + "
; db "                 0x 1A  0x 1B span [ ] { } "
; db "                 0x 27  0x 29 span ; ' `   : QUOTE  ~ "
; db "                 0x 2B  0x 2B span  \ | "
; db "                 0x 33  0x 35 span , . / < > ? "
; db '                 0x 39  0x 39  span  BL BL .( after) SP@ HEX.   TYPEZ '
; db " ;WORD "
; db " 0x 13  0x 10  0x 19 span "
;db " layout: rus_win1251 "
;db "         upper_shift_caps "
;db "                0x 10 0x 1B span é ö ó ê å í ã ø ù ç õ ú  É Ö Ó Ê Å Í Ã Ø Ù Ç Õ Ú "
;db "                0x 1E 0x 29 span ô û â à ï ð î ë ä æ ý ¸  Ô Û Â À Ï Ð Î Ë Ä Æ Ý ¨ "
;db "                0x 2C 0x 34 span ÿ ÷ ñ ì è ò ü á þ        ß × Ñ Ì È Ò Ü Á Þ "
;db "         upper_shift_only "
;db "            0x 02 0x 0D span 1 2 3 4 5 6 7 8 9 0 - =  ! QUOTE ¹ ; % : ? * ( ) _ + "
;db "                0x 35 0x 35 span . , "
;db "                0x 39 0x 39 span BL BL "
db " "
db " EXIT "
db     0
 alignhe20
