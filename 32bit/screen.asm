; =============================================================================
; BareMetal -- a 64-bit OS written in Assembly for x86-64 systems
; Copyright (C) 2008-2013 Return Infinity -- see LICENSE.TXT
;
; Screen Output Functions
; =============================================================================

align 16
db 'DEBUG: SCREEN   '
align 16


; -----------------------------------------------------------------------------
; os_inc_cursor -- Increment the cursor by one, scroll if needed
;  IN:  Nothing
; OUT:  All registers preserved
os_inc_cursor:
        push eax

        add word [os_Screen_Cursor_Col], 1
        mov al, [os_Screen_Cursor_Col]
        cmp ax, [os_Screen_Cols]
        jnl os_inc_cursor_done
        mov byte [os_Screen_Cursor_Col], 0
        add byte [os_Screen_Cursor_Row], 1
        mov al, [os_Screen_Cursor_Row]
        cmp ax, [os_Screen_Rows]
        jnl os_inc_cursor_done
;        call os_screen_scroll
        sub byte [os_Screen_Cursor_Row], 1

os_inc_cursor_done:
        call    os_cursor_set
        pop eax
        ret
; -----------------------------------------------------------------------------
os_Screen_Cursor_Col    db      0
os_Screen_Cols                  dw      20 ;40 ;80

os_Screen_Cursor_Row    db      0
os_Screen_Rows                  dw      25
; -----------------------------------------------------------------------------
; os_dec_cursor -- Decrement the cursor by one
;  IN:  Nothing
; OUT:  All registers preserved
os_dec_cursor:
        push eax

        cmp byte [os_Screen_Cursor_Col], 0
        jne os_dec_cursor_done
        sub byte [os_Screen_Cursor_Row], 1
        mov ax, [os_Screen_Cols]
        mov  [os_Screen_Cursor_Col], al

os_dec_cursor_done:
        sub byte [os_Screen_Cursor_Col], 1
        call     os_cursor_set
        pop eax
        ret
; -----------------------------------------------------------------------------

os_cursor_set:
        push    edx
        push    eax
        push    ebx
        xor     ebx,ebx
        xor     eax,eax
        mov     bl,byte [os_Screen_Cursor_Row]
        lea     ebx,[ebx+ebx*4]
        shl     ebx,4
        mov     al,byte [os_Screen_Cursor_Col]
        add     ebx,eax

        mov     edx,3d4h
        mov     al,0fh
        mov     ah,bl
        out     dx,ax
        mov     al,0eh

        mov     edx,3d4h
        mov     ah,bh
        out     dx,ax
        pop     ebx
        pop     eax
        pop     edx
        ret
; -----------------------------------------------------------------------------
; os_print_newline -- Reset cursor to start of next line and scroll if needed
;  IN:  Nothing
; OUT:  All registers perserved
;os_print_newline:
        push eax

        mov word [os_Screen_Cursor_Col], 0
        mov ax, [os_Screen_Rows]
        sub ax, 1
        cmp al, [os_Screen_Cursor_Row]
        je os_print_newline_scroll
        add byte [os_Screen_Cursor_Row], 1
        jmp os_print_newline_done

os_print_newline_scroll:
;        call os_screen_scroll

os_print_newline_done:
        pop eax
        ret
; -----------------------------------------------------------------------------


; -----------------------------------------------------------------------------
; os_output -- Displays text
;  IN:  RSI = message location (zero-terminated string)
; OUT:  All registers perserved
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

        ;lodsb
        mov     al,[si]
        inc     si
        cmp    al,0
        je      prtstr3
        mov     ah,0eh
        int     10h
        jmp     prtstr1
 prtstr3:
         ; call    print_string_16

        jmp   switch_to_pm

        USE32
prtstr2:

        popad
        ret
 symbols        dd      0

; -----------------------------------------------------------------------------


; -----------------------------------------------------------------------------
; os_output_char -- Displays a char
;  IN:  AL  = char to display
; OUT:  All registers perserved
os_output_char:
        pusha

        mov     [out_char],al
        mov     word [rmback], prtchr1
        mov     dword [pmback_offset],prtchr2
        jmp    switch_to_rm

        USE16
prtchr1:
         cli
         mov    ah,0eh
         mov    al,[out_char]
         mov    cx,4
         xor    bh,bh
         mov    bl,[ screen_attribute]
         int    10h

        jmp   switch_to_pm

        USE32
prtchr2:

        popa
        ret

 out_char       db      0
 screen_attribute       db      7
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; os_output_chars -- Displays text
;  IN:  RSI = message location (A string, not zero-terminated)
;       RCX = number of chars to print
; OUT:  All registers perserved
  USE32
os_output_chars:
        pusha
        mov     [out_chars],esi
        mov     [n_chars],ecx
        mov     dword [rmback], outchr1
        mov     dword [pmback_offset],outchr2
        jmp    switch_to_rm

        USE16
outchr1:
cli
         cld
          xor   ax,ax
          mov   ds,ax
         mov    ecx,[n_chars]
;         xor    ecx,0ffffh
; mov     dword [1000h],32343739H
         mov    esi,[out_chars]; [1000h];hex_byte
       ;  mov    ecx,2
outchr3:
      ;  push    cx
         mov    ah,0eh
         xor    bx,bx
         ;lodsb
         mov    al,[si]
         int    10h
         inc    si
       ;  dec    cx
         ;pop    cx
         loop    outchr3

        jmp   switch_to_pm

 out_chars:    dw        0,0
 n_chars:      dw       5,0
        USE32
outchr2:

        popa
        ret

; -----------------------------------------------------------------------------



; =============================================================================
; EOF
