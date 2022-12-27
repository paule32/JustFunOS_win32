[bits 32]
extern _kernel_main

global _start;
_start:
    call _kernel_main
    jmp $
