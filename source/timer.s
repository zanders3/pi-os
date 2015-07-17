.globl GetTimeStamp
GetTimeStamp:
ldr r0,=0x20003000
ldrd r0,r1,[r0,#4]
mov pc,lr

.globl Wait
Wait:
delay .req r2
mov delay,r0
push {lr}

bl GetTimeStamp
start .req r3
mov start,r0

loop$:
	bl GetTimeStamp
	elapsed .req r1
	sub elapsed,r0,start
	cmp elapsed,delay
	.unreq elapsed
	bls loop$

.unreq start
.unreq delay
pop {pc}
