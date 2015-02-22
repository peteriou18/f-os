; memory map
;0-3ff - real idt
;500 -  cff - pm idt
;d00 - 10ff - temp stack
;1100- 14ff - real stack
;1500 - 1fff - pm stack
;2000 - 3fff buffer
;7c00-8000 - mbr code
;4000 - programm code
;

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

nfa_7:
        db      3,"Pop",0
        alignhe
        dd      nfa_6
        dd      _pop
_pop:
        mov     ebx,[stack_pointer]
        mov     eax , [ ebx+data_stack_base]
        sub     ebx , 4
        and     ebx , [data_stack_mask]
        mov     [stack_pointer],ebx
        mov     ebx,10h
        ret
;----------------------------
        align   4

nfa_8:
        db      9,"INTERPRET",0
        alignhe
        dd      nfa_7
        dd      _interpret
_interpret:
        call    _parse
        mov     eax,context_value
        call    _push
        call    _fetch
        call    _sfind
        call    _execute_code
        jmp     _interpret
        ret
;----------------------------
        align   4
nfa_9:
        db      5,"PARSE",0
        dd      nfa_8
        dd      _parse
_parse:
        mov             eax,[block_value+8] ;input buffer
        call    _push
        mov             eax,[here_value]    ;here
        call    _push
        call    _enclose
        ret
;----------------------------
        align   4
nfa_10:
        db      7,"CONTEXT",0
        alignhe
        dd      nfa_9
context_:
        dd      _variable_code
context_value:  
        dd      f32_list
;--------------------------------
        align   4
nfa_11:
        db      7,"ENCLOSE",0
        alignhe
        dd      nfa_10
        dd      _enclose
_enclose:
        call    _pop    ;       to address
        mov             edi,eax
        call    _pop    ; from address
        mov             esi,eax
        xor     edx,edx
        add     esi,[_in_value]
        mov     ebx,edi
        ; clear 32 bytes
        xor     eax,eax
        mov     ecx,8
        rep     stosd
        
        mov     edi,ebx
        mov     ecx,[block_value+4] ; size of buffer
        cmp     ecx,edx
        jl      _word2  ;jl
        inc     edi
        
_skip_delimeters:
        sub     dword [block_value+4],1 ; [nkey],1
        jb      _word2
        lodsb
        inc     dword [_in_value]
        cmp     al,20h
        jbe     _skip_delimeters
_word3:
        stosb
        inc     edx
        sub     dword [block_value+4],1 ; [nkey],1
        jb      _word4
        lodsb
        inc     dword [_in_value]
        cmp     al,20h
        jnbe    _word3

_word4:
        ; string to validate
        mov     [ebx],dl
        ret

_word2:
        ; empty string
        mov     dword [ebx],49584504h ;4,"EXI"
        mov     dword [ebx+4],054h ;"T",0
        ret
;----------------------------
        align   4

nfa_12:
        db      1,"@",0
        alignhe
        dd      nfa_11
fetch_:
        dd      _fetch
_fetch:
        call _pop
        mov eax,[eax]
        call _push
        ret
;----------------------------
        align   4

nfa_13:
        db      5,"SFIND",0
        alignhe
        dd      nfa_12
        dd      _sfind
_sfind:
        call    _pop
        mov      esi,eax ;pop context
        mov     esi,[esi] ;vocid
_find2:
        movzx   ebx,byte [esi];word in vocab
        mov     edx,ebx
        inc     bl
        and     bl,07ch               ;mask immediate in counter
        mov     edi,[here_value]
        movzx     ecx,byte [edi]     ; word on here
        shr     ecx,2
        inc     ecx
        mov     ebp,esi
        mov     eax,[edi]

find22:
        cmpsd
        jne     _find11
        loop  find22

        and      edx,3
        cmp     edx,3
        jne     find23
        add     esi,4

find23:
        mov     eax,esi
        add     eax,4
        call    _push
        ret               ;word found

_find11:
        mov    esi,ebp
        add    esi,4
        add     esi,ebx
        mov     ecx,esi
        mov     esi,[esi]
;        cmp dword [ trace],1
;        jne  _find4
;                        push    ecx
;                        push    edi
;                        push    esi

;                        mov     eax,esi
;                        call    _push
;                        call    _hex_dot
;                        pop     esi
;                       push    esi
 ;                      inc     esi
 ;                      call    os_output
 ;                       pop     esi
 ;                       pop     edi
 ;                       pop     ecx
 ;                       int3
_find4:

        test    esi,esi
        jne     _find2
        mov     eax,ecx
        sub     eax,8
        call    _push
        ret                     ; badword
;----------------------------
        align   4
nfa_14:
        db      7,"EXECUTE",0
        alignhe
        dd      nfa_13
        dd      _execute_code
_execute_code:
        call    _pop
_execute:
        call  dword [eax]
        ret
;----------------------------
        align   4
nfa_15:
        db      5,"BLOCK",0
        alignhe
        dd      nfa_14
block_:
        dd      _variable_code
block_value:
        dd      0               ;block number
        dd      0              ;size of buffer
        dd      0    ;address of input buffer

;----------------------------
        align   4
nfa_16:

        db      9,"variable#",0
        alignhe
        dd      nfa_15
variableb_:
        dd      _constant
        dd      _variable_code
_variable_code:
        add     eax,cell_size
        call    _push
        ret
;----------------------------
        align   4
nfa_17:
        db      3,">IN",0
        alignhe
        dd      nfa_16
        dd      _variable_code
_in_value:
        dd      0

;----------------------------
        align   4

nfa_18:
        db      4,"LOAD",0
        alignhe
        dd      nfa_17
        dd      _load
_load:
        push    dword [block_value]    ;block number
        push    dword [block_value+cell_size]      ; size of buffer
        push    dword [block_value+cell_size+cell_size]    ;address of buffer
        push    dword [_in_value]
        
        mov             eax, buffer_+cell_size+cell_size ; buffer address
        mov             [block_value+cell_size+cell_size],eax
        call    _push
        call    _rdblock
        
        xor             ebx,ebx
        mov             [_in_value],ebx
        mov             dword [block_value+cell_size],8192
        
        call    _interpret
        
        pop             dword [_in_value]
        pop             dword [block_value+cell_size+cell_size]
        pop             dword [block_value+cell_size]
        pop     dword [block_value]
        ret


;----------------------------
        align   4

nfa_19:
        db      6,"BUFFER",0
        alignhe
        dd      nfa_18
buffer_:
        dd      _constant
        dd      0D00h

;----------------------------
        align   4
nfa_last:
nga_20:
        db      7,"rdblock",0
        alignhe
        dd      nfa_19
        dd      _rdblock
 _rdblock:
        call    _pop    ;bufadr
        mov     [offset_data],ax
        xor     edx,edx
        call    _pop    ; block

        shld     edx,eax,4
        shl      eax,4
        mov     [sect],eax
        mov     [sect+2],edx

        pushad
        mov     eax,rdsec1
        and     eax,0ffffh

        mov     [rmback],eax


        mov     dword [pmback_offset],rdsec2
        jmp    switch_to_rm

        USE16
rdsec1:
        mov     ax,0b800h
        mov     fs,ax
        mov     dword [fs:12h],"D S "
        mov  dl,[7c00h]
        mov si,dap_p
        mov ah,42h
        int 13h
        jnb  rdsec3
         mov     dword [fs:1Ah],"E r "

rdsec3:
          mov     dword [fs:16h],"D G "
        jmp   switch_to_pm

        USE32
rdsec2:
        popad
        ret

dap_p:
        db 16
        db 0 ;zero
many_of:
        dw 16 ; many of sectors
offset_data:
        dw buffer_+4 ;0 ;offset of data
seg_data:
        dw 000h ;segment of data
sect:
        dd 3 ; number of sector
        dd 0
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
        mov    esp,01100h-36
        popad
        mov     esp,[esp_save]
        sti

        jmp     dword [pmback]

 ;----------------------------
         align   4
switch_to_rm:
         cli

         mov     [esp_save],esp
         mov    esp,01100h
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
          mov     sp,1500h
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
