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

mov r0,#16
mov r1,#0
bl SetGpio

loop$:
b loop$
