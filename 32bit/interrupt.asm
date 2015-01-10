; =============================================================================
; Pure64 -- a 64-bit OS loader written in Assembly for x86-64 systems
; Copyright (C) 2008-2014 Return Infinity -- see LICENSE.TXT
;
; Interrupts
; =============================================================================
; -----------------------------------------------------------------------------
; Default exception handler
exception_gate:
;        mov esi, int_string
;        call os_output
;        mov esi, exc_string
;        call os_output
exception_gate_halt:
        cli     ; Disable interrupts
        hlt     ; Halt the system
        jmp exception_gate_halt
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
; Default interrupt handler
interrupt_gate: ; handler for all other interrupts
         iret
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
; Keyboard interrupt. IRQ 0x01, INT 0x21
; This IRQ runs whenever there is input on the keyboard
align 16
keyboard:
        push edi
        push ebx
        push eax

        xor eax, eax

        in al, 0x60                     ; Get the scancode from the keyboard
        mov [0x000B80a0],al
        cmp al, 'X'
        je keyboard_escape
        cmp al, 0x2A                    ; Left Shift Make
        je keyboard_shift
        cmp al, 0x36                    ; Right Shift Make
        je keyboard_shift
        cmp al, 0xAA                    ; Left Shift Break
        je keyboard_noshift
        cmp al, 0xB6                    ; Right Shift Break
        je keyboard_noshift     
        cmp     al,0x3a
        je      keyboard_caps
        test al, 0x80
        jz keydown
        jmp keyup

keydown:
        cmp byte [key_shift], 0x00
        jne keyboard_lowercase
        jmp keyboard_uppercase

keyboard_lowercase:
        mov ebx, keylayoutupper
        jmp keyboard_processkey

keyboard_uppercase:     
        mov ebx, keylayoutlower

keyboard_processkey:                    ; Convert the scancode
        add ebx, eax
        mov bl, [ebx]
        mov [key], bl
        ;mov al, [key]
        jmp keyboard_done
        
keyboard_caps:
        xor byte [key_shift], 0x01
        jmp keyboard_done
        
keyboard_escape:
        ; reboot -- Reboot the computer
reboot:
        in al, 0x64
        test al, 00000010b      ; Wait for an empty Input Buffer
        jne reboot
        mov al, 0xFE
        out 0x64, al    ; Send the reboot call to the keyboard controller
        jmp reboot


keyup:
        jmp keyboard_done

keyboard_shift:
        mov byte [key_shift], 0x01
        jmp keyboard_done

keyboard_noshift:
        mov byte [key_shift], 0x00
        jmp keyboard_done

keyboard_done:
        ;mov rdi, [os_LocalAPICAddress] ; Acknowledge the IRQ on APIC
        ;add rdi, 0xB0
        ;xor eax, eax
        mov al, 0x20    ; Acknowledge the IRQ
        out 0x20, al;stosd
        ;call os_smp_wakeup_all         ; A terrible hack

        pop eax
        pop ebx
        pop edi
        iret
        
key_shift       db      0
key                     db      0
keylayoutlower:
db 0x00, 0, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', 0x0e, 0, 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', 0x1c, 0, 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', 0x27, '`', 0, '\', 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', 0, 0, 0, ' ', 0
keylayoutupper:
db 0x00, 0, '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', 0x0e, 0, 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', 0x1c, 0, 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', 0x22, '~', 0, '|', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>', '?', 0, 0, 0, ' ', 0
; 0e = backspace
; 1c = enter
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
; Cascade interrupt. IRQ 0x02, INT 0x22
cascade:
push eax
mov al, 0x20    ; Acknowledge the IRQ
out 0x20, al
pop eax
iretd
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
; Real-time clock interrupt. IRQ 0x08, INT 0x28
align 16
rtc:
        push edi
        push eax
;add dword [os_Counter_RTC], 1   ; 64-bit counter started at bootup
     mov al, 'R'
     mov [0x000B8092], al
;mov eax, [os_Counter_RTC]
    ; and al, 1       ; Clear all but lowest bit (Can only be 0 or 1)
     ;add al, 48
     inc dword [0x000B8094]
     mov al, 0x0C    ; Select RTC register C
     out 0x70, al    ; Port 0x70 is the RTC index, and 0x71 is the RTC data
     in al, 0x71     ; Read the value in register C
     mov al, 0x20    ; Acknowledge the IRQ
     out 0xA0, al
     out 0x20, al
     pop eax
     pop edi
     iret
; -----------------------------------------------------------------------------
breakpoint:
         mov     dword [msg_exc],exc_breakpoint
exception_gate_03:
         mov     byte [screen_attribute],1eh

       ; push    ebx
       ; push    eax
        mov     [b_eax],eax
        mov     [b_ebx],ebx
        mov     [b_ecx],ecx
        mov     [b_edx],edx
        mov     [b_esi],esi
        mov     [b_edi],edi
        mov     [b_esp],esp
        mov     [b_ebp],ebp

        mov     eax,[esp]
        mov     [break_adr],eax
        mov     eax,[esp+4]
        mov     [break_sel],eax
        mov     eax,[esp+8]
        mov     [break_flag],eax


        call os_print_newline
        mov esi, [msg_exc]
        call os_output

        mov esi, adr_string
        call os_output
        mov  eax,[break_sel]
        mov  byte [os_debug_dump_eax_char],':'
        call os_debug_dump_eax
        mov eax, [break_adr]
        mov  byte [os_debug_dump_eax_char],' '
        call os_debug_dump_eax
        mov  esi,msg_eflags
        call os_output
        mov  eax,[break_flag]
        call os_debug_dump_eax
        call os_print_newline

        mov     esi,msg_eax
        call    os_output
        mov     eax,[b_eax]
        call    os_debug_dump_eax

        mov     esi,msg_ebx
        call    os_output
        mov     eax,[b_ebx]
        call    os_debug_dump_eax

        mov     esi,msg_ecx
        call    os_output
        mov     eax,[b_ecx]
        call    os_debug_dump_eax

        mov     esi,msg_edx
        call    os_output
        mov     eax,[b_edx]
        call    os_debug_dump_eax

        mov     esi,msg_esi
        call    os_output
        mov     eax,[b_esi]
        call    os_debug_dump_eax
        call    os_print_newline

        mov     esi,msg_edi
        call    os_output
        mov     eax,[b_edi]
        call    os_debug_dump_eax

        mov     esi,msg_esp
        call    os_output
        mov     eax,[b_esp]
        call    os_debug_dump_eax

        mov     esi,msg_ebp
        call    os_output
        mov     eax,[b_ebp]
        call    os_debug_dump_eax
        mov     byte [screen_attribute],7
        sti
breakpoint1:
        call os_input_key
        jnb             breakpoint1
        mov     eax,[b_eax]
        mov     ebx,[b_ebx]
        mov     ecx,[b_ecx]
        mov     edx,[b_edx]
        mov     esi,[b_esi]
        mov     edi,[b_edi]
        mov     esp,[b_esp]
        mov     ebp,[b_ebp]
        iret

b_eax           dd      0
b_ebx           dd      0
b_ecx           dd      0
b_edx           dd      0
b_esi           dd      0
b_edi           dd      0
b_esp           dd      0
b_ebp           dd      0
break_adr       dd      0
break_sel       dd      0
break_flag      dd      0
adr_string      db      " @ 0x", 0
int_string      db      "Pure32 - Exception ", 0
exc0            db      "Divide by zero",0
exc1            db      "INT 1",0
exc2            db      "NMI",0
exc_breakpoint  db      "Breakpoint",0
exc4            db      "Overflow",0
exc5            db      "Bound range exceeded",0
exc6            db      "Invalid opcode",0
exc7            db      "No math coprocessor",0
exc8            db      "Double fault",0
exc9            db      "Coprocessor segment overrun",0
exca            db      "Invalid TSS",0
excb            db      "Segment not present",0
excc            db      "Stack segment fault",0
excd            db      "General protection",0
exce            db      "Page fault",0
excf            db      "Reserved",0
exc10           db      "Floating point error",0
exc11           db      "Alignment check",0
exc12           db      "Machine  check",0
exc13           db      "SIMD floating point exception",0
exc14           db      "Virtualization exception",0

msg_eflags      db      "EFLAGS:",0
msg_eax         db      "EAX:",0
msg_ebx         db      "EBX:",0
msg_ecx         db      "ECX:",0
msg_edx         db      "EDX:",0
msg_esi         db      "ESI:",0
msg_edi         db      "EDI:",0
msg_esp         db      "ESP:",0
msg_ebp         db      "EBP:",0
msg_exc         dd      exc_breakpoint

; -----------------------------------------------------------------------------
; Spurious interrupt. INT 0xFF
align 16
spurious: ; handler for spurious interrupts
mov al, 'S'
mov [0x000B8080], al
iret
; -----------------------------------------------------------------------------
; -----------------------------------------------------------------------------
; CPU Exception Gates
exception_gate_00:
         mov     dword [msg_exc],exc0
         jmp exception_gate_main

exception_gate_01:
        mov     dword [msg_exc],exc1
        jmp exception_gate_main

exception_gate_02:
        mov     dword [msg_exc],exc2
        jmp exception_gate_main

exception_gate_04:
        mov     dword [msg_exc],exc4
        jmp exception_gate_main

exception_gate_05:
        mov     dword [msg_exc],exc5
        jmp exception_gate_main

exception_gate_06:
        mov     dword [msg_exc],exc6
        jmp exception_gate_main

exception_gate_07:
        mov     dword [msg_exc],exc7
        jmp exception_gate_main

exception_gate_08:
        mov     dword [msg_exc],exc8
        jmp exception_gate_main

exception_gate_09:
        mov     dword [msg_exc],exc9
        jmp exception_gate_main

exception_gate_0a:
        mov     dword [msg_exc],exca
        jmp exception_gate_main

exception_gate_0b:
        mov     dword [msg_exc],excb
        jmp exception_gate_main

exception_gate_0c:
        mov     dword [msg_exc],excc
        jmp exception_gate_main

exception_gate_0d:
        mov     dword [msg_exc],excd
        jmp exception_gate_main

exception_gate_0e:
        mov     dword [msg_exc],exce
        jmp exception_gate_main

exception_gate_0f:
        mov     dword [msg_exc],excf
        jmp exception_gate_main

exception_gate_10:
        mov     dword [msg_exc],exc10
        jmp exception_gate_main

exception_gate_11:
        mov     dword [msg_exc],exc11
        jmp exception_gate_main

exception_gate_12:
        mov     dword [msg_exc],exc12
        jmp exception_gate_main

exception_gate_13:
        mov     dword [msg_exc],exc13
        jmp exception_gate_main

exception_gate_main:
        mov     byte [screen_attribute],1eh
        mov    dword  [0xb80020],0x330f340f
        call os_print_newline
        mov esi, int_string
        call os_output
        jmp    exception_gate_03

; =============================================================================
; EOF
