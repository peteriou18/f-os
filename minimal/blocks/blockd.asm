; block d     RTC


db " FORTH32 CURRENT ! ASSEMBLER CONTEXT ! "
db " ASSEMBLER FORTH32 LINK "

db " HEADER get_realtime HERE CELL+ , "
db " mov_edx,# 0x 70 ,   "
db " mov_eax,# 0x 4 ,    "
db " out_dx,al "
db " inc_edx     "
db " in_al,dx   "
db " mov_cl,al  "
db " shl_ecx,# 0x 8 B, "
db " dec_edx   "
db " mov_eax,# 0x 2 ,    "
db " out_dx,al "
db " inc_edx     "
db " in_al,dx   "
db " mov_cl,al  "
db " shl_ecx,# 0x 8 B, "
db " dec_edx   "
db " mov_eax,# 0x 0 ,    "
db " out_dx,al "
db " inc_edx     "
db " in_al,dx   "
db " mov_cl,al  "
db " mov_eax,ecx   "
db " mov_edx,# ' Push @ , call_edx "
db " ret "
db " ALIGN "



db " HEADER init_rtc HERE CELL+ , "
db " mov_eax,# 0x 8B , "
db " mov_edx,# 0x 70 , "
db " out_dx,al "
db " inc_edx "
db " mov_eax,# 0x 42 , "
db " out_dx,al      "
db " mov_eax,# 0x 8C , "
db " dec_edx "
db " out_dx,al "
db " inc_edx "
db " in_al,dx "
db " ret "
db " ALIGN "

db " HEADER init_PIT HERE CELL+ , "
db " mov_eax,# 0x 36 , " ;set PIT CH0  mode
db " mov_edx,# 0x 43 ,  "
db " out_dx,al          "
db " xor_eax,eax        "
db " mov_d[],#  0x 4C0 , 0x FBF0 , "
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
db " mov_d[],#  apic_ticks , 0x 0 ,       "
db " mov_d[],# 0x 0B8140 , 0x 40404040 , "
db " ret "

db " ALIGN "


db " HEADER st HERE CELL+ , "
db " "
db " mov_d[],# 0x 0B8140 , 0x 40404040 , "
db " iretd "

db " ALIGN "

db " HEADER stop_beep HERE CELL+ , "
db " pushad "
db " mov_edx,# 0x 61 , "
db " in_al,dx  "
db " and_eax,# 0x 0FFFFFFFC ,    "
db " out_dx,al                "
db " mov_d[],# 0x 0FEE000B0 , 0x 42424242 , "
db " eoi   "
db " popad "
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

db " HEADER cpuid1 HERE CELL+ , "
db " mov_eax,# 1 , "
db " cpuid "
db " push_eax push_ebx "
db " mov_eax,edx "
db " mov_edx,# ' Push @ , call_edx "
db " mov_eax,ecx  "
db " call_edx "
db " pop_ebx "
db " mov_eax,ebx "
db " call_edx "
db " pop_eax "

db " call_edx " ;
db " ret "
db " ALIGN "

db " HEADER Rdmsr HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx "
db " mov_ecx,eax "
db " rdmsr "
db " push_edx "
db " mov_edx,# ' Push @ , call_edx "
db " pop_edx "
db " mov_eax,edx "

db " mov_edx,# ' Push @ , call_edx "  ;
db " ret "
db " ALIGN "


db " FORTH32 CURRENT ! FORTH32 CONTEXT ! "

db " WORD: get_RCBA (( Root Complex Base Address aka chipset configuration base address ) "
db "                0 pci_adr !     hex, 1F pci_device pci_adr @ hex, F0 + pci_read 1- ;WORD "
;db " WORD: get_apic_id        hex, B Rdmsr ;WORD "
db " WORD: get_apic_base      hex, 1B Rdmsr ;WORD "


db " get_apic_base HEX. HEX. get_apic_base Pop 0x FFFF0000 AND CONSTANT apic_base "
db " get_RCBA CONSTANT RCBA "
db " CRLF RCBA HEX. "
db " RCBA 0x 3404 + @ DUP HEX. CONSTANT HPTC "
db " 0x 80 HPTC ! ( enable high precision timer and set base address to FED0_0000 ) "
db " RCBA 0x 3400 + @ DUP HEX. CONSTANT RC   "
db " RCBA 0x  168 + @ DUP HEX. CONSTANT HDBA "
;db " get_apic_id  .( APIC ID: )  HEX. HEX. "

db " WORD: send_ipiaa     (( #proc -- )  hex, 1000000 *  apic_base hex, 310 + !  hex, 4002 apic_base hex, 300 + ! ;WORD "
db " WORD: send_nmi       (( #proc -- )  hex, 1000000 *  apic_base hex, 310 + !  hex, 4400 apic_base hex, 300 + ! ;WORD "
db " WORD: send_ipiab     (( #proc -- )  hex, 1000000 *  apic_base hex, 310 + !  hex, AB apic_base hex, 300 + ! ;WORD "
db " WORD: send_sipi      (( #proc -- )  hex, 1000000 *  apic_base hex, 310 + !  hex, 460E apic_base hex, 300 + ! ;WORD "
db " WORD: send_init      (( #proc -- )  hex, 1000000 *  apic_base hex, 310 + !  hex, 4500 apic_base hex, 300 + ! ;WORD "

db " WORD: beep   [ ' stop_beep @ 0x 30 make_interrupt_gate ]   "
db "                 hex, 344 set_tone hex, FFFFFF (beep)   ;WORD "

db " CRLF .( CPU id leaf one:) cpuid1 HEX. .( APIC ID:) HEX. HEX. HEX. CRLF "

db 0
alignhe20
