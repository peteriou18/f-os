; block A editor
db " FORTH32 CURRENT ! FORTH32 CONTEXT !   "

db " VOCABULARY editor "
db " editor CURRENT ! "



 db " ASSEMBLER FORTH32 LINK    "
 db " ASSEMBLER CONTEXT !    "



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

db ' WORD: corners       hex, 0120 Left_upper '
db "                     hex, 0122 Right_upper  "
db "                     hex, 01C0 Left_lower   "
db "                     hex, 01C2 Right_lower  ;WORD "

db " WORD: sides  hex, 0220 hex, 14 Hline "
db "              hex, 0450 hex, 14 Hline "
db "              hex, 0222 hex, 05 Vline "
db "              hex, 0452 hex, 05 Vline ;WORD "

db ' WORD: border  hex, 0450  hex, 14   hex, 5  corners sides  ;WORD '

db " WORD: DRAW border ;WORD "
db " WORD: KEY  NOOP ;WORD "



db " FORTH32 CURRENT !  "
db ' WORD: EDIT  ." editor "  Begin DRAW KEY -1 Until  ;WORD '
db " FORTH32 CONTEXT ! "
db " EXIT "

alignhe20
