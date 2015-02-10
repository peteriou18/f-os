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
       ; mov esp,05000h
        lidt    [idtr]
   ;    call     remap_irq_pm
   ;     call    unmask_irqs
        mov    esp,0f00h-36
        popad
        mov     esp,[esp_save]
        sti

        jmp     dword [pmback]


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
       ;   mov     ax,0b800h
          mov     fs,ax
          mov     sp,5000h
       ;   call  remap_irq_real
          lidt     [rlidt]
        ;  sti
        ;  call  unmask_irqs

          jmp   far [rmback]

          USE32

