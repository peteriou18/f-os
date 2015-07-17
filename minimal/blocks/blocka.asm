; block A editor
db " FORTH32 CURRENT ! FORTH32 CONTEXT !   "

db " VOCABULARY editor "
db " editor CURRENT ! "



 db " ASSEMBLER FORTH32 LINK    "
 db " ASSEMBLER CONTEXT !    "

db " HEADER symb HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx "
db " mov_ebp,eax "
db " call_edx     "
db " mov_ecx,eax  "
db " mov_eax,ebp      "
db " mov_ch,# 0x 1F B, "
db " mov_[gs:eax],cx "
db " ret "
db " ALIGN    "

db " HEADER Left_upper HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx "
db " mov_w[gs:eax],# 0x C9 B, 0x 1F B, "
db " ret "
db " ALIGN    "

db " HEADER Right_upper HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx "
db " mov_w[gs:eax],# 0x BB B, 0x 1F B, "
db " ret "
db " ALIGN    "

db " HEADER Left_lower HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx "
db " mov_w[gs:eax],# 0x C8 B, 0x 1F B, "
db " ret "
db " ALIGN    "



db " HEADER Right_lower HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx "
db " mov_w[gs:eax],# 0x BC B, 0x 1F B, "
db " ret "
db " ALIGN    "

db " HEADER Vline HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx "
db " mov_ecx,eax "
db " call_edx "
db " backward< "
db " mov_w[gs:eax],# 0x BA B, 0x 1F B, "
db " add_eax,# 0x A0 ,      "
db " dec_ecx         "
db " jne <backward   "
db " ret "

db " ALIGN    "

db " HEADER Hline HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx "
db " mov_ecx,eax "
db " call_edx "
db " backward< "
db " mov_w[gs:eax],# 0x CD B, 0x 1F B, "
db " inc_eax         "
db " inc_eax         "
db " dec_ecx         "
db " jne <backward   "
db " ret "

db " ALIGN    "

db " editor FORTH32 LINK   editor CONTEXT ! "

db " CREATE (win)       0 , 0 , 0 ,    "
db " WORD: win          (win) @ (win) CELL+ @ (win) CELL+ CELL+ @ ;WORD "

db " WORD: xy-adr   (( x y -- addr ) hex, A0 * SWAP 2* + ;WORD "

db " WORD: win_point    xy-adr (win)        ;WORD "
db " WORD: win_width    (win)  CELL+        ;WORD "
db " WORD: win_height   (win)  CELL+ CELL+  ;WORD "


db ' WORD: corners       3rd  Left_upper '
db "                     3rd 2nd 2* +  Right_upper  "
db "                     3rd 1st hex, A0 * +  Left_lower   "
db "                     3rd 2nd 2* + 1st hex, A0 * +  Right_lower  ;WORD "

db " WORD: sides  3rd 2nd Hline "
db "              3rd 1st hex, A0 * + 2nd Hline "
db "              3rd 1st Vline "
db "              3rd 2nd 2* + 1st Vline ;WORD "

db " WORD: border   (( address of Left upper corner width height ) "
db "               fix_frame  sides corners ;WORD "

db " WORD: fill  hex, 4000 C@   hex, 1 hex, 1 xy-adr fix_frame (( char addr_to ) "
db "             0 win_width @ 1- 1- Do 2nd 1st symb hex, 1 2nd+ hex, 2 1st+ Loop Pop Pop ;WORD  "

db " WORD: DRAW   border fill ;WORD "
db " WORD: key  KEY eng ;WORD "
db " WORD: ?Esc hex, 100 = ;WORD "


db " FORTH32 CURRENT !  "
db " 0x 0  0x 0 win_point !  0x 48 win_width !  0x 14 win_height ! "
db ' WORD: EDIT  ." editor "  Begin win DRAW key ?Esc Until  ;WORD '
db " FORTH32 CONTEXT ! "
db " EXIT "

alignhe20
