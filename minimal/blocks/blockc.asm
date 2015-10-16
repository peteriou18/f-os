; block c

db " FORTH32 CONTEXT ! FORTH32 CURRENT ! "

db " VARIABLE apic_ticks  "
db " VARIABLE pci_adr       "

db " FORTH32 CURRENT ! ASSEMBLER CONTEXT ! "
db " ASSEMBLER FORTH32 LINK "

db " HEADER port@ HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx " ;
db " mov_edx,eax "
db " in_eax,dx  "
db " mov_edx,# ' Push @ , call_edx " ;
db " ret "
db " ALIGN "

db " HEADER port! HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx " ; port
db " mov_ecx,eax "
db " call_edx " ;data
db " mov_edx,ecx        "
db " out_dx,eax  "
db " ret "
db " ALIGN "

db " HEADER bport@ HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx " ;
db " mov_edx,eax "
db " xor_eax,eax "
db " in_al,dx  "
db " mov_edx,# ' Push @ , call_edx " ;
db " ret "
db " ALIGN "

db " HEADER bport! HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx " ; port
db " mov_ecx,eax "
db " call_edx " ;data
db " mov_edx,ecx        "
db " out_dx,al  "
db " ret "
db " ALIGN "

db " HEADER pci_register HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx " ;
db " shl_eax,# 0x 2 B, "
db " and_eax,# 0x FC ,  "
db " and_d[],# pci_adr , 0x FC NOT , "
db " or_[],eax pci_adr , "
db " ret "
db " ALIGN "

db " HEADER pci_device HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx " ;
db " shl_eax,# 0x B B, "
db " and_eax,# 0x F800 ,  "
db " and_d[],# pci_adr , 0x F800 NOT , "
db " or_[],eax pci_adr , "
db " ret "
db " ALIGN "

db " HEADER pci_bus HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx " ;
db " shl_eax,# 0x 10 B, "
db " and_eax,# 0x FF0000 ,  "
db " and_d[],# pci_adr , 0x FF0000 NOT , "
db " or_[],eax pci_adr , "
db " ret "
db " ALIGN "

db " HEADER pci_function HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx " ;
db " shl_eax,# 0x 8 B, "
db " and_eax,# 0x 700 ,  "
db " and_d[],# pci_adr , 0x 700 NOT , "
db " or_[],eax pci_adr , "
db " ret "
db " ALIGN "

db " HEADER pci_read HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx " ;
db " or_eax,# 0x 80000000 , "
db " mov_edx,# 0x CF8 ,   "
db " out_dx,eax   "
db " mov_edx,# 0x CFC ,   "
db " in_eax,dx "
db " mov_edx,# ' Push @ , call_edx " ;
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

;db " HEADER get_apic_base HERE CELL+ , "
;db " mov_ecx,# 0x 1B , "
;db " rdmsr "
;db " push_edx "
;db " mov_edx,# ' Push @ , call_edx "
;db " pop_edx "
;db " mov_eax,edx "

;db " mov_edx,# ' Push @ , call_edx "   ;
;db " ret "
;db " ALIGN "

db " FORTH32 CURRENT ! FORTH32 CONTEXT ! "

;db " ' on_timer @ 0x 20 make_interrupt_gate "
db " ' st @ 0x AB make_interrupt_gate "
;db " ' on_apic_timer @ 0x 30 make_interrupt_gate "
;db " init_apic_timer init_PIT 0 start_timer "
;db " WORD: apic_calibrate  0   0 hex, 20   Do apic_ticks @ DUP HEX. + Loop  HEX.  ;WORD "
;db " apic_calibrate "

db " WORD: get_RCBA (( Root Complex Base Address aka chipset configuration base address ) "
db "                0 pci_adr !     hex, 1F pci_device pci_adr @ hex, F0 + pci_read 1- ;WORD "
;db " WORD: get_apic_id        hex, B Rdmsr ;WORD "
db " WORD: get_apic_base      hex, 1B Rdmsr ;WORD "

db " CRLF .( CPU id leaf one:) cpuid1 HEX. .( APIC ID:) HEX. HEX. HEX. CRLF "
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

db " WORD: usb_pci_adr NOOP ;WORD "
db " WORD: usb_base_adr CELL+ ;WORD "


db ' WORD: pci_registers 0 hex, 3F Do R@ pci_register pci_adr @ pci_read DUP -1 = If pci_adr @ HEX. ." :: " HEX. SPACE SPACE Else Pop Then Loop ;WORD '

db " WORD: get_usb_pci_config          "
db " pci_adr @ pci_read  hex, 0C030002  <>   If  "
db           ' CRLF ." USB 1.1 at:" pci_adr @ hex, FF NOT AND DUP ,  HEX.  ." Base:" hex, 8 pci_register pci_adr @ pci_read hex, F NOT AND  DUP HEX. ,   Then '
db           " hex, 2 pci_register    ;WORD "

db ' WORD: pci_functions 0 hex, 7 Do R@ pci_function pci_adr @ pci_read  -1 = If   get_usb_pci_config   Then  Loop  0 pci_function ;WORD '
db " WORD: pci_devices 0 hex, 1F Do R@ pci_device pci_adr @ -1 = If pci_functions Then Loop 0 pci_device  ;WORD "
db " WORD: pci_buses  hex, 2 pci_register 0 hex, FF Do R@ pci_bus pci_adr @ pci_read  -1 = If pci_devices Then Loop ;WORD "


db " WORD: pcr           0 hex, 3F Do R@ HEX. R@ pci_register pci_adr @ HEX. Loop ;WORD "

db " ( scan all buses dev:0 func:0 reg: 2 ) "
db " WORD: find_usb  HERE  pci_buses  ;WORD "

db " CREATE USB find_usb  "

db ' WORD: UHCIs    Word: LIT,     DOES>     CELLs  USB  +  @  ;WORD '

db "    1 UHCIs USB0        0x 3 UHCIs USB1         0x 5 UHCIs USB2        0x 7 UHCIs USB3 "
db "    0 UHCIs USB0_pciadr 0x 2 UHCIs USB1_pciadr  0x 4 UHCIs USB2_pciadr 0x 6 UHCIs USB3_pciadr "


db " WORD: get  port@ HEX. ;WORD "
db " WORD: put  port! ;WORD "

db " WORD: usb_state            ;WORD "
db " WORD: usb_frame_num      hex, 1 CELLs +  ;WORD "
db " WORD: usb_base_frame     hex, 2 CELLs +  ;WORD "
db " WORD: usb_sof            hex, 3 CELLs +  ;WORD "
db " WORD: usb_port_status    hex, 4 CELLs +  ;WORD "


db " CRLF .( PCI USB registers ) CRLF "
db " CRLF .( USB0 com/stat:) USB0_pciadr 0x 4 + pci_read HEX.   .(  int line/pin:) USB0_pciadr 0x 3C + pci_read HEX.  .(  kbd/mse:) USB0_pciadr 0x C0 + pci_read HEX. .(  ports:) USB0_pciadr 0x C4 + pci_read HEX. "
db " CRLF .( USB1 com/stat:) USB1_pciadr 0x 4 + pci_read HEX.   .(  int line/pin:) USB1_pciadr 0x 3C + pci_read HEX.  .(  kbd/mse:) USB1_pciadr 0x C0 + pci_read HEX. .(  ports:) USB1_pciadr 0x C4 + pci_read HEX. "
db " CRLF .( USB2 com/stat:) USB2_pciadr 0x 4 + pci_read HEX.   .(  int line/pin:) USB2_pciadr 0x 3C + pci_read HEX.  .(  kbd/mse:) USB2_pciadr 0x C0 + pci_read HEX. .(  ports:) USB2_pciadr 0x C4 + pci_read HEX. "
db " CRLF .( USB3 com/stat:) USB3_pciadr 0x 4 + pci_read HEX.   .(  int line/pin:) USB3_pciadr 0x 3C + pci_read HEX.  .(  kbd/mse:) USB3_pciadr 0x C0 + pci_read HEX. .(  ports:) USB3_pciadr 0x C4 + pci_read HEX. "

db " CRLF .( USB0:)USB0 usb_state get USB0 usb_frame_num get USB0 usb_base_frame get USB0 usb_sof get USB0 usb_port_status get "
db " CRLF .( USB1:)USB1 usb_state get USB1 usb_frame_num get USB1 usb_base_frame get USB1 usb_sof get USB1 usb_port_status get "
db " CRLF .( USB2:)USB2 usb_state get USB2 usb_frame_num get USB2 usb_base_frame get USB2 usb_sof get USB2 usb_port_status get "
db " CRLF .( USB3:)USB3 usb_state get USB3 usb_frame_num get USB3 usb_base_frame get USB3 usb_sof get USB3 usb_port_status get "

db ' WORD: usb_states   CRLF ."  USB0:"  USB0 usb_state get   ."  USB1:"  USB1 usb_state get  ."  USB2:"  USB2 usb_state get  ."  USB3:"  USB3 usb_state get ;WORD '

db " WORD: usb_stop  0 SWAP usb_state put ;WORD "

db " CREATE  Terminate  1 , "
db " ( Link_Pointer dword ) "
db " ( Act_len&status dword ) "
db " ( PID adr endpoint ) "
db " ( buffer pointer ) "
db " CREATE setup_TD    Terminate , ( link pointer) "
db "                    0 ,                 "
db "                    0x 2D B,  0 B,  ( device address 7 bits + endpoint 4 bits )  0x 7FE  B, B, ( max packet length - 1024) "
db "                    0x 2000 , ( buffer pointer )       "

;db " setup_TD USB0 usb_base_frame port@ @ 0x F NOT AND  DUP HEX. ! "

db " WORD: beep   [ ' stop_beep @ 0x 30 make_interrupt_gate ]   "
db "                 hex, 344 set_tone hex, FFFFFF (beep)   ;WORD "
db 0
alignhe20
