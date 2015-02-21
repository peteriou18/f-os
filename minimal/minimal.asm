         cell_size      = 4 ; 32bit
         data_stack_base  =     100000h

macro alignhe
{ virtual
        align 4
        algn = $ - $$
    end virtual
    db algn dup 0
    }

     align 256
;----------------------------
nfa_0:
        db    7, "FORTH32",0
        alignhe
        dd    nfa_1 ;LFA
        dd    _vocabulary ;CFA
f32_list:
        dd    nfa_last ;PFA - oeacaoaeu ia eoa iineaaiaai ii?aaaeaiiiai neiaa
_vocabulary:
        add   eax,cell_size
        call  _push
        ret

;----------------------------
        align 4
nfa_1:
        db    7,"BADWORD",0
        alignhe
        dd    0 ; zero LFA. End of search or link winth another vocabulary if not zero
        dd    _vect
        dd    _abort
_vect:
        mov     eax,[eax+cell_size]
        call    dword [eax]
        ret
;----------------------------
         align 4
nfa_2:

        db    4,"EXIT",0
        alignhe
        dd    nfa_1
ret_:
        dd     _ret
_ret:
        pop     eax
        pop     eax
        ret
;----------------------------
        align 4
nfa_3:
        db      4,"Push",0
        alignhe
        dd      nfa_2
        dd      _push
_push:
        mov     ebx,[stack_pointer]
        add     ebx , cell_size
        and     ebx ,  [data_stack_mask]
        mov     [ ebx+data_stack_base ] , eax
        mov     [stack_pointer],ebx
        ret

data_stack_mask dd      0x00ffff
stack_pointer   dd      0
;----------------------------
        align 4
nfa_4:
        db      5,"ABORT",0
        alignhe
        dd      nfa_3
        dd      _abort
_abort:
        mov     esi,msgbad
        call    os_output
        mov     esi,[here_value]
        inc     esi
        call    os_output
        mov     esi,msgabort
        call    os_output
        ret
msgbad          db      "  Badword: ",0 
msgabort        db      " Abort!",0
;----------------------------
        align 4
nfa_5:

        db      4,"HERE",0
        alignhe
        dd      nfa_4
        dd      _constant
here_value:
        dd      _here
;----------------------------
        align 4
nfa_6:
 nfa_last:
        db      9,"constant#",0
        alignhe
        dd      nfa_5
constantb_:
        dd      _constant
        dd      _constant
_constant:
        mov     eax,[eax+4]
        call    _push
        ret
;----------------------------
        align   4

        USE32
os_output:
        pushad
        mov     eax,prtstr1
        and     eax,0ffffh
        mov     [rmback],eax
        mov     dword [pmback_offset],prtstr2
        jmp    switch_to_rm

        USE16
        cld
        cli
prtstr1:
        mov     al,[si]
        inc     si
        cmp    al,0
        je      prtstr3
        mov     ah,0eh
        int     10h
        jmp     prtstr1

 prtstr3:
        jmp   switch_to_pm

        USE32
prtstr2:
        popad
        ret
symbols        dd      0
;----------------------------
        align   4
        USE16

switch_to_pm:
         cli

         mov eax, cr0
         or al, 0x01     ; Set protected mode bit
         mov cr0, eax
         wbinvd
         jmp 8:pm2

         USE32
 esp_save       dd       0
 pm2:

        mov eax, 16     ; load 4 GB data descriptor
        mov ds, ax      ; to all data segment registers
        mov es, ax
        mov fs, ax
        mov gs, ax
        mov ss, ax
        lidt    [idtr]
        call     remap_irq_pm
        call    unmask_irqs
        mov    esp,0f00h-36
        popad
        mov     esp,[esp_save]
        sti

        jmp     dword [pmback]

 ;----------------------------
         align   4
switch_to_rm:
         cli

         mov     [esp_save],esp
         mov    esp,0f00h
         pushad
         jmp    30h:rm3
         nop
             USE16
 rm3:
        mov   eax,38h
        mov     ds,ax
        mov     es,ax
        mov     ss,ax
        mov     fs,ax
        mov     gs,ax

        mov eax, cr0
        and al, 0xfe
            ; clear protected mode bit
         mov cr0, eax
         wbinvd
         jmp    0:start163

 start163:

          xor     ax,ax
          mov     ds,ax
          mov     es,ax
          mov     ss,ax
          mov     fs,ax

          mov     gs,ax
          mov     fs,ax
          mov     sp,5000h
          call  remap_irq_real
          lidt     [rlidt]
          sti
          call  unmask_irqs

          jmp   far [rmback]

          USE32
;----------------------------
           align   4
rmback          dd    0
pmback          dd    0
pmback_offset   dd    0
idtr:           dw      7ffh
                dd      500h
rlidt:          dw      3ffh
                dd      0

;----------------------------
         align   4
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
;----------------------------
         align   4
unmask_irqs:
; Enable specific interrupts
         in al, 0x21
         mov al, 11111001b       ; Enable Cascade, Keyboard
         out 0x21, al
         in al, 0xA1
         mov al, 11111110b       ; Enable RTC
         out 0xA1, al
         ret

;----------------------------
         align   4
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

;----------------------------
         align   4
_here:
