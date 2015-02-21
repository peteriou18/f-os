;read_sectors:
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
        jmp     switch_to_rm

        USE16
rdsec1:
        mov     ax,0b800h
        mov     fs,ax
        mov     dword [fs:12h],"D S "
        mov     dl,[7c00h]
        mov     si,dap_p
        mov     ah,42h
        int     13h
        jnb     rdsec3
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
