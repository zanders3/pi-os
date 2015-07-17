.globl GetGpioAddress
GetGpioAddress:
ldr r0,=0x20200000
mov pc,lr

.globl SetGpioFunction
@r0 pinNumber, r1 pinFunction
SetGpioFunction:
cmp r0,#53
cmpls r1,#7
movhi pc,lr
push {lr}
mov r2,r0
bl GetGpioAddress
functionLoop$:
    cmp r2,#9
    subhi r2,#10
    addhi r0,#4
    bhi functionLoop$

add r2, r2, lsl #1
lsl r1,r2
str r1,[r0]
pop {pc}

.globl SetGpio
SetGpio:
@r0 pinNumber, r1 pinValue
cmp r0,#53
movhi pc,lr
push {lr}
mov r2,r0
bl GetGpioAddress
@r0 gpioAddr, r1 pinValue, r2 pinNumber
lsr r3,r2,#5
lsl r3,#2
add r0,r3
@r0 final gpioAddr, r1 pinValue, r2 pinNumber
and r2,#31

setBit .req r3
mov setBit,#1
lsl setBit,r2
teq r1,#0
streq setBit,[r0,#40]
streq setBit,[r0,#28]
pop {pc}
