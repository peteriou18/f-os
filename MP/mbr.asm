 USE16
org 0x7C00
DriveNumber equ 0x4ff
; entry:
cli ; Disable interrupts
;mov edx,3d4h
;        mov eax,00fh
;        out dx,ax
;        mov eax,50eh
;        out dx,ax
 ;       xor     ax,ax
  ;      int     16h
xor ax, ax
mov ss, ax
mov es, ax
mov ds, ax
mov fs, ax
mov ax,0b800h
mov gs,ax
mov sp, 0x1500

;sti ; Enable interrupts
mov [DriveNumber], dl ; BIOS passes drive number in DL
mov si, msg_Load
call prints
;load 63 sectors
mov dl,[DriveNumber]
mov si,dap_p
mov ah,42h
int 13h
jb load_fail
mov si, msg_LoadDone
call prints
mov  si, ap_start
mov  di,0E000h
mov  cx,100h
rep movsd

lgdt [GDTR32] ; Load GDT register
mov eax, cr0
or al, 0x01 ; Set protected mode bit
mov cr0, eax
jmp 8:start32 ; Jump to 32-bit protected mode
GDTR32: ; Global Descriptors Table Register
dw gdt32_end - gdt32 - 1 ; limit of GDT (size minus one)
gdt_base:
dq gdt32 ; linear address of GDT
align 16
gdt32:
dw 0x0000, 0x0000, 0x0000, 0x0000 ; Null desciptor
dw 0xFFFF, 0x0000, 0x9A00, 0x00CF ; 0x 8 32-bit flat code descriptor
dw 0xFFFF, 0x0000, 0x9200, 0x00CF ; 0x 10 32-bit flat data descriptor
dw 0xFFFF, 0x0000, 0x9A10, 0x005F ; 0x 18 32-bit code descriptor 0x100000-0x1fffff
dw 0xFFFF, 0x0000, 0x9220, 0x005F ; 0x 20 32-bit data descriptor 0x200000-0x2fffff
dw 0x0000, 0xFFFF, 0x9209, 0x0050 ; 0x 28 32-bit stack descriptor 0x9ffff-0x90000
dw 0xFFFF, 0x0000, 0x9A00, 0x0000 ; 0x 30 real code
dw 0xFFFF, 0x0000, 0x9200, 0x0000 ; 0x 38 real data
dw 0xFFFF, 0x8000, 0x920B, 0x0000 ; 0x 40 text video segment
gdt32_end:
load_fail:
mov si, msg_LoadFail
call prints
halt:
hlt
jmp halt
dap_p:
db 16
db 0 ;zero
many_of:
dw 15 ; many of sectors
offset_data:
dw 4000h ;offset of data
seg_data:
dw 000h ;segment of data
sect:
dd 1 ; number of sector
dd 0
;------------------------------------------------------------------------------
ap_start:
sti
xor     ax,ax
mov     ds,ax
mov     es,ax
mov     si,msg_AP -7CC1h+0E000h
;call prints
mov  eax,ap_msg-7cc1h+0e000h
mov  [0xaa*4],eax

;------------
; go to unreal mode
;-------------
mov     dword [0e202h], 90000h
mov     word [0e200h], 71
   lgdt [0e200h]         ; load gdt register
 
   mov  eax, cr0          ; switch to pmode by
   or al,1                ; set pmode bit
   mov  cr0, eax
   jmp $+2
                 ; tell 386/486 to not crash

   mov  bx, 0x10          ; select descriptor 1
   mov  ds, bx            ; 8h = 1000b
   mov  es,bx
   mov  fs,bx
   mov  ss,bx
   mov  gs,bx

   and al,0xFE            ; back to realmode
   mov  cr0, eax

xor     eax,eax
        mov    ds,ax
        mov    es,ax
        mov    ss,ax
        mov    fs,ax
        mov    gs,ax
        mov    esp,0ee00h
        mov bx, 0x6F6F         ; attrib/char of smiley
   mov eax, 0x0b8000      ; note 32 bit offset
   mov word [eax], bx

;mov  ecx,1bh
;rdmsr
;call    ap0
;mov  ecx,1bh
;rdmsr
 ;mov     ebx,eax
 ;mov      eax,0fed00800h
 ;mov     ecx,1bh
 ;wrmsr
;mov     ebx,eax
;and     ebx,0fffff000h
;mov     ebx,0feee00000h
;add     ebx,0f0h
;mov     eax,[ebx]
;mov     eax,100h;01aah
or dword [0fee000f0h], 0000000100000000b
;mov     dword [0fee000b0h],4444h  ;eoi
;mov     [ebx],eax

;mov  ecx,1bh
;rdmsr
;call    ap0
;mov     eax,[0F350h]
;call    ap0
;mov     eax,[0F360h]
ap_start2:
rdtsc
mov     ax,0e33h
int     10h
mov     dword [0fee000b0h],4444h  ;eoi
;call    ap0
;int     02h
hlt
jmp     ap_start2

ap_msg:
xor     ax,ax
mov     ds,ax
mov     es,ax
mov     si,msg_ap_int-7cc1h+0e000h
call    prints
mov     dword [0fee000b0h],4444h
iret

ap0:
mov     ecx,8
ap1:
mov     ebx,eax
rol     eax,4
and     al,0fh
add     al,30h
cmp     al,39h
jb      ap2
add     al,7
ap2:
mov     ah,0eh
int     10h
rol     ebx,4
loop    ap1
mov     al,20h
int     10h
;mov     dword [0fee000b0h],4444h  ;eoi
ret
;------------------------------------------------------------------------------
; 16-bit function to print a string to the screen
; IN: SI - Address of start of string
prints: ; Output string in SI to screen
mov ah, 0x0E ; int 0x10 teletype function
print2:
lodsb ; Get char from string
cmp al, 0
je print3 ; If char is zero, end of string
int 0x10 ; Otherwise, print it
jmp short print2
print3:
ret
;------------------------------------------------------------------------------
msg_AP  db "AP start", 10,13,0
msg_ap_int db 10,13, "In", 10,13,0
msg_Load db "L Pure32", 0
msg_LoadDone db " - done.", 13, 10, "Exec", 0
msg_LoadFail db " - Not", 0
;DriveNumber db 0x00
USE32
start32:
mov    edi,0x90000
mov    esi,gdt32
mov    ecx,18
rep    movsd
mov   dword [gdt_base],0x90000
lgdt [GDTR32]
jmp near 4000h

;times 446-$+$$ db 0
; False partition table entry required by some BIOS vendors.
db 0x80, 0xFE, 0xFF, 0xFF, 0x0B, 0xFE, 0xFF, 0xFF, 0x01, 0x00, 0x00, 0x00, 0xFE, 0xEF, 0xEC, 0x00
times 510-$+$$ db 0
sign dw 0xAA55
