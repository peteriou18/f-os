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

db " HEADER Fill HERE CELL+ , ( adr_from adr_to width height ) "
db " mov_edx,# ' Pop @ , call_edx ( height ) "
db " mov_edi,eax "
db " dec_edi     "
db " call_edx ( width ) "
db " mov_ebp,eax      "
db " dec_ebp          "
db " call_edx ( adr_to ) "
db " add_eax,# 0x A2 , "
db " mov_esi,eax       "

db " call_edx ( adr_from ) "
db " xchg_eax,esi       "
db " mov_edx,ebp        "

db " backward< DUP "
db " mov_cl,[esi]       "
db " mov_ch,# 0x 1F B, "
db " mov_[gs:eax],cx "
db " inc_esi         "
db " inc_eax         "
db " inc_eax         "
db " dec_ebp         "
db " jne <backward   "
db " add_eax,# 0x A0 , "
db " mov_ebp,edx   "
db " sub_eax,ebp  "
db " sub_eax,ebp  "
db " dec_edi      "
db " jne <backward      "
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


db " WORD: DRAW   border BUFFER win Fill hex, 51 set_cursor  ;WORD "
db " WORD: key  KEY eng ;WORD "
db " WORD: ?Esc hex, 100 = ;WORD "


db " FORTH32 CURRENT !  "
db " 0x 0  0x 0 win_point !  0x 48 win_width !  0x 14 win_height ! "
db ' WORD: EDIT  ." editor "  Begin win DRAW key ?Esc Until  ;WORD '
db " FORTH32 CONTEXT ! "
db " EXIT "

alignhe20
