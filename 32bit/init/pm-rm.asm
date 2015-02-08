        USE16

switch_to_pm:
         cli
         mov eax, cr0
         or al, 0x01     ; Set protected mode bit
         mov cr0, eax
         jmp 8:pm2

         USE32
          mov dword [0x000B8030], "I S "
 pm2:
        lidt    [idtr]
        mov eax, 16     ; load 4 GB data descriptor
        mov ds, ax      ; to all data segment registers
        mov es, ax
        mov fs, ax
        mov gs, ax
        mov ss, ax
        xor eax, eax
        xor ebx, ebx
        xor ecx, ecx
        xor edx, edx
        xor esi, esi
        xor edi, edi
        xor ebp, ebp
        mov esp,08000h
        call     remap_irq_pm
        call    unmask_irqs
        sti
        jmp     far [pmback]


switch_to_rm:
         cli

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
         jmp    0:start163



          
 start163:

          xor     ax,ax
          mov     ds,ax
          mov     es,ax
          mov     ss,ax
          mov     fs,ax

          mov     gs,ax
          mov     ax,0b800h
          mov     fs,ax
          mov     sp,8000h
          call  remap_irq_real
          lidt     [rlidt]
          sti
          call  unmask_irqs

          jmp   far [rmback]

          USE32

