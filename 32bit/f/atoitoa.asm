_2hex_dot:
        call    _pop
        mov     [value+4],eax
        call    _hex_dot1
        mov     byte [hexstr+17],0
        call    _space
        mov     esi,hexstr
        mov     ecx,16
        call    os_output
        call    _space
        ret

_hex_dot:
        call    _hex_dot1
        call    _space
        mov     esi,hexstr+8
        mov     ecx,8
        call    os_output
        call    _space
        ret

_hex_dot1:
        call    _pop
        mov     [value],eax
_hex_dot2:
        movdqa  xmm0, dqword [value] ;xmm0=000000001234567890ABCDEFh (only eight bytes)
        pxor    xmm1,xmm1
        punpcklbw     xmm0,xmm1 ;xmm0=0012003400560078009000AB00CD00EFh
        movdqa  xmm1,xmm0       ;xmm0=xmm1
        pand    xmm1,[fes]      ;xmm1=0010003000500070009000B000D000Fh

        psllq   xmm0,4          
        pand    xmm0,[fes]      ;xmm0=020004000600080000000A000C00E0h        
        por     xmm0,xmm1
        movdqa  xmm1,xmm0
        paddb   xmm1,[sixes]
        psrlq   xmm1,4
        pand    xmm1,[fes]
        pxor    xmm3,xmm3
        psubb   xmm3,xmm1
        pand    xmm3,[sevens]
        paddb   xmm0,xmm3
        paddb   xmm0,[zeroes]
        movdqa  [hexstr],xmm0
        mov     eax,[hexstr]
        mov     ebx,[hexstr+4]
        mov     ecx,[hexstr+8]
        mov     edx,[hexstr+12]
        bswap   eax
        bswap   ebx
        bswap   ecx
        bswap   edx
        mov     [hexstr],edx
        mov     [hexstr+4],ecx
        mov     [hexstr+8],ebx
        mov     [hexstr+12],eax
        mov     byte [hexstr+17],0
        ret




        align   8
value:   dq      1234567890abcdefh
         dq      012345678h

zeroes: dq      3030303030303030h
                dq      3030303030303030h

sixes:  dq      0606060606060606h
                dq      0606060606060606h

sevens: dq      0707070707070707h
                dq      0707070707070707h
fes:            dq       0x0f0f0f0f0f0f0f0f
                dq      0x0f0f0f0f0f0f0f0f
 
hexstr: times 33  db 0 

;-----------------------
_0xd:
        call    _pop
        mov             ebx,[eax+8]
        mov             ecx,[eax+12]
        bswap   ebx
        mov     edx,[eax+4]
        bswap   ecx
        mov     ebp,[eax]
        bswap   edx
        bswap   ebp
        mov     [eax+8],edx
        mov     [eax+12],ebp
        mov     [eax+4],ebx
        mov     [eax],ecx
      ;  int3
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

        movdqu   dqword [  value],xmm0
        mov       eax, dword  [value]
        call    _push
        mov     eax,dword[value+4]
        call    _push
   ;     int3
        ret
_0x:
        call    _0xd
        call    _pop
        ret

bytemask:        dq      0ff00ff00ff00ffh
                dq      0ff00ff00ff00ffh

        
        
;--------------------
