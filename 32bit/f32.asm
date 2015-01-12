
 cell_size      = 4 ; 32bit
 neworg         = 200000h
 data_stack_base  =     100000h
 sti
tracefind equ 0
;%define neworg 200000h
include "f/fstart.asm"
include "f/atoitoa.asm"
include "f/io.asm"
;----------------------
_break: 
        push    eax
        push    esi
        call    os_print_newline
        mov             esi,_break2
        call    os_output
        pop             esi
        mov             eax,[esp+cell_size]
        call    os_debug_dump_eax
        pop             eax
        call    os_dump_regs
        push    eax
_break1:
        call    os_input_key
        jnb     _break1
        pop             eax
        ret
_break2 db      "Control point:",0

;------------------------------
 _pop:
        mov     ebx,[stack_pointer]
        mov     eax , [ ebx+data_stack_base]
        sub     ebx , 4
        and     ebx , [data_stack_mask]
        mov     [stack_pointer],ebx
        ret
;------------------------------     
  _push:
        mov     ebx,[stack_pointer]
        add     ebx , 4
        and     ebx ,  [data_stack_mask]
        mov     [ ebx+data_stack_base ] , eax
        mov     [stack_pointer],ebx
        ret
;--------------------------------
_timer: 
        rdtsc
       ; shl     eax,32
        ;shrd    eax,edx,32
        call    _push
        mov     eax,edx
        call    _push
        ret
;---------------------
        
_filen: db      "forth.blk", 0
fid:    dq      0
msgf:   db      "forth>",0 

;-------------------------
_count:
       ; push    ebx
        call    _pop
        mov     ebx,eax
        mov     ebx,[eax]
        and     ebx,03fh
        inc     eax
        call    _push
        mov     eax,ebx
        
        call    _push
       ; pop     ebx
        ret
;-------------------------
_variable_code:
        add             eax,cell_size
        call    _push
        ret
;-------------------------
_execute_code:
        call    _pop
_execute:
;mov            r14,[eax]
;call   _break
        call  dword [eax]
        ret
;------------------------
_fetch:
        call _pop
        mov eax,[eax]
        call _push
        ret
;-------------------------
_store:
        call    _pop    ; address
        mov             ebx,eax
        call    _pop    ;data
        mov             [ebx],eax
        ret
;-------------------------
_dup:
        call    _pop
        call    _push
        call    _push
        ret
;-------------------------
_interpret:
        ;call   _bl
        
        call    _word
        mov     eax,context_
        call    dword [eax]
        call    _fetch
        call    _sfind ; _find_task_frame
        ;call   _pop
        ;call   _hex_dot        
              ;  call   _dup
              ;  call   _hex_dot
        call    _execute_code
        jmp     _interpret

_bl:
        ret

;-------------------------
;get string from input buffer parse it and put to top of wordlist
_word:
        ;mov            eax,[block_value+8]
        ;mov            [block_value+8] ; [nkey],eax
        mov             eax,[block_value+8] ;input buffer
        call    _push
        mov             eax,[here_value]    ;here
        call    _push
        call    _enclose
        ret

;--------------------------------
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
;mov    r14,0x1
;mov    r13,[esi]
;call   _break
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
                        
        ;call   _skip_delimeters

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
;or     r14,0x7800
        ret

_word2:
        
        ; empty string
        ;mov    esi,msg7
        ;call   os_output
        mov     dword [ebx],2 ;dl
      ;  mov     dword [ebx+4],0
        mov     dword [_in_value],0
;mov            r13,[ebx]
;mov            r14,0x67
;call   _break
        
        ;mov    eax,[_in_value]
        
        ret
;------------------

        


;msg2   db      ' String prepared to find:',0
msg7    db      ' empty string ',0
;msg8   db      ' push symbol ',0
;msg5   db      ' skips ',0
;msg6   db      ' source string ',0
;-------------------------------
;search string from here in wordlist
_find_task:
        call    _pop
        test    eax,eax
        je      _find_task2 ; end of task
        inc     eax
        je      _find_task      ; empty slot
        dec     eax
        mov     esi,eax
        call    _sfind2
        call    _pop
        mov     ebx,eax
        call    _pop
        mov     ecx,eax
        
_find_task3:
        call    _pop
        test    eax,eax
        jne     _find_task3
        
        mov     eax,ecx
        call    _push
        mov     eax,ebx
        call    _push           
_find_task2:
        ret
;----------------------------   
_find_task_frame:
        call    _pop    ;address of context frame
        push    eax
ftf1:
        pop             eax
        add             eax,cell_size ;
        mov             esi,[eax-cell_size]
        test    esi,esi
        je              ftf             ; last slot - zero
        inc             esi
        je              ftf1
        dec             esi
        push    eax
mov     byte [0xb8158],"Q"
        call    _sfind2
        call    _pop ; flag. on stack rest xt
        
        test    eax,eax
        je              ftf1            ;nothing found in this context

;       call    _push           ;somefind found 
        pop             eax
        ret
ftf:
        ;
        ;mov            eax,badword_ ;cr_;_ret
        ;call   _push
        ;pop            eax
;       xor             eax,eax
;       call    _push
;       call    _break
        ret

_find:
        mov     eax,[context_value]
        call    _push

_sfind:
        call    _pop
        mov      esi,eax ;pop context
        call    _sfind2
        ret

_sfind2:
        mov     esi,[esi] ;vocid
    ;    mov     byte [0xb8154],"f"
       ; mov     ebp,esi
;push   esi
;mov            esi,edi
;mov             esi,[esi]
;call   os_output
;pop            esi
;int3
_find2:
        movzx   ebx,byte [esi];word in vocab
        mov     edx,ebx
        inc     bl
        and     bl,07ch               ;mask immediate in counter
        mov     edi,[here_value]
        movzx     ecx,byte [edi]     ; word on here
        shr     ecx,2
        inc     ecx
       mov     ebp,[esi]
       mov     eax,[edi]

; mov     byte [0xb8152],"l"

   ;     int3
  find22:
        cmpsd
; int3
        jne     _find11
        loop  find22
   ;     int3
         mov     byte [0xb8152],"F"

        cmp     edx,3
        jne     find23
        add     esi,4
 ;       add     esi,ebx
 find23:
        mov     eax,esi
        add     eax,4
        call    _push
;        mov     ecx,0xba5e
      ;  int3
      ;  xor     eax,eax
      ;  dec     eax
      ;  call    _push           ; word found
        ret

 _find11:
       ; dec       ecx
      ;  test       ecx,ecx
      ;  jne      find22

      ; jcxz    _find11
        add     esi,ebx
        mov     ecx,esi
        mov     esi,[esi]
        mov     ebp,0x5555
;int3
;        %if tracefind = 1
;                        push    ecx
 ;                       push    edi
  ;                      push    esi

  ;                      mov     eax,esi
  ;                      call    _push
  ;                      call    _hex_dot
  ;                      pop     esi
   ;                     push    esi
    ;                    call    os_output
     ;                   pop     esi
      ;                  pop     edi
       ;                 pop     ecx
 ;       %endif
        mov     byte [0xb8152],"c"
        test    esi,esi
        jne     _find2
        mov             eax,ecx
        sub             eax,8
        ;add            eax,24 ;mov     eax,badword_ ;cr_;ret_
;call   _break
;mov     ebp,[edi]
;mov     byte [0xb8152],"N"
        call    _push
     ;   int3
      ;  xor     eax,eax
      ;  call    _push
        ret                     ; nothing to find
        


;-------------------

_ret:
        pop     eax
        pop     eax
        
        ret
;--------------------
_constant:
        mov     eax,[eax+4]
        call    _push
        ret
;----------------------
_addr_interp:
        add eax,4
        push eax
        mov eax,[eax]
        call dword [eax]
        pop eax
        jmp _addr_interp

;------------------

_number:
        ;mov            eax,[block_value+8]
        ;mov            [block_value+8],eax ; [nkey],eax
        mov             esi,[block_value+cell_size]
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
;mov    r13,[esi]
;call   _break
        jl      number2 

        inc     edi
_skip_delimeters2:
        
        sub     dword [block_value+4],1 ; [nkey],1
        je      number2
        lodsb
        inc     dword [_in_value]
        cmp     al,20h
        jbe     _skip_delimeters2
                        
        ;call   _skip_delimeters
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
;mov    r14,[edi+8]
;call   _break
        mov             eax,edi
        call    _push
        ret

number2:
        
        ; empty string
        mov     dword [ebx],6 ;dl
        mov     dword [_in_value],0
        ret
;--------------------------
_nlink: 
        call    _pop
        mov             esi,eax
        call    nlink2
        mov             eax,esi
        call    _push
        ret
        
nlink2:
        movzx   ebx,byte [esi]
        inc     bl
        and     bl,078h
        add     esi,ebx
        add     esi,4
        ret
;--------------------------
_name:
        call    _pop
        call    nlink2
        ;add            esi,8
        mov             eax,esi
        call    _push
        ret
;--------------------------

_create:
        call    _word
        mov     esi,[here_value]
        call    nlink2          ;esi - address of lf
        call    latest_code2    ;eax - latest
        mov     [esi],eax       ;fill link field
        add     esi,4
        mov     dword [esi],_variable_code
        mov     ebx,[here_value]
        mov     eax,[current_value]
        mov     [eax],ebx       ; here to latest
        add     esi,4
        mov     [here_value],esi
        ret
;--------------------------------
_header:
        call    _word
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
;--------------------------------
_vocabulary:
        add             eax,cell_size
        call    _push
        ret
        
;--------------------------------
_latest:
        call    latest_code2
        call    _push
        ret

latest_code2:
        mov     eax,[current_value]
        mov     eax,[eax] ; eax = latest nfa of curent vocabulary
        ret
;--------------------------------
_comma:
        mov     ebx,[here_value]
        call    _pop    
        mov     [ebx],eax
        add     dword [here_value],cell_size
        ret
;--------------------------------
_vocabulary_create:
        call    _header
        mov     esi,[here_value]
        mov             eax,esi
        
        mov     dword [esi],_vocabulary
        add     esi,12
        mov     [esi-8],esi    ;link to empty word, which is last in this list
;mov    qword [esi-16],_vect
mov     dword [esi-cell_size],_abort
;add    esi,8
        ; set zero word 
        mov     dword [esi],6
        add     esi,cell_size
        xor     eax,eax
        mov     [esi],eax
        
        add     esi,cell_size
        mov     dword [esi],_ret
        add     esi,cell_size
        mov     [here_value],esi
                
        ;mov            eax,esi
        ;call   _push
        ;call   _hex_dot
        ret
;--------------------------------
_cellp:
        ;add     dword [r10 + r8],cell_size
        ret
;--------------------------------
_cellm:
        ;sub     qword [r10 + r8],cell_size
        ret
;--------------------------------

;--------------------------------

_allot:
        call    _pop
        add             [here_value],eax
        ret
;--------------------------------
_vect:
        mov     eax,[eax+cell_size]
        call    dword [eax]
        ret
;--------------------------------
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
;--------------------------------
_load:
        push    dword [block_value]
        push    dword [block_value+cell_size]
        push    dword [block_value+cell_size+cell_size]
        push    dword [_in_value]
        
        mov             eax, buffer_+cell_size
        mov             [block_value+8],eax
        call    _push
        call    _rdblock
        
        xor             ebx,ebx
        mov             [_in_value],ebx
        mov             dword [block_value+cell_size],8192
        
        call    _interpret
        
        pop             dword [_in_value]
        pop             dword [block_value+8]
        pop             dword [block_value+cell_size]
        pop     dword [block_value]
        ret

;--------------------------------
_plus:
        call    _pop
        ;add             [r10 + r8],eax
        ret
;--------------------------------

_opcode_code:
call _create
mov eax,[here_value]
mov dword [eax-cell_size],op_compile_code
call _pop
mov cl,al
mov ebx,[here_value]
mov [ebx],al
inc ebx
and ecx,0ffh
add [here_value],ecx
inc dword [here_value]
oc1:
call _pop
mov [ebx],al
inc ebx
loop oc1
ret

op_compile_code:
movzx ecx,byte [eax+cell_size]
inc eax
mov edx,[top_of_code_val]
add [top_of_code_val],ecx
occ1:
mov bl,[eax+cell_size]
mov [edx],bl
inc eax
inc edx
dec cl
jne occ1
ret
;--------------------------------
_sp@:
        mov             eax,[stack_pointer]
        call    _push
        ret
;--------------------------------
_resn:
        call    _pop
        add             [top_of_code_val],eax
        ret
;--------------------------------
lit_code:
        mov eax,[esp+cell_size]
        mov eax,[eax+cell_size]
        call _push
        add dword [esp+cell_size],cell_size
        ret
;--------------------------------
_link:
; aa bb
                call    _pop    ;base vocabulary
                mov             ebx,eax
                call    _pop    ;linking vocabulary
                mov             ebx,[ebx]
                add             eax,24
                mov             [eax],ebx
                ret
;--------------------------------
_unlink:
                call    _pop
                mov             dword [eax+24],0
                ret
;--------------------------------       
label_code:
                call _create
                mov eax,[here_value]
                mov dword [eax-cell_size],label_compile_code
                call _comma
                ret
;------------------------------
label_compile_code:
                mov ebx,[eax+cell_size]
                sub ebx,cell_size
                mov eax,[top_of_code_val]
                sub ebx,eax
                mov [eax],ebx
                add dword [top_of_code_val],cell_size
                ret     
;--------------------------
code_top:
;mov     eax,0xAAAAAAAAAAAAAAAA
;mov     r11,0xBBBBBBBBBBBBBBBB
mov     eax,[eax]
call    eax
;call    r11
;call    [r11]

mov     ebx,eax
sub     eax,ebx
je      code_top
;align 32, db 0cch



nkey    dq      0


align 8192
vocabulary:
;section seconf start=neworg

include "vocabulary.asm"

_here:

        db      6,0,0
        
        dq      nfa_34

;align   8192,  db 0xbc
times   7680 db 0xcd

;        include "f/blocks.asm"
