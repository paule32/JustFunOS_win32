## -----------------------------------------------------------------------
## Makefile - this file is part of my fun Operating System Project.
##
## (c) 2022 by Jens Kallup
## all rights reserved.
##
## only for education, and non-profit use !!!
##
## To create this kernel, that results into: os-image.bin, you need the
## MinGW 32/64-Bit Toolchains for working under Windows 11.
## -----------------------------------------------------------------------
TOOLCHAIN = x86_64-w64-mingw32

SOURCES   = $(wildcard kernel/*.c drivers/*.c cpu/*.c libc/*.c)
HEADERS   = $(wildcard kernel/*.h drivers/*.h cpu/*.h libc/*.h)

OBJECTS   = ${SOURCES:.c=.o cpu/interrupt.o}

CC  = ${TOOLCHAIN}-gcc
CPP = ${TOOLCHAIN}-g++
LD  = ld -mi386pe

CFLAGS = -m32 -ffreestanding -fno-exceptions -Wall -Wextra

## first rule is "run by default" ...
os-image.bin: boot/bootsect.bin kernel.fine
	cat $^ > os-image.bin

kernel.bin: boot/kernel_entry.o ${OBJECTS}
	@echo "[ 50%] link kernel.bin"
	${LD} -T NUL -o $@ -Ttext 0x1000 $^ --oformat pe-i386
	strip kernel.bin

kernel.fine: kernel.bin
	objcopy -O binary kernel.bin kernel.fine

%.o: %.c ${HEADERS}
	${CC} ${CFLAGS}  -c $< -o $@

%.o: %.asm
	nasm -f win32 -o $@ $<

%.bin: %.asm
	nasm -f bin   -o $@ $<

clean:
	rm -rf *.bin *.o
	rm -rf kernel/*.o boot/*.bin boot/*.o drivers/*.o cpu/*.o
