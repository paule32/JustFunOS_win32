; Defined in isr.c
extern _isr_handler
extern _irq_handler

section .text

; Common ISR code
isr_common_stub:
    ; 1. Save CPU state
	pusha ; Pushes edi,esi,ebp,esp,ebx,edx,ecx,eax
	mov ax, ds ; Lower 16-bits of eax = ds.
	push eax ; save the data segment descriptor
	mov ax, 0x10  ; kernel data segment descriptor
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	push esp ; registers_t *r
    ; 2. Call C handler
    cld ; C code following the sysV ABI requires DF to be clear on function entry
	call _isr_handler
	
    ; 3. Restore state
	pop eax 
    pop eax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	popa
	add esp, 8 ; Cleans up the pushed error code and pushed ISR number
	iret ; pops 5 things at once: CS, EIP, EFLAGS, SS, and ESP

; Common IRQ code. Identical to ISR code except for the 'call' 
; and the 'pop ebx'
irq_common_stub:
    pusha 
    mov ax, ds
    push eax
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    push esp
    cld
    call _irq_handler ; Different than the ISR code
    pop ebx  ; Different than the ISR code
    pop ebx
    mov ds, bx
    mov es, bx
    mov fs, bx
    mov gs, bx
    popa
    add esp, 8
    iret 
	
; We don't get information about which interrupt was caller
; when the handler is run, so we will need to have a different handler
; for every interrupt.
; Furthermore, some interrupts push an error code onto the stack but others
; don't, so we will push a dummy error code for those which don't, so that
; we have a consistent stack for all of them.

; First make the ISRs global
global _isr0
global _isr1
global _isr2
global _isr3
global _isr4
global _isr5
global _isr6
global _isr7
global _isr8
global _isr9
global _isr10
global _isr11
global _isr12
global _isr13
global _isr14
global _isr15
global _isr16
global _isr17
global _isr18
global _isr19
global _isr20
global _isr21
global _isr22
global _isr23
global _isr24
global _isr25
global _isr26
global _isr27
global _isr28
global _isr29
global _isr30
global _isr31
; IRQs
global _irq0
global _irq1
global _irq2
global _irq3
global _irq4
global _irq5
global _irq6
global _irq7
global _irq8
global _irq9
global _irq10
global _irq11
global _irq12
global _irq13

; 0: Divide By Zero Exception
_isr0:
    push byte 0
    push byte 0
    jmp isr_common_stub

; 1: Debug Exception
_isr1:
    push byte 0
    push byte 1
    jmp isr_common_stub

; 2: Non Maskable Interrupt Exception
_isr2:
    push byte 0
    push byte 2
    jmp isr_common_stub

; 3: Int 3 Exception
_isr3:
    push byte 0
    push byte 3
    jmp isr_common_stub

; 4: INTO Exception
_isr4:
    push byte 0
    push byte 4
    jmp isr_common_stub

; 5: Out of Bounds Exception
_isr5:
    push byte 0
    push byte 5
    jmp isr_common_stub

; 6: Invalid Opcode Exception
_isr6:
    push byte 0
    push byte 6
    jmp isr_common_stub

; 7: Coprocessor Not Available Exception
_isr7:
    push byte 0
    push byte 7
    jmp isr_common_stub

; 8: Double Fault Exception (With Error Code!)
_isr8:
    push byte 8
    jmp isr_common_stub

; 9: Coprocessor Segment Overrun Exception
_isr9:
    push byte 0
    push byte 9
    jmp isr_common_stub

; 10: Bad TSS Exception (With Error Code!)
_isr10:
    push byte 10
    jmp isr_common_stub

; 11: Segment Not Present Exception (With Error Code!)
_isr11:
    push byte 11
    jmp isr_common_stub

; 12: Stack Fault Exception (With Error Code!)
_isr12:
    push byte 12
    jmp isr_common_stub

; 13: General Protection Fault Exception (With Error Code!)
_isr13:
    push byte 13
    jmp isr_common_stub

; 14: Page Fault Exception (With Error Code!)
_isr14:
    push byte 14
    jmp isr_common_stub

; 15: Reserved Exception
_isr15:
    push byte 0
    push byte 15
    jmp isr_common_stub

; 16: Floating Point Exception
_isr16:
    push byte 0
    push byte 16
    jmp isr_common_stub

; 17: Alignment Check Exception
_isr17:
    push byte 0
    push byte 17
    jmp isr_common_stub

; 18: Machine Check Exception
_isr18:
    push byte 0
    push byte 18
    jmp isr_common_stub

; 19: Reserved
_isr19:
    push byte 0
    push byte 19
    jmp isr_common_stub

; 20: Reserved
_isr20:
    push byte 0
    push byte 20
    jmp isr_common_stub

; 21: Reserved
_isr21:
    push byte 0
    push byte 21
    jmp isr_common_stub

; 22: Reserved
_isr22:
    push byte 0
    push byte 22
    jmp isr_common_stub

; 23: Reserved
_isr23:
    push byte 0
    push byte 23
    jmp isr_common_stub

; 24: Reserved
_isr24:
    push byte 0
    push byte 24
    jmp isr_common_stub

; 25: Reserved
_isr25:
    push byte 0
    push byte 25
    jmp isr_common_stub

; 26: Reserved
_isr26:
    push byte 0
    push byte 26
    jmp isr_common_stub

; 27: Reserved
_isr27:
    push byte 0
    push byte 27
    jmp isr_common_stub

; 28: Reserved
_isr28:
    push byte 0
    push byte 28
    jmp isr_common_stub

; 29: Reserved
_isr29:
    push byte 0
    push byte 29
    jmp isr_common_stub

; 30: Reserved
_isr30:
    push byte 0
    push byte 30
    jmp isr_common_stub

; 31: Reserved
_isr31:
    push byte 0
    push byte 31
    jmp isr_common_stub

; IRQ handlers
_irq0:
	push byte 0
	push byte 32
	jmp irq_common_stub

_irq1:
	push byte 1
	push byte 33
	jmp irq_common_stub

_irq2:
	push byte 2
	push byte 34
	jmp irq_common_stub

_irq3:
	push byte 3
	push byte 35
	jmp irq_common_stub

_irq4:
	push byte 4
	push byte 36
	jmp irq_common_stub

_irq5:
	push byte 5
	push byte 37
	jmp irq_common_stub

_irq6:
	push byte 6
	push byte 38
	jmp irq_common_stub

_irq7:
	push byte 7
	push byte 39
	jmp irq_common_stub

_irq8:
	push byte 8
	push byte 40
	jmp irq_common_stub

_irq9:
	push byte 9
	push byte 41
	jmp irq_common_stub

_irq10:
	push byte 10
	push byte 42
	jmp irq_common_stub

_irq11:
	push byte 11
	push byte 43
	jmp irq_common_stub

_irq12:
	push byte 12
	push byte 44
	jmp irq_common_stub

_irq13:
	push byte 13
	push byte 45
	jmp irq_common_stub

global _irq14
_irq14:
	push byte 14
	push byte 46
	jmp irq_common_stub

global _irq15
_irq15:
	push byte 15
	push byte 47
	jmp irq_common_stub

