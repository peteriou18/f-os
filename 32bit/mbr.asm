 ;  USE16
section	.text
 org 0x7C00
DriveNumber	equ	0x7c00

       ; entry:
	cli	; Disable interrupts
       xor ax, ax
       mov ss, ax
       mov es, ax
       mov ds, ax
       mov sp, 0x7C00
       sti     ; Enable interrupts
       mov [DriveNumber], dl   ; BIOS passes drive number in DL
       mov si, msg_Load
       call prints
      ;load 63 sectors
	mov  dl,[DriveNumber]
	mov si,dap_p
	mov ah,42h
	int 13h
	jb  load_fail
	mov si, msg_LoadDone
	call prints
	jmp 0x000:0x8000

load_fail:
	mov si, msg_LoadFail
	call prints
halt:
	hlt
	jmp halt
dap_p:
	db 16
	db 0 ;zero
many_of:
	dw 0127 ; many of sectors
offset_data:
	dw 8000h ;offset of data
seg_data:
	dw 000h ;segment of data
sect:
	dd 1 ; number of sector
	dd 0

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
; 16-bit function to print a string to the screen
; IN: SI - Address of start of string
prints: ; Output string in SI to screen
	
	mov ah, 0x0E	; int 0x10 teletype function
print2:
	lodsb	; Get char from string
	cmp al, 0
	je print3 ; If char is zero, end of string
	int 0x10	; Otherwise, print it
	jmp short print2
print3:
	
	ret
;------------------------------------------------------------------------------
msg_Load db "Loading Pure32", 0
msg_LoadDone db " - done.", 13, 10, "Executing...", 0
msg_LoadFail db " - Not found!", 0
;DriveNumber db 0x00
times 446-$+$$ db 0

; False partition table entry required by some BIOS vendors.
db 0x80, 0x00, 0x01, 0x00, 0xEB, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF
times 510-$+$$ db 0
sign dw 0xAA55


	
