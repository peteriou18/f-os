

org 0x8000

USE16

start:
        cli     ; Disable all interrupts
        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        xor edx, edx
        xor esi, esi
        xor edi, edi
        xor ebp, ebp
        mov ds, ax
        mov es,ax
        mov ss, ax
        mov fs, ax
        mov gs, ax
        mov esp, 0x8000 ; Set a known free location for the stack




        jmp start16 ; This command will be overwritten with 'NOP's before the AP's are started
        nop     ; The 'jmp' is only 3 bytes
;%include "init/smp_ap.asm"      ; AP's will start execution at 0x8000 and fall through to this code
;db '_16_' ; Debug
        align 16
USE16


start16:
        jmp 0x0000:clearcs

 msg_initializing       db      " Starting Forth32",10,13,0







clearcs:

; Configure serial port
;xor dx, dx      ; First serial port
;mov ax, 0000000011100011b       ; 9600 baud, no parity, 1 stop bit, 8 data bits
;int 0x14
; Make sure the screen is set to 80x25 color text mode
        mov ax, 0x0003  ; Set to normal (80x25 text) video mode
        int 0x10
; Disable blinking
;mov ax, 0x1003
;mov bx, 0x0000
;int 0x10
; Print message
        mov si, msg_initializing
        call print_string_16
; Check to make sure the CPU supports 64-bit mode... If not then bail out
        ;mov eax, 0x80000000     ; Extended-function 8000000h.
        ;cpuid ; Is largest extended function
        ;cmp eax, 0x80000000     ; any function > 80000000h?
        ;jbe no_long_mode ; If not, no long mode.
        ;mov eax, 0x80000001     ; Extended-function 8000001h.
        ;cpuid ; Now EDX = extended-features flags.
        ;bt edx, 29      ; Test if long mode is supported.
        ;jnc no_long_mode ; Exit if not supported.
        ;call init_isa ; Setup legacy hardware
; Hide the hardware cursor (interferes with print_string_16 if called earlier)
;mov ax, 0x0200  ; VIDEO - SET CURSOR POSITION
;mov bx, 0x0000  ; Page number
;mov dx, 0x2000  ; Row / Column
;int 0x10
; At this point we are done with real mode and BIOS interrupts. Jump to 32-bit mode.
         lgdt [cs:GDTR32] ; Load GDT register
         mov eax, cr0
         or al, 0x01     ; Set protected mode bit
         mov cr0, eax
         jmp 8:start32 ; Jump to 32-bit protected mode


; 16-bit function to print a sting to the screen
print_string_16: ; Output string in SI to screen
          pusha
          mov ah, 0x0E    ; http://www.ctyme.com/intr/rb-0106.htm
print_string_16_repeat:
          lodsb   ; Get char from string
          cmp al, 0
          je print_string_16_done ; If char is zero, end of string
          int 0x10        ; Otherwise, print it
jmp print_string_16_repeat

print_string_16_done:
          popa
          ret

; Display an error message that the CPU does not support 64-bit mode
no_long_mode:
;mov si, msg_no64
;call print_string_16
jmp $

;include "init/isa.asm"

align 16

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
gdt32_end:

;idt:
;db      2048 dup 0




;db '_32_' ; Debug
align 16
; =============================================================================
; 32-bit mode
USE32
include "init/isa.asm"
include "init/pic.asm"
include "init/cpu.asm"
include "interrupt.asm"
include "screen.asm"
include "string.asm"
include "syscalls.asm"
include "input.asm"
include "disk.asm"

;-------------------
; ecx - number of interrupt
; eax - offset of interrupt handler
;------------------

create_gate:
      ;  sidt    [idtr]
        mov     edi,[idtr+2]
        shl     ecx,3
        add     edi,ecx

        push    eax ; save the interrupt gate to the stack for later use
        stosw   ; store the low word (15..0) of the address
        mov     ax, 8 ; flat code selector
        stosw   ; store the segment selector
        mov     ax, 0x8E00
        stosw   ; store interrupt gate marker
        pop     eax ; get the interrupt gate back
        shr     eax, 16
        stosw   ; store the high word (31..16) of the address
        shr     ecx,3
        ret

idtr:   dw      7ffh
        dd      400h

msg:     db     "Wow starting!",0

start32:
        mov eax, 16     ; load 4 GB data descriptor
        mov ds, ax      ; to all data segment registers
        mov es, ax
        mov fs, ax
        mov gs, ax
       ; mov eax,0x28
        mov ss, ax
        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        xor edx, edx
        xor esi, esi
        xor edi, edi
        xor ebp, ebp
        mov esp,08000h
       ;xor   esp,esp
        ;mov esp, 0x8000 ; Set a known free location for the stack
        mov al, '2'     ; Now in 32-bit protected mode (0x20 = 32)
        mov [0x000B8098], al
        mov al, '0'
        mov [0x000B809a], al
; Clear out the first 4096 bytes of memory. This will store the 32-bit IDT, GDT, PML4, and PDP
        push    edx
        mov ecx, 1024
        xor eax, eax
        mov edi, eax
        rep stosd
        pop     edx

        call    init_isa

        mov dword [0x000B8030], "I S "
        xor     ecx,ecx
        mov     eax, exception_gate_00
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_01
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_02
        call    create_gate
        inc     ecx

        mov     eax, breakpoint
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_04
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_05
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_06
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_07
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_08
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_09
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_0a
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_0b
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_0c
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_0d
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_0e
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_0f
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_10
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_11
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_12
        call    create_gate
        inc     ecx

        mov     eax, exception_gate_13
        call    create_gate

        mov     ecx,21h
        mov eax, keyboard ; 21h
        call create_gate

        mov ecx, 0x22   ; Set up Cascade handler
        mov eax, cascade
        call create_gate

        mov ecx, 0x28   ; Set up RTC handler
        mov eax, rtc
        call create_gate
         mov dword [0x000B8034], "A B "
        lidt [idtr] ; load IDT register
         mov dword [0x000B8038], "C D "
        call    init_pic
         mov dword [0x000B803C], "E F "
        call    init_cpu
        mov     byte [os_Screen_Cursor_Col],1
        mov     byte [os_Screen_Cursor_Row],12
        call    os_cursor_set

        mov al, '1'     ; About to make the jump into 64-bit mode
        mov [0x000B809C], al
        mov al, 'E'
        mov [0x000B809E], al

        mov eax,90abcdefh
        call    _push
        mov eax,12345678h
        call    _push
        call    _2hex_bytes

        include  "f32.asm"


align 4096
align 2048
align 1024
align 512
vocabulary:
;section seconf start=neworg

        include "vocabulary.asm"

_here:

align 4096
align 2048
align 1024
align 512
;----------------------------------
  include       "f/blocks.asm"

; Pad to an even KB file (6 KiB)
padding:
align 65536

 db 1024-512  dup 90h

