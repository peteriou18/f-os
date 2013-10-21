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
 -----------------

 То, что выдает pci-list мне надо куда-то сохранить. 
 выделим для этого блоки, начиная с 0х 100.
 
 буфер-заполнен? сохранить-в-блок следующий-блок
 
 начальный блок берется со стека.
 
 
    current-block @ 0x, 1000 WBLOCK  current-block 1+!    
 
 --------------------
 
 static-segment
 
 Статик сегмент нужен для выживаемости данных после перезагрузки. 
 64Кбайт = 128 сектороы = 16 блоков.
 статик сегмент = gs.
 при загрузке системы грузим загружаем их. 
 сохраняем статик по слову restart или static-save
 при загрузке статика сохраняется его резервная копия.
----------------------
файловая система

в статике держим указатель на первый блок файловой системы. 

Что есть файл?
Файл - несколько сцепленных блоков. 
с файлом ассоциируется некоторое слово, которое и содержит семантику файла.
Предположим, нам нужен лог. 

функции.
1) дать свободный блок.
2) занять блок.
соответственно, нужен список свободных блоков. Составление списка свободных блоков ака форматирование. 
Берем блоки с 200h  и до конца. 
Количество секторов на загрузочном диске лежит в статик сегменте по адресу 0ff10f. 8 байт.

Форматирование. Берем блоки с 200h по top_block. В каждый блок пишем 0x nnn block_next.  0x 0 block_next 
обозначает последний блок в цепи. Форматирование через int 13h ооочень медленное. 8Г форматировались целый день.

first_free_block дает номер первого свободного блока. сделаем аллокейт блок: взять первый свободный блок, 
прочитать из него номер следующего свободного блока, записать этот номер как номер первого свободного блока.  

Слово LOAd таким образом становится единым способом работы с внешней памятью.


--------------------

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



