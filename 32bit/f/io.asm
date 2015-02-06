_type:
	call	_pop
	mov	ecx,eax
	call	_pop
	mov	esi,eax
      ;  mov	 ebx,10h
	call	os_output_chars
	ret
;--------------------------------	
_space:
	mov	al,' '
	call	os_output_char
	ret

;------------------------
_emit:
	call	_pop
	;mov	[_emit0],al
	;lea	rsi,[r10 + r8] ;_emit0
       ;mov	rcx,1
	;call	_pop
	call	os_output_char
	;call	_pop
	ret

;------------------------
_cr:
	mov	ecx,3
	mov	esi,_cr_symb
	
	call   os_output_chars ; os_print_newline
	
	ret
_cr_symb	db 20h,0dh,0ah
;------------------------

;_dump:
	call	_cr
	call	_cr
	call	_pop
	mov		edx,eax
	mov		ecx,64
_dump2:
	push	ecx
	mov	eax,[edx]
	call	_push
	push	edx
	call	_hex_dot

	call	_space
	call	_space
	pop	edx
	add	edx,4

	pop	 ecx
	loop	_dump2
	call	_cr
	call	_cr
	call	_cr
	ret
;--------------------------------
_rdblock:
	call	_pop	; buffer
	mov		edi,eax
;	inc		rcx
	
	call	_pop	; block number
	mov		ecx,eax
	shl		ecx,4

;	mov		rax,[fid]
	mov		edx,0
	mov		eax,ecx
	mov		ecx,16
	call	 read_sectors ;[b_file_read]
	
	ret

;--------------------------------
_wrblock:
	call	_pop	; block number
	mov		ecx,eax
;	inc		rcx
	shl		ecx,4
	call	_pop	; buffer
	mov		edi,eax
;	mov		rax,[fid]
	mov		edx,0
	mov		eax,ecx
	mov		ecx,16
 ;	 call	  read_sectors ;[b_file_read]
	
	ret
;--------------------------------
_expect:
	mov	edi,tibb
	mov	ecx,[tibb-8]
	call	 os_input
	mov	[block_value+4],ecx
	ret
;--------------------------------
