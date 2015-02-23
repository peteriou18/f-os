   USE16

 org 0x7C00
DriveNumber     equ     0x7c00

       ; entry:
        cli     ; Disable interrupts
       xor ax, ax
       mov ss, ax
       mov es, ax
       mov ds, ax
       mov fs, ax
       mov ax,0b800h
       mov gs,ax
       mov sp, 0x1500

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


        lgdt [GDTR32] ; Load GDT register
        mov eax, cr0
        or al, 0x01     ; Set protected mode bit
        mov cr0, eax

        jmp 8:start32 ; Jump to 32-bit protected mode

GDTR32: ; Global Descriptors Table Register
dw gdt32_end - gdt32 - 1        ; limit of GDT (size minus one)
dq gdt32 ; linear address of GDT
align 16
gdt32:
dw 0x0000, 0x0000, 0x0000, 0x0000       ; Null desciptor
dw 0xFFFF, 0x0000, 0x9A00, 0x00CF       ; 0x  8 32-bit flat code descriptor
dw 0xFFFF, 0x0000, 0x9200, 0x00CF       ; 0x 10 32-bit flat data descriptor
dw 0xFFFF, 0x0000, 0x9A10, 0x005F       ; 0x 18 32-bit code descriptor 0x100000-0x1fffff
dw 0xFFFF, 0x0000, 0x9220, 0x005F       ; 0x 20 32-bit data descriptor 0x200000-0x2fffff
dw 0x0000, 0xFFFF, 0x9209, 0x0050       ; 0x 28 32-bit stack descriptor 0x9ffff-0x90000
dw 0xFFFF, 0x0000, 0x9A00, 0x0000       ; 0x 30 real code
dw 0xFFFF, 0x0000, 0x9200, 0x0000       ; 0x 38 real data
dw 0xFFFF, 0x8000, 0x920B, 0x0000       ; 0x 40 text video segment

gdt32_end:


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
        dw 03 ; many of sectors
offset_data:
        dw 4000h ;offset of data
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
        
        mov ah, 0x0E    ; int 0x10 teletype function
print2:
        lodsb   ; Get char from string
        cmp al, 0
        je print3 ; If char is zero, end of string
        int 0x10        ; Otherwise, print it
        jmp short print2
print3:
        
        ret
;------------------------------------------------------------------------------
msg_Load db "Loading Pure32", 0
msg_LoadDone db " - done.", 13, 10, "Executing...", 0
msg_LoadFail db " - Not found!", 0
;DriveNumber db 0x00

 USE32
start32:

        mov eax, 16     ; load 4 GB data descriptor
        mov ds, ax      ; to all data segment registers
        mov es, ax
        mov fs, ax


        mov ss, ax
        mov eax,0x40
        mov gs, ax
        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        xor edx, edx
        xor esi, esi
        xor edi, edi
        xor ebp, ebp
        mov esp,02000h

        mov dword [0xb8020], "P M "
; Enable the A20 gate
set_A20:
        in al, 0x64
        test al, 0x02
        jnz set_A20
        mov al, 0xD1
        out 0x64, al
check_A20:
        in al, 0x64
        test al, 0x02
        jnz check_A20
        mov al, 0xDF
        out 0x60, al
; Set up RTC
; Port 0x70 is RTC Address, and 0x71 is RTC Data
; http://www.nondot.org/sabre/os/files/MiscHW/RealtimeClockFAQ.txt
rtc_poll:
        mov al, 0x0A    ; Status Register A
        out 0x70, al    ; Select the address
        in al, 0x71     ; Read the data
        test al, 0x80   ; Is there an update in process?
        jne rtc_poll ; If so then keep polling
        mov al, 0x0A    ; Status Register A
        out 0x70, al    ; Select the address
        mov al, 00100110b       ; UIP (0), RTC@32.768KHz (010), Rate@1024Hz (0110)
        out 0x71, al    ; Write the data

        ; Remap PIC IRQ's
        mov al, 00010001b       ; begin PIC 1 initialization
        out 0x20, al
        mov al, 00010001b       ; begin PIC 2 initialization
        out 0xA0, al
        mov al, 0x20    ; IRQ 0-7: interrupts 20h-27h
        out 0x21, al
        mov al, 0x28    ; IRQ 8-15: interrupts 28h-2Fh
        out 0xA1, al
        mov al, 4
        out 0x21, al
        mov al, 2
        out 0xA1, al
        mov al, 1
        out 0x21, al
        out 0xA1, al
; Mask all PIC interrupts
        mov al, 0xFF
        out 0x21, al
        out 0xA1, al

        wbinvd
        ; Enable Floating Point
        mov eax, cr0
        bts eax, 1      ; Set Monitor co-processor (Bit 1)
        btr eax, 2      ; Clear Emulation (Bit 2)
        mov cr0, eax
; Enable SSE
        mov eax, cr4
        bts eax, 9      ; Set Operating System Support for FXSAVE and FXSTOR instructions (Bit 9)
        bts eax, 10     ; Set Operating System Support for Unmasked SIMD Floating-Point Exceptions (Bit 10)
        mov cr4, eax
; Enable Math Co-processor
        finit
         mov dword [gs:0x38], "C D "
        jmp near 4000h
times 446-$+$$ db 0

; False partition table entry required by some BIOS vendors.
db 0x80, 0xFE, 0xFF, 0xFF, 0x0B, 0xFE, 0xFF, 0xFF, 0x01, 0x00, 0x00, 0x00, 0xFE, 0xEF, 0xEC, 0x00
times 510-$+$$ db 0
sign dw 0xAA55


        
