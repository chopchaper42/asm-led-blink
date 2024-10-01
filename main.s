.syntax unified @ divided nebo unified

.word 0x20001000
.word _start

.global _start
.type _start, %function

.set RCC_APB2ENR, 0x40021018 @ makro
.set GPIOC_CRH, 0x40011004
.set GPIOC_ODR, 0x4001100C

_start: @ jako main v c
    bl setup_clock  @ bl - branch and link
    bl setup_gpio
    

loop:
    bl led_blue
    mov r0, #1
    bl delay
    bl led_green
    mov r0, #3
    bl delay
b loop


setup_clock:
    ldr r0, =RCC_APB2ENR @ load from rcc_apb2enr to r0
    ldr r1, [r0] @ load value from r0 to r1
    orr r1, #0x10 @ or
    str r1, [r0]

bx lr   @ skok do link registru


setup_gpio:
    ldr r0, =GPIOC_CRH @ CRH - control register high
    ldr r1, [r0]
    bic r1, #0xFF
    orr r1, #0x11
    str r1, [r0]
bx lr

led_blue:
    ldr r0, =GPIOC_ODR
    ldr r1, =0x100 @ 8th port
    str r1, [r0]
bx lr


led_green:
    ldr r0, =GPIOC_ODR
    ldr r1, =0x200 @ 8th port
    str r1, [r0]
bx lr


delay:

    ldr r1, =0x20000
delay_second:
    subs r1, #1
    bne delay_second
    subs r0, #1
    bne delay
bx lr
