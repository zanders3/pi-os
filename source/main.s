.section .init
.globl _start
_start:
b main

.section .text
main:
mov sp,#0x8000

mov r0,#16
mov r1,#1
bl SetGpioFunction

ptrn .req r4
ldr ptrn,=0b11111111101010100010001000101010
seq .req r5
mov seq,#0

loop$:
mov r0,#16
mov r1,#1
lsl r1,seq
and r1,ptrn
bl SetGpio

ldr r0,=250000
bl Wait

add seq,#1
and seq,#0b11111

b loop$
