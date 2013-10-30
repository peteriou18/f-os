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

: allocate_block  first_free_block LOAD 0x 4 dStatic! ; 

Слово LOAD таким образом становится единым способом работы с внешней памятью. В данном случае оно 
интерпретирует слово next_block, идущее первым в каждом свободном блоке.
Слово next_block выбирает из входного потока число и кладет его на стек. Завершает интерпретацию стандартные 
магические 4 байта 200a0d20. 

: next_block   0x ; Оно нагляднее, но стоит ли? 

В Форте существует штатное понятие "входной поток". Поятие "выходной поток" необходимо определить. В выходной поток
можно писать как на терминал.
В нестандарте в переменной IN> заведена вторая ячейчка, in_old в которую пишется значение переменной ин из предыдущего 
обработанного блока.

: +OUT?  OUT> +! OUT @ buffer_size < IF ( тут условие выполнено и ничего не делаем ) ELSE ( здесь организуем запись 
блока и выборку нового ) BLK @ buffer WBLOCK THEN ; 

Вообще, по-хорошему, надо сперва проверять влезет ли, потом рвать, а потом подкачивать. 
Как проглотить в выходной поток?
 Снимаем со стека адрес строки со счетчиком. Кладем ее в выходной поток, контролируем оут.
 : in_buf  buffer1 OUT> @ + ;
 : S>>#  DUP in_buf SWAP COUNT CMOVE T->T,N SWAP DROP +out?    ;
 
 Для удобства нуно еще посылка байта, слова, двойного слова со стека в выходной поток.
 
 : b>># in_buf  C! 1 +out? ;
 : w>># in_buf  W! 0x, 2 +out? ;
 : d>># in_buf  ! 0x, 4 +out? ;
 
 : move-str  DUP @@5 @ SWAP COUNT CMOVE T->T,N @@5 +! DROP  ;  
 
 
 Такс. Берем номер первого свободного блока из статика. используем для этого аллокейт блок. по итогу имеем в переменной
 блк текущий блок, который надо будет сохранить. во второй части переменной инЮ адрес, с которого можно писать в буфер.
 по зполнении буфера сохраняем текущий блок и выполняем аллокейт блок еще раз. 
 
 Еще один такс.
 Слово буфер по канону принимает номер блока, заполняет блоком буфер, кладет на стек адрес этого буфера. 
 создаем создающее слово креате_буфер. креате_буфер буфнаме. буфнаме кладет на стек адрес начала буфера. 
 +селл - номер ассоциированного блока. +селл - флаги, признак измененности буфера.
 
 Камни, камни, подводные камни..
 
 ТУДУ: воткнуть в рблок сохранение номера считанного блока в буффер_1 +селл.
       Слепить слово флаш, которое будет сохранять буфер в блок. Номер блока ессно берется из буффер_1 +селл.
       
 +щге, 1) вычисляем "хвост"=буфер+аут+счетчик-буфер_сайз
 2) если он больше нуля отнимаем его от счетчика делаем кмув. подкачиваем. к адресу источника прибавляем счетчик-хвост, 
 в качестве счетчика ставим хвост.
 3) Значит надо запомнить хвост и каким-то образом приплюсовать его к 3 элементу на стеке. 
 .... источник приемник сччечик хвост (источник=источник+хвост)
 
 BIN: nth+  ( v(n)..3 2 1 v n --- (v(n)+v)..3 2 1 )  call pop_ab sub_ebx,esi neg_ebx add_[ebx*4+st_b],eax ret 
 
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



