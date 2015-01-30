; =============================================================================
; Pure64 -- a 64-bit OS loader written in Assembly for x86-64 systems
; Copyright (C) 2008-2014 Return Infinity -- see LICENSE.TXT
;
; INIT PIC
; =============================================================================
unmask_irqs:
; Enable specific interrupts
         in al, 0x21
         mov al, 11111001b       ; Enable Cascade, Keyboard
         out 0x21, al
         in al, 0xA1
         mov al, 11111110b       ; Enable RTC
         out 0xA1, al
         ret
         
init_pic:
; Set the periodic flag in the RTC
         mov al, 0x0B    ; Status Register B
         out 0x70, al    ; Select the address
         in al, 0x71     ; Read the current settings
         push eax
         mov al, 0x0B    ; Status Register B
         out 0x70, al    ; Select the address
         pop eax
         bts ax, 6       ; Set Periodic(6)
         out 0x71, al    ; Write the new settings
         sti     ; Enable interrupts
; Acknowledge the RTC
         mov al, 0x0C    ; Status Register C
         out 0x70, al    ; Select the address
         in al, 0x71     ; Read the current settings
         ret
; ==================================

remap_irq_pm:
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
        ret

remap_irq_real:
; Remap PIC IRQ's
        mov al, 00010001b       ; begin PIC 1 initialization
        out 0x20, al
        mov al, 00010001b       ; begin PIC 2 initialization
        out 0xA0, al
        mov al, 0x8     ; IRQ 0-7: interrupts 8h-0fh
        out 0x21, al
        mov al, 0x70    ; IRQ 8-15: interrupts 70h-78h
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
        ret
