macro alignhe
{ virtual
        align 4
        algn = $ - $$
    end virtual
    db algn dup 0
    }

nfa_0:
        db 7, "FORTH32",0
        ;alinghe
        alignhe

        dd  nfa_0.5 ;LFA
        dd _vocabulary ;CFA
 f64_list:
        dd nfa_last ;PFA - oeacaoaeu ia eoa iineaaiaai ii?aaaeaiiiai neiaa
        dd      _abort
nfa_0.5:
        db      2,0,0,0
        alignhe
        ;db a dup 0
        dd      0
ret_:
        dd      _ret

nfa_1:
        db      4,"HEX." ,0
        alignhe
        dd      nfa_0
hex_dot:
        dd      _hex_dot
        dd      0
nfa_2:
        db      4,"EMIT",0
        alignhe
        dd      nfa_1
        dd      _emit
        dd      0
nfa_3:
        db      2,"CR",0
        alignhe
        dd      nfa_2
cr_:
        dd      _cr
        dd      0
nfa_4:
        db      4,"TYPE",0
        alignhe
        dd      nfa_3
type_:
        dd      _type
        dd      0
nfa_5:
        db      5,"COUNT",0
        alignhe
        dd      nfa_4
count_:
        dd      _count
        dd      0
nfa_6:
        db      5,"SPACE",0
        alignhe
        dd      nfa_5
        dd      _space
        dd      0
nfa_7:
        db      1,"@",0
        alignhe
        dd      nfa_6
fetch_:
        dd      _fetch
        dd      0

nfa_8:
        db      7,"CONTEXT",0
        alignhe
        dd      nfa_7
context_:
        dd      _variable_code
context_value:  
        dd      f64_list
        dd      0
        dd      -1
        dd      -1
        dd      -1
        dd      -1
        dd      -1
        dd      0
        
        
nfa_9:  
        db      3,">IN",0
        alignhe
        dd      nfa_8
        dd      _variable_code
_in_value:
        dd      0

nfa_10: 
        db      3,"DUP",0
        alignhe
        dd      nfa_9
        dd      _dup
        dd      0

nfa_11: 
        db      3,"pop",0
        alignhe
        dd      nfa_10
pop_:
        dd      _pop
        dd      0

nfa_12:
        db      4,"push",0
        alignhe
        dd      nfa_11
push_:
        dd      _push
        dd      0

nfa_13:
        db      4,"(0x)",0
        alignhe
        dd      nfa_12
_0x_:
        dd      _0x
        dd      0

nfa_14:
        db      4,"HERE",0
        alignhe
        dd      nfa_13
        dd      _constant
here_value:
        dd      _here

nfa_15:
        db      2,"0x",0
        alignhe
        dd      nfa_14
        dd      _addr_interp
        dd      number_
        dd      _0x_
        dd      ret_
        
nfa_16:

        db      12,"parse_number",0
        alignhe
        dd      nfa_15
number_:
        dd      _number
        dd      0

nfa_17:
        db      7,"CURRENT",0
        alignhe
        dd      nfa_16
current_:
        dd      _variable_code
current_value:
        dd      f64_list
        
nfa_18:
        db      6,"CREATE",0
        alignhe
        dd      nfa_17
create_:
        dd      _create
        dd      0
        
nfa_19: 
        db      6,"N>LINK",0
        alignhe
        dd      nfa_18
nlink_:
        dd      _nlink
        dd      0
        
nfa_20:
        db      6,"LATEST",0
        alignhe
        dd      nfa_19
latest_:
        dd      _latest
        dd      0
        
        ;dd     _addr_interp
        ;dd     current_
        ;dd     fetch_
        ;dd     fetch_
        ;dd     ret_
        
nfa_21:
        db      7,"BADWORD",0
        alignhe
        dd      nfa_20
badword_:
        dd      _vect
        dd      abort_ ;timer_
        
        
nfa_22: 
        db      5,"BLOCK",0
        alignhe
        dd      nfa_21
block_:
        dd      _variable_code
block_value:
        dd      0               ;block number
        dd      64              ;size of buffer
        dd      tibb    ;address of input buffer

nfa_23:
        db      4,"prev",0
        alignhe
        dd      nfa_22
        dd      _addr_interp
        dd      latest_
        dd      nlink_
        dd      fetch_
        dd      count_
        dd      type_
        dd      ret_
        
nfa_24:
        db      1,",",0
        alignhe
        dd      nfa_23
comma_:
        dd      _comma
        dd      0

nfa_25:
        db      1,"'",0
        alignhe
        dd      nfa_24
        dd      _addr_interp
        dd      word_
        dd      find_
      ;  dd      pop_
        dd      ret_
        
nfa_26:
        db      4,"WORD",0
        alignhe
        dd      nfa_25
word_:
        dd      _word
        dd      0

nfa_27:
        db      4,"FIND",0
        alignhe
        dd      nfa_26
find_:
        dd      _find
        dd      0

nfa_28:
        db      7,"EXECUTE",0
        alignhe
        dd      nfa_27
        dd      _execute_code
        dd      0

nfa_29:
        db      10,"interpret#",0
        alignhe
        dd      nfa_28
        dd      _constant
        dd      _addr_interp
        
nfa_30:
        db      9,"constant#",0
        alignhe
        dd      nfa_29
constantb_:
        dd      _constant
        dd      _constant
        
nfa_31:
        db      5,"NAME>",0
        alignhe
        dd      nfa_30
        dd      _name
        dd      0
        
nfa_32: 
        db      1,"!",0
        alignhe
        dd      nfa_31
        dd      _store
        dd      0

nfa_33:
        db      6,"HEADER",0
        alignhe
        dd      nfa_32
header_:
        dd      _header
        dd      0
        

nfa_34:
        db      4,"ret#",0
        alignhe
        dd      nfa_33
        dd      _constant
        dd      ret_
        

nfa_35:
        db      9,"variable#",0
        alignhe
        dd      nfa_34
variableb_:
        dd      _constant
        dd      _variable_code

nfa_36:
        db      8,"VARIABLE",0
        alignhe
        dd      nfa_35
        dd      _addr_interp
        dd      create_
        dd      zero_
        dd      comma_
        dd      ret_

nfa_37:
        db      1,"0",0
        alignhe
        dd      nfa_36
zero_:
        dd      _constant
        dd      0
        
nfa_38:
        db 8,"CONSTANT",0
        alignhe
        dd      nfa_37
        dd      _addr_interp
        dd      header_
        dd      constantb_
        dd      comma_
        dd      comma_
        dd      ret_
        
nfa_39:
        db      10,"VOCABULARY",0
        alignhe
        dd      nfa_38
        dd      _vocabulary_create
        dd      0
        
nfa_40:
        db      6,"TIMER@",0
        alignhe
        dd      nfa_39
timer_:
        dd      _timer
        dd      0

nfa_41:
        db      5,"CELL+",0
        alignhe
        dd      nfa_40
cellp_:
        dd      _cellp
        dd      0

nfa_42:
        db      4,"DUMP",0
        alignhe
        dd      nfa_41
dump_:
        dd      _dump
        dd      0

nfa_43:
        db      6,"(FIND)",0
        alignhe
        dd      nfa_42
        dd      _sfind
        dd      0
        
nfa_44:
        db      5,"CELL-",0
        alignhe
        dd      nfa_43
        dd      _cellm
        dd      0
        
nfa_45:
        db      7,"rdblock",0
        alignhe
        dd      nfa_44
        dd      _rdblock
        dd      0
        
nfa_46:
        db      5,"ALLOT",0
        alignhe
        dd      nfa_45
        dd      _allot
        dd      0

nfa_47:
        db      3,"TIB",0
        alignhe
        dd      nfa_46
        dd      _variable_code
        dd      63      ;tibsize
tibb:
        times   64       db      20h 
        dq      0606060606060606h
        
nfa_48:
        db      5,"ABORT",0
        alignhe
        dd      nfa_47
abort_:
        dd      _abort
        dd      0
        
nfa_49:
        db      7,"wrblock",0
        alignhe
        dd      nfa_48
        dd      _wrblock
        dd      0
                
nfa_50:
        db      4,"LOAD",0
        alignhe
        dd      nfa_49
        dd      _load
        dd      0
        
nfa_51:
        db      6,"BUFFER",0
        alignhe
        dd      nfa_50
buffer_:
        dd      _variable_code
        times 8192 db   0
        align 16
nfa_52:
        db      1,"+",0
        alignhe
        dd      nfa_51
        dd      _plus
        dd      0
        
nfa_53:
        db      9,"code_here",0
        alignhe
        dd      nfa_52
        dd      _constant
top_of_code_val:
        dd      code_top

nfa_54:
        db      6,"opcode",0
        alignhe
        dd      nfa_53
        dd      _opcode_code
        dd      0
        
        
nfa_55:
        db      3,"SP@",0
        alignhe
        dd      nfa_54
        dd      _sp@
        dd      0
        
nfa_56: 
        db      4,"RESn",0
        alignhe
        dd      nfa_55
        dd      _resn
        dd      0
        
nfa_57:
        db      3,"LIT",0
        alignhe
        dd      nfa_56
        dd      lit_code
        dd      0
        
nfa_58:
        db      4,"LINK",0
        alignhe
        dd      nfa_57
        dd      _link
        dd      0

nfa_59:
        db      6,"UNLINK",0
        alignhe
        dd      nfa_58
        dd      _unlink
        dd      0


nfa_60:
        db      3,"0xd",0
        alignhe
        dd      nfa_59
        dd      _addr_interp
        dd      number_
        dd      _0xd_
        dd      ret_

nfa_61:
        db      5,"(0xd)",0
        alignhe
        dd      nfa_60
_0xd_:
        dd      _0xd
        dd      0

nfa_62:
        db      5,"2HEX.",0
        alignhe
        dd      nfa_61
        dd      _2hex_dot
        dd      0

 nfa_last:
 nfa_63:
        db      5,"TRACE",0
        alignhe
        dd      nfa_62
;nt_:
        dd      _variable_code
trace:
        dd      0
