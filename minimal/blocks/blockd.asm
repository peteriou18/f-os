; block d


db " FORTH32 CURRENT ! ASSEMBLER CONTEXT ! "
db " ASSEMBLER FORTH32 LINK "



db " FORTH32 CURRENT ! FORTH32 CONTEXT ! "

db " WORD: ALIGN16      ALIGN HERE  hex, f AND 0 = If HERE hex, fffffff0 AND  hex, 10 + [ ' HERE CELL+ LIT, ] !  Then  ;WORD "

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

db ' WORD: usb_states   CRLF ."  USB0:"  USB0 usb_state wport@ HEX.   ."  USB1:"  USB1 usb_state wport@ HEX.  ."  USB2:"  USB2 usb_state wport@ HEX.  ."  USB3:"  USB3 usb_state wport@ HEX. ;WORD '

db ' WORD: usb_ports    CRLF ."  USB0:"  USB0 usb_port_status wport@ HEX.  USB0 hex, 12 + wport@ HEX.  ."  USB1:"  USB1 usb_port_status wport@ HEX.  USB1 hex, 12 + wport@ HEX.       '
db '                    CRLF ."  USB2:"  USB2 usb_port_status wport@ HEX.  USB2 hex, 12 + wport@ HEX.  ."  USB3:"  USB3 usb_port_status wport@ HEX.  USB3 hex, 12 + wport@ HEX. ;WORD '

db " WORD: usb_stop  0 SWAP usb_state wport! ;WORD "
db " WORD: frame_list  0 hex, 3FF Do DUP usb_base_frame port@ hex, FFF NOT AND R@ CELLs + DUP DUP HEX. @ HEX. SPACE  hex, C AND If CRLF KEY Pop Then  Loop ;WORD "

db " CREATE usb_request_block_device_descriptor   "
db "        0x  80 B, ( bmReqType ) "
db "        0x   6 B, ( bRequest ) "
db "        0x 100 W, ( wValue ) "
db "             0 W, ( wIndex ) "
db "        0x  12 W, ( wLength ) "
db " ALIGN "

db " CREATE usb_request_block_get_cfg   "
db "        0x  80 B, ( bmReqType ) "
db "        0x   8 B, ( bRequest ) "
db "        0x   0 W, ( wValue ) "
db "             0 W, ( wIndex ) "
db "        0x   1 W, ( wLength ) "
db " ALIGN "

db " CREATE usb_request_block_get_status   "
db "        0x  80 B, ( bmReqType ) "
db "        0x   0 B, ( bRequest ) "
db "        0x   0 W, ( wValue ) "
db "             0 W, ( wIndex ) "
db "        0x   2 W, ( wLength ) "
db " ALIGN "

db " CREATE usb_device_descriptor "
db "        0 B, ( bLength ) "
db "        0 B, ( bDescriptorType ) "
db "        0 W, ( bcdUSB )        "
db "        0 B, ( bDeviceClass )  "
db "        0 B, ( bDeviceSubClass ) "
db "        0 B, ( bDeviceProtocol ) "
db "        0 B, ( bMaxPacketSize0 ) "
db "        0 W, ( idVendor )      "
db "        0 W, ( idProduct )     "
db "        0 W, ( bcdDevice )     "
db "        0 B, ( iManufacturer ) "
db "        0 B, ( iProduct ) "
db "        0 B, ( iSerialNumber ) "
db "        0 B, ( bNumConfigurations )  0 , 0 , ALIGN  "


db " ALIGN16 "
db " CREATE OUT_TD      1 , ( link pointer ) "
db "                    0x 1c800000 ,                 "
db "                    0x E1 B,  0 B,  ( device address 7 bits + endpoint 4 bits )  0x FFE8 W, ( max packet length - 1024) "
db "                    0 , ( buffer pointer )       "

db " CREATE IN_TD3      OUT_TD    0x 4 OR , ( link pointer) "
db "                    0x 1c800000 ,     ( Low speed, active)            "
db "                    0x 69 B,  0 B,  ( device address 7 bits + endpoint 4 bits )  0x E8  W,  ( max packet length - 1024) "
db "                    usb_device_descriptor 0x 10 + , ( buffer pointer )       "

db " CREATE IN_TD2      IN_TD3    0x 4 OR  , ( link pointer) "
db "                    0x 1c800000 ,     ( Low speed, active)            "
db "                    0x 69 B,  0 B,  ( device address 7 bits + endpoint 4 bits )  0x E0  W,  ( max packet length - 1024) "
db "                    usb_device_descriptor 0x 8 + , ( buffer pointer )       "

db " CREATE IN_TD1      IN_TD2   0x 4 OR  , ( link pointer) "
db "                    0x 1c800000 ,     ( Low speed, active)            "
db "                    0x 69 B,  0 B,  ( device address 7 bits + endpoint 4 bits )  0x E8  W,  ( max packet length - 1024) "
db "                    usb_device_descriptor , ( buffer pointer )    0 , 0 , 0 ,   "

db " CREATE setup_TD1    IN_TD1    0x 4 OR   , ( link pointer) "
db "                    0x 1c800000 ,                 "
db "                    0x 2D B,  0 B,  ( device address 7 bits + endpoint 4 bits )  0x 00E0  W,  ( max packet length - 1024) "
db "                    usb_request_block_device_descriptor , ( buffer pointer )      0 , 0 , 0 , "



db " CREATE QH         QH 0x 2 OR  ,   "
db "                    setup_TD1  , "
db " "


db " WORD:  view_TD   (( addr --   )  CRLF DUP @ HEX. CELL+ DUP @ >R R@ (( status ) HEX. CELL+ DUP @ HEX. CELL+ @ HEX.  "
db "                                    "
db '                                  R@  hex, 00004000  AND 0 = If ."  CRC/Timeout error "  Then   '
db '                                  R@  hex, 00400000  AND 0 = If ."  Data buffer error "  Then   '
db '                                  R@  hex, 00100000  AND 0 = If ."  Babble "    Then '
db '                                  R@  hex, 00040000  AND 0 = If ."  Stalled  " Then  '
db '                                  R>  Pop ;WORD '

db " WORD: usb_run       DUP wport@ 1 OR SWAP wport!  "
db "                     ;WORD "

db " WORD: fl8!        QH USB0 hex, 8 + port@  hex, FFFFF000 AND  hex, 8 + SWAP hex, 2 OR SWAP!  hex, 5 pause  setup_TD1 view_TD ;WORD "

db " WORD: usb_disable_interrupts  hex, 4 + 0 SWAP wport! ;WORD "
db " WORD: usb_clear_frame_index   hex, 6 + 0 SWAP wport! ;WORD "

db " WORD: set_frame_list       hex, 88000 hex, 88fff Do   1 R@ ! R> hex, 3 + >R Loop  hex, 8 + hex, 88000 SWAP port! ;WORD "

db " WORD: usb_host_reset    (( controller -- ) USB0 DUP DUP DUP DUP DUP DUP   "
db "                                                      hex, 4 SWAP wport!  hex, 3 pause "
db "                                                           0 SWAP wport!  hex, 3 pause "
db "                                                      set_frame_list                   "
db "                                                      hex, 2 SWAP wport!  hex, 6 pause "
db "                                                      usb_disable_interrupts           "
db "                                                      usb_clear_frame_index            "
db "       DUP DUP wport@  hex, c0  OR  SWAP wport!   DUP  wport@  1  OR  SWAP wport!  ;WORD "


db " WORD: usb_port_reset    USB0  hex, 12 +  (( DUP ) DUP DUP hex, 200 SWAP wport!   hex, 3 pause  hex, fffffdff SWAP wport!  hex, 4 pause (( wport@ ) hex, 4  SWAP wport! ;WORD "

db " WORD: get_desc      QH  hex, 2 OR  R@ hex, 8 + port@  hex, FFFFF000 AND  hex, 8 + ! ;WORD "

db " WORD: get_port     USB0 hex, 12 + wport@ ;WORD    WORD: set_port   USB0 hex, 12 + wport! ;WORD "







db 0
alignhe20
