f-os
====
Операционная система, написанная на рабочей смеси форт\ассемблер i386.

Как установить.

Скачиваете с vden.ru/fsystem последний файл образ и записываете его на флешку или диск, какую не жалко. 
Загружаетесь и работаете.

Система уже включает в себя ассемблер и редактор. Позволяет вести разработку и отладку сама в себе.


Особенности:

1) Файловая система - блочная. Каждый блок размером 4 Кбайт состоит из 8 последовательных секторов по 512 байт.
Блок 0 является загузочным. Он содержит в себе mstart boot record и код загрузки остальной части 
кодя ядра и базового словаря.
2) Код ядра включает в себя адресный интерпретатор, базовый ввод-вывод и константы.
3) Дальнейшая загрузка системы, равно как и прикладных программ производится исходными текстами.


-------

Как комплировать значение со стека в виде литерала?
Есть слово 0x, немедленного исполнения, которое транслирует следующую строку и комплирует значение как литерал. 
Достаточно выкинуть ввод строки?

: literal  lit_code , , ;

Прекрасно. 

чтобы скомплировать как литерал cfa некоего слова 

: ['] lit_code , ' , ; IMMEDIATE

Там, где встретится конструкция ['] xxx будет скомплировано поле кода для ххх и во время исполнения оно будет 
положено на стек.

--------------

CMOVE ( addrs addrd n ) move n chars from addrs to addrd incremening addrs.
CMOVE> ( addrs addrd n ) move n chars from addrs to addrd decremening addrd+n.

BIN: CMOVE  
           call pop_code
           mov_ecx,eax
           call pop_ab ( ebx - addrd, eax - addrs )
cm1:           
           mov_dl,[eax]
           mov_[ebx],dl
           inc_eax
           inc_ebx
           loop cm1
           ret
           
           
BIN: CMOVE>
          call pop_code
          mov_ecx,eax
          call pop_ab
 cm2:         
          mov_dl,[eax+ecx]
          mov_[ebx+ecx]
          loop cm2
          ret
          

FORTH OS loading and developing from it's one source code. 

Concept.

Forth system loading fron any device. (Now from flash). Load makes from source code. 
Code of system mixed. Low-level code mixed with high-level code. 
You could work both level simultaneously.

Included screen editor, blocks fylesystem.

Loader aka Block 0 (zero) written by fasm . 
Block 0 contain master boot record, kernel, base vocabulary.
All the rest deployng from source code.


Non standart words.

0x  - input hex number, put it on stack
0x, - input hex number, compile lit-code, compile hex value. Immediate. 
HEX. - print value from top of stack as hex.
HEXa - put 8 bytes on address from stack
BIN: - set next words as low-level word. 
opcode - create opcode word. get n dwords from stack and compile it as bytes to code segment
code_top - address of value of first free byte in code segment
label - get value from stack, create word with execution semantic: calculate and compile value to code segment
T->T,N - put on stack counter of string. 
restart - quick warm system reload.



