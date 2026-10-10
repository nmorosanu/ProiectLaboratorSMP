.module main

.area CABS (ABS,CODE)
.org 0x0000
    ljmp start


.area CSEG (CODE)
start:
    mov  SP, #0x80
    mov  P1, #0x00

    acall   _lcd_init
    
    ;mov     dpl,    #'a'
    ;acall   _lcd_write_byte
    ;mov     dpl,    #'b'
    ;acall   _lcd_write_byte
    ;mov     dpl,    #'c'
    ;acall   _lcd_write_byte
loop:
    sjmp loop
