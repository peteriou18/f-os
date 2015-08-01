
macro alignhe20
{ virtual
       align 8192
;       align 4096
;       align 2048
;       align 1024
;       align 512
        algn = $ - $$
    end virtual
    db algn dup 20h
    }

include "blocks\block1.asm"
include "blocks\block2.asm"
include "blocks\block3.asm"
include "blocks\block4.asm"
include "blocks\block5.asm"
include "blocks\block6.asm"
include "blocks\block7.asm"
include "blocks\block8.asm"
include "blocks\block9.asm"
include "blocks\blocka.asm"
include "blocks\blockb.asm"
include "blocks\blockc.asm"
include "blocks\blockd.asm"
