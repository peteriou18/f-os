; memory map
;0-3ff - real idt
;4ff - boot drive number
;500 - cff - pm idt
;d00 - 10ff - temp stack
;1100- 14ff - real stack
;1500 - 1fff - pm stack
;2000 - 3fff buffer
;7c00-8000 - mbr code
;4000 - programm code
;90000-GDT
;
cell_size = 4 ; 32bit
data_stack_base = 8000h

macro alignhe
{ virtual
align 4
algn = $ - $$
end virtual
db algn dup 0
}
        ORG 4000h
;----------------------------
;entry point
;----------------------------
        USE32

        mov dword [gs:20], "  S "
        mov dword [gs:24], "t a "
        mov dword [gs:28], "r t "
        mov eax,msg_entry
        call    _push
        mov  eax,1
        call _push
        call _load

        mov dword [gs:32], "  F "
        mov dword [gs:36], "i n "
        mov dword [gs:40], "i s "
        mov dword [gs:44], "h   "

        jmp $
        mov eax,0xAAAAAAAA
        mov edx,0xBBBBBBBB
        call    edx

msg_entry db " F32 minimal loaded",10,13,0
;----------------------------
        align 4
nfa_0:
        db 7, "FORTH32",0
        alignhe
        dd nfa_1 ;LFA
        dd _vocabulary ;CFA
f32_list:
        dd nfa_last ;PFA - oeacaoaeu ia eoa iineaaiaai ii?aaaeaiiiai neiaa
_vocabulary:
        add eax,cell_size
        call _push
        ret
;----------------------------
        align 4
nfa_1:
        db 7,"BADWORD",0
        alignhe
        dd 0 ; zero LFA. End of search or link winth another vocabulary if not zero
        dd _vect
        dd abort_
_vect:
        mov eax,[eax+cell_size]
        call dword [eax]
        ret
;----------------------------
        align 4
nfa_2:
        db 4,"EXIT",0
        alignhe
        dd nfa_0
ret_:
        dd _ret
        _ret:
        pop eax
        pop eax
        ret
;----------------------------
        align 4
nfa_3:
        db 4,"Push",0
        alignhe
        dd nfa_2
        dd _push
_push:
        mov ebx,[stack_pointer]
        add ebx , cell_size
        and ebx , [data_stack_mask]
        mov [ ebx+data_stack_base ] , eax
        mov [stack_pointer],ebx
        ret
data_stack_mask dd 0x00ffff
stack_pointer dd 0
;----------------------------
        align 4
nfa_4:
        db 5,"ABORT",0
        alignhe
        dd nfa_3
abort_:
        dd _abort
_abort:
        mov esi,msgbad
        call os_output
        mov esi,[here_value]
        inc esi
        call os_output
        mov esi,msgabort
        call os_output
        ret
msgbad db " Badword: ",0
msgabort db " Abort!",0
;----------------------------
        align 4
nfa_5:
        db 4,"HERE",0
        alignhe
        dd nfa_4
        dd _constant
here_value:
        dd _here
;----------------------------
        align 4
nfa_6:
        db 9,"constant#",0
        alignhe
        dd nfa_5
        constantb_:
        dd _constant
        dd _constant
_constant:
        mov eax,[eax+4]
        call _push
        ret
;----------------------------
        align 4
nfa_7:
        db 3,"Pop",0
        alignhe
        dd nfa_6
        dd _pop
_pop:
        mov ebx,[stack_pointer]
        mov eax , [ ebx+data_stack_base]
        sub ebx , 4
        and ebx , [data_stack_mask]
        mov [stack_pointer],ebx
        ret
;----------------------------
        align 4
nfa_8:
        db 9,"INTERPRET",0
        alignhe
        dd nfa_7
        dd _interpret
_interpret:
        call _parse
        mov eax,context_value
        call _push
        call _fetch
        call _sfind
        call _execute_code
        jmp _interpret
;----------------------------
        align 4
nfa_9:
        db 5,"PARSE",0
        alignhe
        dd nfa_8
parse_:
        dd _parse
_parse:
        mov     eax,[block_value]
        mov eax,[block_value+8] ;input buffer
        call _push
        mov eax,[here_value] ;here
        call _push
        call _enclose
        ret
;----------------------------
        align 4
nfa_10:
        db 7,"CONTEXT",0
        alignhe
        dd nfa_9
context_:
        dd _variable_code
        context_value:
        dd f32_list
;--------------------------------
        align 4
nfa_11:
        db 7,"ENCLOSE",0
        alignhe
        dd nfa_10
        dd _enclose
_enclose:
        call _pop ; to address
        mov edi,eax
        call _pop ; from address
        mov esi,eax
        xor edx,edx
        add esi,[_in_value]
        mov ebx,edi
; clear 32 bytes
        xor eax,eax
        mov ecx,8
        rep stosd
        mov edi,ebx
        mov ecx,[block_value+4] ; size of buffer
        cmp ecx,edx
        jl _word2 ;jl
        inc edi
_skip_delimeters:
        sub dword [block_value+4],1 ; [nkey],1
        jb _word2
        lodsb
        inc dword [_in_value]
        cmp al,20h
        jbe _skip_delimeters
_word3:
        stosb
        inc edx
        sub dword [block_value+4],1 ; [nkey],1
        jb _word4
        lodsb
        inc dword [_in_value]
        cmp al,20h
        jnbe _word3
_word4:
; string to validate
         mov [ebx],dl
         ret
_word2:
; empty string
         mov dword [ebx],49584504h ;4,"EXI"
         mov dword [ebx+4],054h ;"T",0
         ret
;----------------------------
        align 4
nfa_12:
        db 1,"@",0
        alignhe
        dd nfa_11
fetch_:
        dd _fetch
_fetch:
        call _pop
        mov eax,[eax]
        call _push
        ret
;----------------------------
        align 4
nfa_13:
        db 5,"SFIND",0
        alignhe
        dd nfa_12
sfind_:
        dd _sfind
_sfind:
        call _pop
        mov esi,eax ;pop context
        mov esi,[esi] ;vocid
_find2:
        movzx ebx,byte [esi];word in vocab
        mov edx,ebx
        inc bl
        and bl,07ch ;mask immediate in counter
        mov edi,[here_value]
        movzx ecx,byte [edi] ; word on here
        shr ecx,2
        inc ecx
        mov ebp,esi
        mov eax,[edi]
find22:
        cmpsd
        jne _find11
        loop find22
        and edx,3
        cmp edx,3
        jne find23
        add esi,4
find23:
        mov eax,esi
        add eax,4
        call _push
        ret ;word found

_find11:
        mov esi,ebp
        add esi,4
        add esi,ebx
        mov ecx,esi
        mov esi,[esi]
_find4:
        test esi,esi
        jne _find2
        mov eax,ecx
        add eax,4
        call _push
        ret ; badword
;----------------------------
        align 4
nfa_14:
        db 7,"EXECUTE",0
        alignhe
        dd nfa_13
        dd _execute_code
        _execute_code:
        call _pop
_execute:
        call dword [eax]
        ret
;----------------------------
        align 4
nfa_15:
        db 5,"BLOCK",0
        alignhe
        dd nfa_14
block_:
        dd _variable_code
block_value:
        dd 1 ;block number
        dd 8192 ;size of buffer
        dd 2000h ;address of input buffer
;----------------------------
        align 4
nfa_16:
        db 9,"variable#",0
        alignhe
        dd nfa_15
variableb_:
        dd _constant
        dd _variable_code
_variable_code:
        add eax,cell_size
        call _push
        ret
;----------------------------
        align 4
nfa_17:
        db 3,">IN",0
        alignhe
        dd nfa_16
        dd _variable_code
_in_value:
        dd 0
;----------------------------
        align 4
nfa_18:
        db 4,"LOAD",0
        alignhe
        dd nfa_17
        dd _load
_load:
        push dword [block_value] ;block number
        push dword [block_value+cell_size] ; size of buffer
        push dword [block_value+cell_size+cell_size] ;address of buffer
        push dword [_in_value]
        mov eax,[buffer_+cell_size] ; buffer address
        mov [block_value+cell_size+cell_size],eax
        call _push
        call _rdblock

        xor ebx,ebx
        mov [_in_value],ebx
        mov dword [block_value+cell_size],8192
        call _interpret

        pop dword [_in_value]
        pop dword [block_value+cell_size+cell_size]
        pop dword [block_value+cell_size]
        pop dword [block_value]

        mov     eax,[block_value]
        call    _push
        mov     eax,[block_value+cell_size+cell_size]
        call    _push
        call    _rdblock
        ret
;----------------------------
        align 4
nfa_19:
        db 6,"BUFFER",0
        alignhe
        dd nfa_18
buffer_:
        dd _constant
        dd 02000h
;----------------------------
        align 4
nfa_20:
        db 7,"rdblock",0
        alignhe
        dd nfa_19
        dd _rdblock
_rdblock:
        call _pop ;bufadr
        mov [offset_data],ax
        xor edx,edx
        call _pop ; block
        shld edx,eax,4
        shl eax,4
        mov [sect],eax
        mov [sect+4],edx
        pushad
        mov eax,rdsec1
        and eax,0ffffh
        mov [rmback],eax
        mov dword [pmback],rdsec2
        jmp switch_to_rm

        USE16
rdsec1:


        mov dl,[0x4ff]
        mov si,dap_p
        mov ah,42h
        int 13h
        jnb rdsec3
mov dword [gs:0],"D i "
mov dword [gs:4],"s k "
mov dword [gs:8],"  E "
mov dword [gs:12],"r r "
mov dword [gs:16],"o r "
rdsec3:

        jmp switch_to_pm

dap_p:
db 16
db 0 ;zero
many_of:
dw 16 ; many of sectors
offset_data:
dw 2000h  ;buffer_+4 ;0 ;offset of data
seg_data:
dw 000h ;segment of data
sect:
dd 16 ;  number of sector
dd 0


        USE32
rdsec2:
        popad
        ret

;----------------------------
        USE32
        align 4
nfa_21:
         db        5,"TYPEZ",0
         alignhe
         dd nfa_20
         dd _typez
_typez:
        call    _pop
        mov     esi,eax
os_output:
        pushad
        mov eax,prtstr1
        and eax,0ffffh
        mov [rmback],eax
        mov dword [pmback],prtstr2
        jmp switch_to_rm

prtstr2:
        popad
        ret
symbols dd 0

        USE16
prtstr1:
        call prtstr4
        jmp switch_to_pm
prtstr4:
        mov al,[si]
        inc si
        cmp al,0
        je prtstr3
        mov ah,0eh
        int 10h
        jmp prtstr4
prtstr3:
        mov     ax,0e20h
        int     10h
        ret

;----------------------------
        align 4
        USE16
        switch_to_pm:
        cli

        mov eax, cr0
        or al, 0x01 ; Set protected mode bit
        mov cr0, eax
        wbinvd
        jmp far 8:pm2

esp_save dd 0
         USE32
pm2:

        mov eax, 16 ; load 4 GB data descriptor
        mov ds, ax ; to all data segment registers
        mov es, ax
        mov fs, ax

        mov ss, ax
        mov eax,40h
        mov gs,ax

        lidt [idtr]
        call remap_irq_pm
        call unmask_irqs
        mov esp,01100h-36
        popad
        mov esp,[esp_save]
        sti

        jmp dword [pmback]
;----------------------------
        align 4
switch_to_rm:
        cli
        mov [esp_save],esp
        mov esp,01100h
        pushad
        jmp 30h:rm3
        align 4
        USE16
rm3:
        mov eax,38h
        mov ds,ax
        mov es,ax
        mov ss,ax
        mov fs,ax
        mov ax,40h
        mov gs,ax
        mov eax, cr0
        and al, 0xfe
; clear protected mode bit
        mov cr0, eax
        wbinvd
        jmp 0:start163
        align 4

start163:
        xor ax,ax
        mov ds,ax
        mov es,ax
        mov ss,ax
        mov fs,ax
        mov ax,0b800h
        mov gs,ax
        mov sp,1500h
        call remap_irq_real
        lidt [rlidt]
        sti
        call unmask_irqs
        jmp far [rmback]
        USE32
;----------------------------
        align 4
rmback dd 0
pmback dd 0
pmback_offset dd 0
idtr: dw 7ffh
dd 500h
rlidt: dw 3ffh
dd 0
;----------------------------
        align 4
remap_irq_pm:
; Remap PIC IRQ's
        mov al, 00010001b ; begin PIC 1 initialization
        out 0x20, al
        mov al, 00010001b ; begin PIC 2 initialization
        out 0xA0, al
        mov al, 0x20 ; IRQ 0-7: interrupts 20h-27h
        out 0x21, al
        mov al, 0x28 ; IRQ 8-15: interrupts 28h-2Fh
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
        align 4
unmask_irqs:
; Enable specific interrupts
        in al, 0x21
        mov al, 11111001b ; Enable Cascade, Keyboard
        out 0x21, al
        in al, 0xA1
        mov al, 11111110b ; Enable RTC
        out 0xA1, al
        ret
;----------------------------
        align 4
remap_irq_real:
; Remap PIC IRQ's
        mov al, 00010001b ; begin PIC 1 initialization
        out 0x20, al
        mov al, 00010001b ; begin PIC 2 initialization
        out 0xA0, al
        mov al, 0x8 ; IRQ 0-7: interrupts 8h-0fh
        out 0x21, al
        mov al, 0x70 ; IRQ 8-15: interrupts 70h-78h
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

;----------------------------

        align   8
value:          dq      0;1234567890abcdefh
                dq      0 ;012345678h

zeroes:         dq      3030303030303030h
                dq      3030303030303030h

sixes:          dq      0606060606060606h
                dq      0606060606060606h

fes:            dq      0x0f0f0f0f0f0f0f0f
                dq      0x0f0f0f0f0f0f0f0f


;-----------------------
        align 4
nfa_22:
        db        3,"0xd",0
        alignhe
        dd nfa_21
        dd _0xd1
_0xd1:
        call    _number
        call    _0xd
        ret

_0xd:
        call            _pop
        mov             ebx,[eax+8]
        mov             ecx,[eax+12]
        bswap           ebx
        mov             edx,[eax+4]
        bswap           ecx
        mov             ebp,[eax]
        bswap           edx
        bswap           ebp
        mov             [eax+8],edx
        mov             [eax+12],ebp
        mov             [eax+4],ebx
        mov             [eax],ecx
        movdqu          xmm0,[eax]
        movdqu          xmm2,[fes]
        movdqu          xmm3,[sixes]
        movdqu          xmm4,[zeroes]
        movdqu          xmm7,[bytemask]
        psubb           xmm0,xmm4       ; ????? ????
        paddb           xmm0,xmm3       ; ???? ?????
        movdqa          xmm5,xmm0       ;
        pand            xmm0,xmm2       
        psubb           xmm0,xmm3       ;????? ?????
        psrlq           xmm5,4
        pand            xmm5,xmm2       ;???????? ?????? ????????
        paddb           xmm0,xmm5
        psllq           xmm5,3
        por             xmm0,xmm5
        movdqa          xmm6,xmm0
        
        pxor            xmm1,xmm1
        
        pand            xmm0,xmm7
        psrlq           xmm6,8
        pand            xmm6,xmm7
        
        packsswb        xmm0,xmm1
        packsswb        xmm6,xmm1
        psllq           xmm6,4
        por             xmm0,xmm6

        movdqu          dqword [value],xmm0
        mov             eax, dword  [value]
        call            _push
        mov             eax,dword[value+4]
        call            _push
        ret
;----------------------------
        align 4
nfa_23:
        db        2,"0x",0
        alignhe
        dd nfa_22
        dd _0x
_0x:
        call    _0xd1
        call    _pop
        ret

bytemask:       dq      0ff00ff00ff00ffh
                dq      0ff00ff00ff00ffh

;----------------------------
        align 4
nfa_24:
        db        6,"number",0
        alignhe
        dd nfa_23
        dd _number
_number:
        mov     esi,[block_value+8]
        xor     edx,edx
        add     esi,[_in_value]
        mov     edi,[here_value]
        mov     ebx,edi
        ; fill 32 bytes with zeroes
        mov     eax,30h
        mov     ecx,32
        rep     stosb
        
        mov     edi,ebx
        mov     ecx,[block_value+4] ; [nkey]
        cmp     ecx,edx ; edx=0
        jl      number2

        inc     edi
_skip_delimeters2:
        
        sub     dword [block_value+4],1 ; [nkey],1
        je      number2
        lodsb
        inc     dword [_in_value]
        cmp     al,20h
        jbe     _skip_delimeters2

        mov             edi,[here_value]
        add             edi,15
number3:
        ; move to here +15
        stosb
        inc     edx
        sub     dword [block_value+4],1 ; [nkey],1
        jb      number4
        lodsb
        inc     dword [_in_value]
        cmp     al,20h
        jne     number3

number4:
        ;normalize number
        ; edx - count of digits
        sub             edi,16
        mov             eax,edi
        call    _push
        ret

number2:
        
        ; empty string
   ;     mov     dword [ebx],2 ;dl
        mov     dword [_in_value],0
        ret
;--------------------
        align 4

nfa_25:
        db      1,",",0
        alignhe
        dd nfa_24
        dd _comma
_comma:
        mov     edx,[here_value]
        call    _pop    
        mov     [edx],eax
        add     dword [here_value],cell_size
        ret

;--------------------
        align 4

nfa_26:
        db      6,"HEADER",0
        alignhe
        dd nfa_25
        dd _header
_header:
        call    _parse
        mov     esi,[here_value]
        call    nlink2          ;esi - address of lf
        call    latest_code2    ;eax - latest

        mov     [esi],eax       ;fill link field
        mov     ebx,[here_value]
        mov     eax,[current_value]
        mov     [eax],ebx       ; here to latest
        add     esi,cell_size
        mov     [here_value],esi
        ret

;--------------------
        align 4

nfa_27:
        db      6,"N>LINK",0
        alignhe
        dd      nfa_26
nlink_:
        dd      _nlink
_nlink:
        call    _pop
        mov     esi,eax
        call    nlink2
        mov     eax,esi
        call    _push
        ret

nlink2:
        movzx   ebx,byte [esi]
        inc     bl
        and     bl,07Ch
        add     esi,ebx
        add     esi,4
        ret

;--------------------
        align 4

nfa_28:
        db      6,"LATEST",0
        alignhe
        dd      nfa_27
latest_:
        dd      _latest

_latest:
        call    latest_code2
        call    _push
        ret

latest_code2:
        mov     eax,[current_value]
        mov     eax,[eax] ; eax = latest nfa of curent vocabulary
        ret
;--------------------
        align 4
nfa_29:
        db      1,"'",0
        alignhe
        dd      nfa_28
        dd      _addr_interp
        dd      parse_
        dd      context_
        dd      fetch_
        dd      sfind_
        dd      ret_

;----------------------------
        align 4

nfa_30:
        db 7,"CURRENT",0
        alignhe
        dd nfa_29
current_:
        dd _variable_code
current_value:
        dd f32_list
;--------------------------------
        align 4
nfa_31:
        db      10,"interpret#",0
        alignhe
        dd      nfa_30
        dd      _constant
        dd      _addr_interp
_addr_interp:
        add eax,4
        push eax
        mov eax,[eax]
        call near dword [eax]
        pop eax
        jmp _addr_interp

;--------------------------------
        align 4

nfa_32:
        db      5,"CELL+",0
        alignhe
        dd      nfa_31
cellp_:
        dd      _cellp
_cellp:
        call    _pop
        add     eax,cell_size
        call    _push
        ret
;--------------------------------
        align 4

nfa_33:
        db      5,"ALIGN",0
        alignhe
        dd      nfa_32
align_:
        dd      _align

_align:
        mov     eax,[here_value]
        and    eax,3
        setne  al
        and    dword [here_value],0fffffffch
        shl    al,2
        add    [here_value],eax
        ret
;----------------------------
        align 4

nfa_34:
        db      1,"!",0
        alignhe
        dd      nfa_33
        dd      _store

_store:
        call    _pop    ; address
        mov             edx,eax
        call    _pop    ;data
        mov             [edx],eax
        ret
;--------------------------------
        align 4

nfa_35:
        db      9,"ASSEMBLER",0
        alignhe
        dd     nfa_34
        dd     _vocabulary
        dd     _nfa_assembler_last
;----------------------------
        align 4
nfa_36:
        db 7,"BADWORD",0
        alignhe
        dd nfa_last ; zero LFA. End of search or link winth another vocabulary if not zero
        dd _vect
        dd abort_

;----------------------------
        align 4
nfa_37:

        db 4,"EXIT",0
        alignhe
        dd nfa_36
        dd _ret
;----------------------------
        align 4
_nfa_assembler_last:
nfa_38:
        db      6,"opcode",0
        alignhe
        dd      nfa_37
        dd      _opcode_code
_opcode_code:
        call    _header
        mov     eax,[here_value]
        mov     dword [eax],op_compile_code
        call _pop
        mov cl,al
        mov edx,[here_value]
        add edx,4
        mov [edx],al
        inc edx
        and ecx,0ffh
        add dword [here_value],16 ;ecx
       ; inc dword [here_value]
oc1:
        call _pop
        mov [edx],al
        inc edx
        loop oc1
        call _align
        ret

        align 4

op_compile_code:
        movzx ecx,byte [eax+cell_size]
        inc eax
        mov edx,[here_value]
        add [here_value],ecx
occ1:
        mov bl,[eax+cell_size]
        mov [edx],bl
        inc eax
        inc edx
        dec cl
        jne occ1
        ret
;----------------------------
        align 4

nfa_39:
        db      6,"UNLINK",0
        alignhe
        dd      nfa_35
        dd      _unlink

_unlink:
        call    _badword_xt
        call    _pop
        mov      dword [eax-4],0
        ret

;----------------------------
        align 4

nfa_40:
        db      10,"BADWORD-xt",0
        alignhe
        dd      nfa_39
        dd      _badword_xt
_badword_xt:
        mov     edx,[here_value]
        mov     dword [edx], 44414207h
        mov     dword [edx+4],"WORD"
        mov     dword [edx+8],0
        call    _sfind
        ret
;----------------------------
        align 4
nfa_last:
nfa_41:
        db      4,"LINK",0
        alignhe
        dd      nfa_40
        dd      _link
_link:
        call    _pop
        mov     ecx,[eax]
        push    ecx
        call    _badword_xt
        call    _pop
        pop     ebx
        mov     dword [eax-4],ebx
        ret
;----------------------------
        align 4

_here:
        align   4096
        db      0
        align   2048
        db      0
        align   1024
        db      0
        align   512
        db      20h

;macro alignhe20
;{ virtual
 ;      align 8192
  ;     align 4096
   ;    align 2048
    ;   align 1024
     ;  align 512
      ;  algn = $ - $$
   ; end virtual
   ; db algn dup 20h
   ; }

  ;alignhe20
  ;db 20h
