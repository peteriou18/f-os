        st_b equ 3000h
        heap equ 200h
        org 7c00h

        cli
        cld
        xor ax,ax
        mov ds,ax
        mov ax,3000h
        mov ss,ax
        xor sp,sp
        sti
        mov     ax,0b800h
        mov     fs,ax
        mov     ax,4000h
        mov     gs,ax

;-------------------
;ñíèìàåì ïàðàìåòðû äèñêà. íàì èíòåðåñíî êîëè÷åñòâî ñåêòîðîâ
;-------------------
        mov ah,48h
        mov dl,80h
        push ds
        mov si,4000h
        mov ds,si
        mov si,0ff00h
        mov word [si],1eh
        int 13h
        pop ds

;-----------------
;ãðóçèì ñòàòèê
;-----------------
        mov [sect],dword 800h
        mov [many_of], word 7fh
        mov [offset_data], word  0
        mov [seg_data], word 4000h
        mov si,dap_p
        mov ah,42h
        int 13h

;-------------
; ãðóçèì 3 ñåêòîðà ñ êîäîì
;------------
        mov [sect],dword 1
        mov [many_of], byte 4
        mov [offset_data],word 0
        mov [seg_data],word 1000h
        mov si,dap_p
        mov ah,42h
        int 13h

;-------------
; ãðóçèì 4 ñåêòîðà ñî ñëîâàðåì
;-------------
        mov [sect],dword 4
        mov [many_of], byte 4
        mov [offset_data],word 3080h
        mov [seg_data],word 2000h
        mov si, dap_p
        mov ah,42h
        int 13h
        jmp 1000h:0
   m1:
        mov     [ebx],ax
        mov     dl,[ebx+ecx]
        mov     [eax+ecx],dl
        mov     dl,[ebx]
        mov     [eax],dl
        add     eax,40000
        add     edx,22222
        mov     ebx,[eax]
        mov     [esp+2],eax
        and     ebx,0ffh
        mov     eax,[eax]
        mov     eax,[esp+2]
        or      eax,80000000h
        mov     dx,0adceh
        mov     edx,eax
        jmp     0:7c00h
        mov     [edx],al
        inc     edx
        sub     [ebx],eax
        sub     [eax],ebx
        lea     eax,[esi*4]
        mov     cl,[eax+1]
        mov     [eax],cl
        mov     [ebx],al
        dec     ebx
        cmp     eax,ebx
        mov     cl,[ebx-1]
        mov     [ebx],cl
        add     edx,200h
        mov     edx,here_var
        lea     eax,[eax*2+eax]
        lea     eax,[eax*2]
        add     esp,eax
        xor     edx,edx
        mov     eax,edx
        div     edx
        add     [eax],ebx
        mov     word [fs:bx],9999h
        inc     bx
        mov     cx,3333h
        add     eax,ebx
        sub     eax,ebx
        and     eax,ebx
        or      eax,ebx
        xor     eax,ebx
         imul   ebx
         call    pop_code
        mov     ebx,[top_of_code_val]
        mov     [ebx],ax
        add     dword [top_of_code_val],2
        ret
       mov     bh,1
        mov     ch,3
        mov     cl,3h
        mov     dh,13h
        mov     dl,43h
        mov     al,1
        add     bx,0a0h
        mov    word [fs:eax],1f55h
        inc     eax
        dec     ebx
        jne     m1
        movzx   eax,byte [eax]
        mov     edx,eax
        push    eax
        xor     ebx,ebx
        mov     al,[edx]
        mov     [fs:ebx],ax
        pop     ecx
        mov     ecx,ebx
        mov     ecx,eax
        mov     [fs:edx],ax
        inc    dword [eax]
        add     dword [eax],2
        add     dword [eax],4
     ;   inc     eax
     ;   dec     dword[eax]

dap_p:
        db 16
        db 0        ;zero

many_of:
        dw 1        ; many of sectors

offset_data:
        dw 1000h        ;offset of data
seg_data:
        dw 2000h    ;segment of data
sect:
        dd 8         ; number of sector
        dd 0


       rept 3 { db 0 }
;      align  512-48
; partition table
       rept 4 {
       db 80h
       db 01,01,0
       db 07
       db 0,0,0
       dd 8
       dd 0ffffffh    }

       db 55h,0aah
;-----------
; êîä íà÷èíàåòñÿ çäåñü
;----------

        org 0
        xor si,si
        mov ax,2000h
        mov es,ax
        mov ds,ax


 ; çàãðóæàåì ñèñòåìó èç èñõîäíûõ êîäîâ

        mov     eax,1
        call    push_code
        call    load_code
f86:
        mov eax,">"
        call push_code
        call emit_code
        call    query_code
        call    interpret_code
        jmp     f86


interpret_code:
interpret2:
        mov eax,20h
        call push_code
        mov     eax,word_
        call    word [eax]  ;code
         call    find_code
         call    pop_code

        test    eax,eax
        je      notfound_code
        mov     ecx,[state_var]
        test    ecx,ecx
        je      execution_mode

; compiling mode
        cmp     eax,-1
        jne     execution_mode

; compilng
        call    comma_code

        jmp interpret2

execution_mode:

        call    execute_code
        jmp interpret2


 notfound_code:
        call    count_code
        call    type_code
        call    blanc_code
        mov     ax,0ed7h
        int     10h
        ret


emit_code:
        call pop_code

emit0:
        mov ah,0eh
        int 10h
        ret

rblock_code:
        mov     ax,0e23h    ;#
        int     10h
        mov     byte [cs:op],42h
        jmp    disk_code

wrblock_code:
        mov     byte [cs:op],43h

disk_code:
        call pop_code             ;address of buffer
        mov [cs:off_data],ax      ;
        call pop_code      ;block
        shl eax,3
        mov [cs:rbp_sect],eax
        mov ah,[cs:op]
        mov dl,80h
        push si
        push ds
        push cs
        pop ds
        mov si,rbp_data
        int 13h
        pop ds
        pop si
 rc0:
        ret

  op    db      42h

rbp_data:
        db 16
        db 0        ;zero

how_many_sectors:
        dw 8         ; many of sectors

off_data:
        dw 1000h        ;offset of data
sg_data:
        dw 2000h    ;segment of data
rbp_sect:
        dd 8         ; number of sector
        dd 0



enclose_code:

        call    pop_code    ; address of input stream buffer
        mov     ebx,eax
        call    pop_code    ;address to store word
        mov     ebp,eax
        call    pop_code    ;symbol
        xor     ecx,ecx
        mov edi,[value_in]


;--------
; óñåêíîâåíèå ãîëîâíûõ ïðîáåëîâ
;--------

wc1:
        inc edi
        cmp     edi,0fffh
        je      wc4 ;äîáðàëèñü äî êîíöà áóôåðà, íàäî âûäàòü ñëîâî íîëü
        cmp [edi+ebx-1],al
        je wc1
;----------------
;  ïåðåíîñ íà âåðøèíó ñëîâàðÿ ïîêà íå íàéäåì ïðîáåë
;----------------
        mov edx,ebp

wc3:
        mov ah,[edi+ebx-1]
        inc edi
        cmp     edi,0fffh
        je      wc2  ; äîáðàëèñü äî êîíöà áóôåðà, òåðìèíèðîâàòü
        cmp ah,al
        je  wc2         ; Ïåðåòàùèëè
        mov [edx+1],ah
        inc ecx
        inc edx
        jmp wc3

wc2:
        mov [edx+1],dword 0
        mov edx,ebp
        dec edi
        mov [edx],cl
        mov [value_in],edi
        mov eax,ebp
        call push_code
        ret

wc4:
        mov    dword [edx],20a0d02h
        mov     eax,ebp
        call    push_code
        ret


find_code:

        call pop_code ;àäðåñ ñòðîêè ñî ñ÷åò÷èêîì äëÿ ïîèñêà
        mov ebx,eax                 ;   ìåñòî êóäà  âîðä ïåðåòàñêèâàåò ñòðîêó
        mov edx,[context_var]
        mov edx,[edx]           ; nfa ïîñëåäíåãî ñëîâà


fc3:    xor     ecx,ecx
        mov edi,ebx     ; âîðä
        mov ebp,edx      ; ñëîâàðü
        mov al,[edi]  ;ñðàâíèì ñ÷åò÷èêè
        mov cl,[edx]  ;ñî ñëîâàðÿ
        mov     ch,cl
        and     cl,3fh

        cmp     al,cl
        jne     fc0
fc2:

        inc     edi
        inc     edx
        mov al,[edx]   ;ñëîâàðü
        cmp al,[edi]  ; âîðä
        jne fc0
        dec     cl
        jne      fc2

        add edx,6 ;to CFA
        mov eax,edx
        call push_code
        and     ch,80h
        shr     ecx,14
        dec     ecx
        mov     eax,ecx
        call push_code
        ret
  ;---------
; ñ÷åò÷èê íå îáíóëèëñÿ,   îáíàðóæåíî ðàñõîæäåíèå
;---------

fc0:

         mov edx,ebp         ;ñëîâàðü
         movzx eax,byte [edx]      ;ñ÷åò÷èê ñî ñëîâàðÿ
         and    eax,3fh
         add edx,eax
         add edx,2

         mov edx,[edx]            ;ñëåäóþùèé nfa

         test edx,edx          ; $nfa -0?

         je fc4                 ;íåò â ñëîâàðå
          mov eax,edx
          jmp fc3

;-----------
;íå  ñîâïàëî
;----------


fc4:
        mov eax,ebx
        call push_code
        xor eax,eax
        call push_code
        ret



execute_code:

        call pop_code
ec0:
        call word [eax]
        ret

variable_code:

        add     eax,4
        call    push_code
        ret

_@_code:
        call    pop_code
        mov     eax,[eax]
        call    push_code
        ret

_!_code:

        call    pop_code       ;address
        mov     ebx,eax
        call    pop_code      ;value
        mov     [ebx],eax
        ret

;------------
;íà ñòåêå ëåæèò àäðåñ è ñ÷åò÷èê
;
;-------------
type_code:
        call pop_code    ;ñíÿëè ñ÷åò÷èê
        mov ecx,eax
        call pop_code
        mov edi,eax      ;ñíÿëè àäðåñ.

tc1:
        mov ah,0eh
        xor bx,bx
tc0:
        mov al,[edi]
        int 10h
        inc edi
        dec cl
        jne tc0
        ret

push_code:
        inc esi
        and esi,3fh
        mov [esi*4+st_b],eax
        ret

pop_code:
        mov eax,[esi*4+st_b]
        dec esi
        and esi,3fh
        ret


_0x_code:

        mov eax,20h
        call push_code
        mov     eax,word_
        call word [eax]
        call pop_code
        xor  edx,edx
        mov ebx,eax
        movzx ecx,byte [eax]
        inc ebx

_0x2:
        call _0x1
        loop _0x2
        ror     edx,4
        mov eax,edx
        call push_code
      ;  cmp     dword [state_var],-1
      ;  jne _0x3
      ;  mov     eax,[here_var]
      ;  mov    dword [eax],lit_code
      ;  call    comma_code
_0x3:
        ret

_0x1:
        mov al,[ebx]
        sub al,30h
        cmp al,10
        jng _0x0
        Add al,09h



_0x0:
        and     al,0fh
        or      dl,al
        inc     ebx
        rol     edx,4
        ret

count_code:
        call pop_code
        movzx ecx,byte[eax]
        inc eax
        call push_code
        mov eax,ecx
        call push_code
        ret

blanc_code:
        mov ax,0e20h
        int 10h
        ret


dup_code:
        mov     eax,[esi*4+st_b]
        inc     esi
        mov     [esi*4+st_b],eax
        ret

create_code:
        mov      eax," "
        call    push_code
        mov     eax,word_
        call    word [eax]
        call    find_code
        call    pop_code
        test    eax,eax
        jne     bc0
;---------------
;íåò îïðåäåëåíèÿ, ñîçäàäèì
;--------------

        mov     eax,[here_var]
        mov     edx,eax
        movzx   ecx,byte [eax]     ;Âûöåïèëè ñ÷åò÷èê. ïîäíÿòü âåðøèíó ñëîâàðÿ íàäî íà ñ÷åò÷èê+1(ñ÷åò÷èê)+1(êîíå÷íûé íîëü)+4(ïîëå ñâÿçè)+4(ïîëå êîäà)   +4(ïîëå ïàðàìåòðîâ)=ñ÷åò÷èê+14
        add     ecx,10
        add     ecx,eax
        mov     [here_var],ecx    ; ïåðåäâèíóëè õåðå

        mov     ebx,[current_var]   ;ebx=f86list edx=here
        mov     edi,[ebx]       ; nfa ïîñëåäíåãî ñëîâà
        mov     [ebx],edx ; ïåðåñòàíîâêà óêàçàòåëÿ èç ñïèñêà íà íîâîîïðåäåëåííîå ñëîâî
        mov     [ecx-8],edi                       ;lf
        mov    dword  [ecx-4],variable_code        ; cf
        call    pop_code
        ret

bc0:
        call    pop_code
        ret


constant_code:

        mov     eax,[eax+4]
        call    push_code
        ret

comma_code:
        call    pop_code
        mov     ebx,[here_var]
        mov     [ebx],eax
        add    dword  [here_var],4
        ret

colon_code:
        call    create_code
        mov      dword [state_var],-1
        mov     eax,[here_var]
        sub     eax,4   ;cfa
        mov     dword [eax],addr_interp
        ret


ret_code:
        pop     ax
ret1:
        POP     EAX
        ret

false_!_code:
        call    pop_code
        mov     dword [eax], 0
        ret

true_!_code:
        call    pop_code
        mov     dword [eax],-1
        ret


addr_interp:
        add     eax,4
        push    eax
        mov     eax,[eax]
        call   word [eax]
        pop     eax
        jmp     addr_interp



nlink_code:
        call     pop_code
        mov      cl,byte[eax]
        and     ecx,3fh
        add     eax,ecx
        add     eax,2
        call    push_code
        ret



expect_code:
        mov     ecx,0fffh
        mov     ebx,[tib_var]

expect0:
        dec     ecx
        je      expect1
        xor     ax,ax
        int     16h
        mov     ah,0eh
        int     10h
        mov     [ebx],al
        inc     ebx
        cmp     al,08
        je     expect2
        cmp     al,0dh
        jne     expect0
        mov     al,0ah
        INT     10H
        mov    dword [ebx-1],200a0d20h
        add     ebx,3

expect1:
        sub     ebx,[tib_var]
        mov      [span_var],ebx
        ret

expect2:
        dec     ebx
        inc     ecx
        dec     ebx
        inc     ecx
        jmp     expect0


query_code:
        call    expect_code
        xor     eax,eax
        mov     [value_in],eax
        mov     [blk_var],eax
        ret


to_body_code:
plus_cell_code:
        call    pop_code   ;âàðèàíò
        add     eax,4             ; add dword [esi*4+st_b],4
        call    push_code
        ret

load_code:
        call    pop_code
        push    dword [blk_var]
        push    dword [value_in]
        push    dword [tlb_var]

        mov     [blk_var],eax
        xor     eax,eax
        mov     [value_in],eax
        call    interpret_code
        mov     eax,[value_in]
        mov     [in_old],eax
        pop     dword [tlb_var]
        pop     dword [value_in]
        pop     dword [blk_var]
        ret


?br_code:
        call    pop_code
        test eax,eax
        jne    br_code
        add     dword [esp+2],4
        ret

br_code:
        mov     eax,[esp+2]
        mov     eax,[eax+4]
        sub     eax,4
        mov     [esp+2],eax
        ret

_eq_code:
        call    pop_code
        mov     ebx,eax
        call    pop_code
        cmp ebx,eax
        sete al
        movsx eax,al
        call push_code
        ret

not_eq_code:
      ;  call pop_ab

        call    pop_code
        mov     ebx,eax
        call    pop_code
        cmp ebx,eax
        setne al
        movsx eax,al
        call push_code
        ret

or_!_code:
         call    pop_code
        mov     ebx,eax
        call    pop_code
;        call    pop_ab
        or      [eax],ebx  ;wrong
        ret

to_cf_code:
        call    pop_code
        mov     ebx,[here_var]
        mov     [ebx-4],eax
        ret


constant_create_code:
        call    create_code
        mov     eax,[here_var]
        mov     dword [eax-4],constant_code
        call    comma_code
        ret


dot_quote_code:        ; ðàñïå÷àòàòü ñòðîêó ñî ñ÷åò÷èêîì íà÷èíàþùóþñÿ ñî ñëä ÿ÷åéêè
        mov     eax,[esp+2]
        mov     edi,eax
        mov     cl,[edi+4]
        add     edi,5
        and     ecx,0ffh
        mov     eax,edi
        add     eax,ecx
        sub     eax,3
        mov     [esp+2],eax
        call    tc1
        ret

bin_compile_code:
        call    pop_code
        mov     ebx,[top_of_code_val]
        mov     [cs:ebx],eax
        add    dword [top_of_code_val],4
        ret

opcode_code:
        call    create_code
        mov     eax,[here_var]
        mov     dword [eax-4],op_compile_code
        call    pop_code
        mov     cl,al
        mov     ebx,[here_var]
        mov     [ebx],al
        inc     ebx
        and     ecx,0ffh
        add     [here_var],ecx
        inc     dword [here_var]
oc1:
        call    pop_code
        mov     [ebx],al
        inc     ebx
        loop    oc1
        ret

op_compile_code:
        movzx     ecx,byte [eax+4]
        inc     eax
        mov     edx,[top_of_code_val]
        add     [top_of_code_val],ecx
occ1:
        mov     bl,[eax+4]
        mov     [cs:edx],bl
        inc     eax
        inc     edx
        dec     cl
        jne     occ1
        ret
;code@:
;        call    pop_code
;        mov     eax,[cs:eax]
;        call    push_code
;        ret

wcode_c:
       ; call    pop_code
      ;  mov     ebx,[top_of_code_val]
      ;  mov     [ebx],ax
      ;  add     dword [top_of_code_val],2
       ; ret

label_code:
        call    create_code
        mov     eax,[here_var]
        mov     dword [eax-4],label_compile_code
        call    comma_code
        ret

label_compile_code:
        mov     ebx,[eax+4]
        sub     ebx,2
        mov     eax,[top_of_code_val]
        sub     ebx,eax
        mov     [cs:eax],bx
        add     dword [top_of_code_val],2
        ret

lit_code:
        mov     eax,[esp+2]
        mov     eax,[eax+4]
        call    push_code
        add     dword [esp+2],4
        ret

sc_code:
        call pop_code
        mov     edx,eax
        mov     ah,02
        xor     ebx,ebx
        int     10h
        ret

lso3:
        call    pop_code
        mov     ebx,eax
        call    pop_code
lso4:
        mov     cl,[eax+1]
        mov     [eax],cl
        inc     eax
        cmp     eax,ebx
        jne     lso4
        ret

mark_f_code:      ;îòìåòèòü ìåñòî, êóäà áóäåò ñîõðàíÿòüñÿ ññûëêà âïåðåä
      ;  here @
mark_b_code:
resolve_f_code:
resolve_b_code:
    ;    ret

top_of_code:

       align 512
 ;----------

; íà÷àëî ñëîâàðÿ
;-----------
        org 3080h
vocab:
        dd 3080h

nfa_0:
        db 7, "FORTH86" ; ñëîâàðü äëÿ ñëîâ ðåàëüíîãî, âèðòóàëüíîãî 86
        db 0 ; òåðìèíèðóþùå-âûðàâíèâàþùèå íóëè
        dd 0 ;LFA
        dd 0 ;CFA
f86_list:
        dd nfa_a ;PFA - óêàçàòåëü íà ëôà ïîñëåäíåãî îïðåäåëåííîãî ñëîâà
        dd      0 ; ññûëêà íà ïðåäûäóùèé ñïèñîê. áåçáàçîâûé ñïèñîê
nfa_1:

        db 4, "EMIT"
        db 0
        dd nfa_0
        dd emit_code
        dd 0
nfa_2:
        db 4, "TYPE"
        db 0
        dd nfa_1
type_:
        dd  type_code
        dd 0
nfa_3:
        db 4, "ret_"
        db 0
        dd nfa_2
ret_c:
        dd constant_code
        dd ret_

nfa_4:
        db 6, "RBLOCK"
        db 0
        dd nfa_3
rblock_:
        dd rblock_code
        dd 0

nfa_5:
        db 3, "IN>"
        db 0
        dd nfa_4
        dd variable_code
value_in  dd 0
in_old  dd      0

nfa_6:
        db 7, "CURRENT"
        db 0
        dd nfa_5
current_:
        dd variable_code
current_var:
        dd f86_list

nfa_7:
        db 8, "lit_code"
        db 0
        dd nfa_6
        dd constant_code
        dd lit_  ;code
lit_:
        dd      lit_code

nfa_8:
        db 2h,"0x"
        db 0
        dd nfa_7
        dd _0x_code
        dd 0

nfa_9:
        db 5,"COUNT"
        db 0
        dd nfa_8
count_:
        dd count_code
        dd 0

nfa_10:
        db 3,"DUP"
        db 0
        dd nfa_9
dup_:
        dd dup_code
        dd      0

nfa_11:
        db 5,"SPACE"
        db 0
        dd nfa_10
space_:
        dd blanc_code
        dd 0

nfa_12:
        db      1,"@"
        db      0
        dd      nfa_11
 _@_:
        dd      _@_code
        dd      0

nfa_13:
        db      1,"!"
        db      0
        dd      nfa_12
_!_:
        dd      _!_code
        dd      0

nfa_14:
        db      7,"EXECUTE"
        db      0
        dd      nfa_13
        dd      execute_code
        dd      0

nfa_15:
        db      4,"FIND"
        db      0
        dd      nfa_14
find_:
        dd      find_code
        dd      0

nfa_16:
        db      4,"WORD"
        db      0
        dd      nfa_15
word_:
        dd      addr_interp ; word_code
        dd      blk_
        dd      _@_
        dd      ?br_
        dd      w1

        dd      here_
        dd      _@_
        dd      tib_
        dd      enclose_       ; symbol to from
        dd      ret_
w1:
        dd      blk_
        dd      _@_
        dd      block_
        dd      here_
        dd      _@_
        dd      buffer_1_
        dd      _@_
        dd      enclose_
        dd      ret_


nfa_17:
        db      4,"HERE"
        db      0
        dd      nfa_16
here_:
        dd      variable_code
here_var:
        dd      here

nfa_18:
        db      7,"CONTEXT"
        db      0
        dd      nfa_17
        dd      variable_code
context_var:
        dd      f86_list

nfa_19:
        db      6,"CREATE"
        db      0
        dd      nfa_18
        dd      create_code
        dd      0

nfa_20:
        db      2,"BL"
        db      0
        dd      nfa_19
bl_     dd      constant_code
        dd      " "

nfa_21:
        db      1,","
        db      0
        dd      nfa_20
comma_:
        dd      comma_code
        dd      0

nfa_22:
        db      11,"buffer_size"
        db      0
        dd      nfa_21
        dd      constant_code
        dd      1000h


nfa_23:
        db      5,"QUOTE"
        db      0
        dd      nfa_22
        dd      constant_code
        dd      22h

nfa_24:
        db      7,"ENCLOSE"       ; symbol to_adress from-address
        db      0
        dd      nfa_23
enclose_:
        dd      enclose_code
        dd      0

nfa_25:
        db      2,".("
        db      0
        dd      nfa_24
        dd      addr_interp
        dd      close_bracket
        dd      word_
        dd      count_
        dd      type_
        dd      ret_

nfa_26:
        db      5,"STATE"
        db      0
        dd      nfa_25
state_:
        dd      variable_code
state_var:
        dd      0

nfa_27:
        db      1,":"
        db      0
        dd      nfa_26
        dd      colon_code
        dd      0



nfa_28:
       db       6,"FALSE!"
       db       0
       dd       nfa_27
false_!_:
       dd       false_!_code
       dd       0

nfa_29:
        db      5,"TRUE!"
        db      0
        dd      nfa_28
true_!_:
        dd      true_!_code
        dd      0

nfa_30:
        db      1,")"
        db      0
        dd      nfa_29
close_bracket:
        dd      constant_code
        dd      ")"


nfa_31:
        db      2,"3F"
        db      0
        dd      nfa_30
latest_:
        dd      constant_code
        dd      03fh

nfa_32:
        db      4,"EXIT"
        db      0
        dd      nfa_31
ret_:
        dd      ret_code
        dd      0

nfa_33:
        db     81h,"["
        db      0
        dd      nfa_32
        dd      addr_interp
        dd      state_
        dd      false_!_
        dd      ret_

nfa_34:
        db      7,"sg_data"
        db      0
        dd      nfa_33
        dd      constant_code
        dd      sg_data

nfa_35:
        db      16,"addr_interpreter"
        db      0
        dd      nfa_34
ai:     dd      constant_code
        dd      addr_interp

nfa_36:
        db      81h,";"
        db      0
        dd      nfa_35
        dd      addr_interp
        dd      ret_c
        dd      comma_
        dd      state_
        dd      false_!_
        dd      ret_

nfa_37:
        db      5,"QUERY"
        db      0
        dd      nfa_36
        dd      query_code
        dd      0

nfa_38:
        db      3,"TIB"
        db      0
        dd      nfa_37
tib_:
        dd      constant_code
tib_var:
        dd      0


nfa_39:
        db      6,"EXPECT"
        db      0
        dd      nfa_38
        dd      expect_code
        dd      0

nfa_40:
        db      4,"SPAN"
        db      0
        dd      nfa_39
        dd      variable_code
span_var:
        dd      0

nfa_41:
        db      3,"BLK"
        db      0
        dd      nfa_40
blk_:
        dd      variable_code
blk_var:
        dd      0

nfa_42:
        db      3,"tlb"
        db      0
        dd      nfa_41
tlb:
        dd      variable_code
tlb_var:
        dd      0

nfa_43:
        db      82h,0dh,0ah
        db      0
        dd      nfa_42
        dd      ret1
        dd      0

nfa_44:
        db      1,"]"
        db      0
        dd      nfa_43
        dd      addr_interp
        dd      state_
        dd      true_!_
        dd      ret_

nfa_45:
        db      5,">BODY"
        db      0
        dd      nfa_44
to_body_:
        dd      to_body_code
        dd      0

nfa_46:
        db      4,"bin,"
        db      0
        dd      nfa_45
        dd      bin_compile_code
        dd      0

nfa_47:
        db      8,"BUFFER_1"
        db      0
        dd      nfa_46
buffer_1_:
        dd      variable_code
buffer_1:
        dd      1000h
        dd      0
        dd      0

nfa_48:
        db      8,"BUFFER_2"
        db      0
        dd      nfa_47
        dd      variable_code
        dd      2000h
        dd      0
        dd      0

nfa_49:
        db      7,"buf_adr"
        db      0
        dd      nfa_48
        dd      addr_interp
        dd      _@_
        dd      ret_

nfa_50:
        db      9,"buf_block"
        db      0
        dd      nfa_49
buf_block:
        dd      addr_interp
        dd      plus_cell_
        dd      plus_cell_
        dd      ret_

nfa_51:
        db      9,"buf_state"
        db      0
        dd      nfa_50
        dd      addr_interp
        dd      plus_cell_
        dd      ret_

nfa_52:
        db      5,"+CELL"
        db      0
        dd      nfa_51
plus_cell_:
        dd      plus_cell_code
        dd      0

nfa_53:
        db      5,"BLOCK"
        db      0
        dd      nfa_52
block_:
        dd      addr_interp
        dd      dup_

        dd      buffer_1_
        dd      buf_block
        dd      _@_
        dd      _eq_          ;if equeal - true

        dd      ?br_          ; if true - branch
        dd      b1

        dd      dup_
        dd      dup_
        dd      buffer_1_
        dd      _@_
        dd      rblock_
        dd      buffer_1_
        dd      buf_block
        dd      _!_
b1:
        dd      drop_
        dd      ret_

nfa_54:
        db      4,"LOAD"
        db      0
        dd      nfa_53
        dd      load_code
        dd      0

nfa_55:
        db      6,"N>LINK"
        db      0
        dd      nfa_54
        dd      nlink_code
        dd      0

nfa_56:
        db      7,"?BRANCH"
        db      0
        dd      nfa_55
?br_:
        dd      ?br_code
        dd      0

nfa_57:
        db      6,"BRANCH"
        db      0
        dd      nfa_56
br_:
        dd      br_code
        dd      0

nfa_58:
        db      6,"WBLOCK"
        db      0
        dd      nfa_57
wrblock_:
        dd      wrblock_code
        dd      0

nfa_59:
        db     1,"="
        db     0
        dd      nfa_58
_eq_:
        dd      _eq_code
        dd      0


nfa_60:
        db      4,"DROP"
        db      0
        dd      nfa_59
drop_:
        dd      pop_code
        dd      0

nfa_61:
        db      13,"variable_code"
        db      0
        dd      nfa_60
        dd      constant_code ;  and_code
        dd      variable_code

nfa_62:
        db      8,"CONSTANT"
        db      0
        dd      nfa_61
        dd      constant_create_code
        dd      0

nfa_63:
        db      1h,"1"
        db      0
        dd      nfa_62
        dd      constant_code
        dd      1


nfa_64:
        db      5,"to_cf"
        db      0
        dd      nfa_63
        dd      to_cf_code
        dd      0

nfa_65:
        db      8,"br_label"
        db      0
        dd      nfa_64
br_label:
        dd      constant_code
        dd      br_

nfa_66:
        db      9,"?br_label"
        db      0
        dd      nfa_65
?br_label:
        dd      constant_code
        dd      ?br_

nfa_67:
        db      9,"constant_"
        db      0
        dd      nfa_66
constant_:
        dd      constant_code
        dd      constant_code

nfa_68:
        db      3,"OR!"
        db      0
        dd      nfa_67
        dd      or_!_code
        dd      0

nfa_69:
        db      2,"80"
        db      0
        dd      nfa_68
        dd      constant_code
        dd      80h

nfa_70:
        db      1,"0"
        db      0
        dd      nfa_69
        dd      constant_code
        dd      0

nfa_71:
        db      8,"off_data"
        db      0
        dd      nfa_70
        dd      constant_code
        dd      off_data

nfa_72:
        db      2,"<>"
        db      0
        dd      nfa_71
        dd      not_eq_code
        dd      0

nfa_73:
        db      16,"how_many_sectors"
        db      0
        dd      nfa_72
        dd      constant_code
        dd      how_many_sectors

nfa_74:
        db      14,"dot_quote_code"
        db      0
        dd      nfa_73
        dd      constant_code
        dd      dq_
dq_:    dd      dot_quote_code

nfa_75:
        db      8,"code_top"
        db      0
        dd      nfa_74
        dd      variable_code ;constant_code
top_of_code_val:
        dd      top_of_code

nfa_76:
        db      1," "
        db      0
        dd      nfa_75
        dd     0; minus_code
        dd      0

nfa_77:
        db      6,"opcode"
        db      0
        dd      nfa_76
        dd      opcode_code
        dd      0

nfa_78:
        db      1," "
        db      0
        dd      nfa_77
        dd      0
        dd      0

nfa_79:
        db      1," "
        db      0
        dd      nfa_78
        dd      0
        dd      0

nfa_80:
        db      5,"label"
        db      0
        dd      nfa_79
        dd      label_code
        dd      0


nfa_a:
        db 4,"Booo"
        db 0
        dd      nfa_80
        dd      0
        dd 0


here:
 last_lfa:
