db " FORTH32 CONTEXT ! FORTH32 CURRENT ! "

db " VARIABLE apic_ticks  "
db " VARIABLE testf       "

db " FORTH32 CURRENT ! ASSEMBLER CONTEXT ! "
db " ASSEMBLER FORTH32 LINK "

db " HEADER init_apic_timer HERE CELL+ , "
db " mov_d[],# 0x 0FEE00320 , 0x 20030 , "
db " ret "
db " ALIGN "

db " HEADER init_PIT HERE CELL+ , "
db " mov_eax,# 0x 36 , " ;set PIT CH0  mode
db " mov_edx,# 0x 43 ,  "
db " out_dx,al          "
db " xor_eax,eax        "
;db " mov_edx,# 0x 21 ,  "
db " mov_d[],#  0x 4C0 , 0x FBF0 , "
;db " out_dx,al         "
db " ret "
db " ALIGN "

db " HEADER init_speaker HERE CELL+ , "
db " mov_eax,# 0x B6 , " ;set PIT CH2  mode
db " mov_edx,# 0x 43 ,  "
db " out_dx,al          "
db " ret "
db " ALIGN "


db " HEADER start_timer HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx " ;
db " mov_ecx,eax "
db " mov_edx,# 0x 40 , "
db " mov_al,cl "
db " out_dx,al "
db " mov_al,ch "
db " out_dx,al "
db " mov_d[],# 0x  0FEE00380 , 0x FFFFFFFF ,  "
;db " mov_edx,# ' Push @ , call_edx "
db " mov_d[],#  apic_ticks , 0x 0 ,       "
db " mov_d[],# 0x 0B8140 , 0x 40404040 , "
db " ret "

db " ALIGN "

db " HEADER on_timer HERE CELL+ , "

db " add_[],eax 0x B8144 , "
;db " mov_d[],# 0x 0B8144 , 0x 41414141 , "
db " mov_eax,[] 0x  0FEE00390 , "
db " neg_eax    "
db " mov_[],eax apic_ticks , "
db " mov_d[],# 0x  0FEE00380 , apic_ticks ,  "
;db " mov_[],eax apic_ticks ,        "
;db " mov_d[],# testf , 0x FF    "
db " eoi   "
db " iretd "
db " ALIGN "

db " HEADER stop_beep HERE CELL+ , "
db " mov_edx,# 0x 61 , "
db " in_al,dx  "
db " and_eax,# 0x 0FFFFFFFC ,    "
db " out_dx,al                "
db " mov_d[],# 0x 0FEE000B0 , 0x 42424242 , "
db " eoi   "
db " iretd "
db " ALIGN "

db " HEADER on_apic_timer HERE CELL+ , "
db " add_[],eax 0x B8148 , "
;db " add_d[],# 0x 0B8148 , 0x 42424242 , "
db " mov_d[],# 0x 0FEE000B0 , 0x 42424242 , "
db " iretd "
db " ALIGN "

db " HEADER set_tone HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx " ;
db " mov_ecx,eax "
db " mov_edx,# 0x 42 , "
db " mov_al,cl "
db " out_dx,al "
db " mov_al,ch "
db " out_dx,al "
db " ret "
db " ALIGN "

db " HEADER (beep) HERE CELL+ , "
db " mov_d[],# 0x 0FEE00320 , 0x 0030 , "
db " mov_edx,# ' Pop @ , call_edx " ;
db " mov_[],eax 0x  0FEE00380 , "

db " mov_ecx,eax "
db " mov_edx,# 0x 61 , "
db " in_al,dx  "
db " or_eax,# 0x 3 ,    "
db " out_dx,al           "
db " ret "
db " ALIGN "

db " FORTH32 CURRENT ! FORTH32 CONTEXT ! "

;db " ' on_timer @ 0x 20 make_interrupt_gate "
;db " ' on_apic_timer @ 0x 30 make_interrupt_gate "
;db " init_apic_timer init_PIT 0 start_timer "
;db " WORD: apic_calibrate  0   0 hex, 20   Do apic_ticks @ DUP HEX. + Loop  HEX.  ;WORD "
;db " apic_calibrate "

db " WORD: beep   [ ' stop_beep @ 0x 30 make_interrupt_gate ]   "
db "                 hex, 344 set_tone hex, FFFFFFF (beep)   ;WORD "
db 0
alignhe20
