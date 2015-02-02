        align   16
        mov     esi,vocabulary
        mov     edi,neworg
        mov     ecx,8192
        rep     movsd
  

        mov     ebx,[data_stack_base]
        ;xor     r10, r10
        ;mov     r9,[rel data_stack_mask]
        ;mov     rsp,0x300000
        ;mov     byte [0xb8010],0x33
       ; mov     eax,' '
       ; call    os_output_char

      ;  mov     eax,msgf
      ;  call    os_output
      ;  mov     [rel fid],eax
        
      ;  call    _push

      ;  call    _push
        
      ;  call    _type
        

        mov      eax,nfa_0
        call    _push
        call    _push
        call    _hex_dot
        call    _space
        call    _count
        call    _type

        call    _cr
        call    _space

_f_system:
        call    _cr
        mov     dword [_in_value],0
        
        call    _timer

        call    _2hex_dot

        mov     esi,msgf
        call     os_output
        call     _expect

          mov dword [0x000B804C], "J G "

        call    _interpret
        ;call   _0x
        jmp     _f_system
        
        ret



;data_stack_base dd      0x100000
data_stack_mask dd      0x00ffff
stack_pointer   dd      0
