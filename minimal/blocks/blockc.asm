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

db " HEADER wport@ HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx " ;
db " mov_edx,eax "
db " xor_eax,eax "
db " in_ax,dx  "
db " mov_edx,# ' Push @ , call_edx " ;
db " ret "
db " ALIGN "

db " HEADER wport! HERE CELL+ , "
db " mov_edx,# ' Pop @ , call_edx " ; port
db " mov_ecx,eax "
db " call_edx " ;data
db " mov_edx,ecx        "
db " out_dx,ax  "
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

db " FORTH32 CURRENT ! FORTH32 CONTEXT ! "



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



db 0
alignhe20
