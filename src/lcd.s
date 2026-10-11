.module lcd

.globl _lcd_delay
.globl _lcd_init
.globl _lcd_clear

.area   DSEG(DATA)

.area   CSEG(CODE)

_lcd_command:
    mov     R7, DPL

    mov     A, R7
    anl     A, #0xF0
    orl     A, #0x08
    mov     P1, A

    mov     DPL, #0x80
    acall   _lcd_delay

    anl     A, #0xF0
    mov     P1, A

    mov     DPL, #0x80
    acall   _lcd_delay

    mov     A, R7
    swap    A

    anl     A, #0xF0
    orl     A, #0x08
    mov     P1, A

    mov     DPL, #0x80
    acall   _lcd_delay

    anl     A, #0xF0
    mov     P1, A

    mov     DPL, #0x80
    acall   _lcd_delay
        
    ret

_lcd_write_byte:
    mov     R7, DPL

    mov     A, R7
    anl     A, #0xF0
    orl     A, #0x0C
    mov     P1, A

    mov     DPL, #0x80
    acall   _lcd_delay

    anl     A, #0xF4
    mov     P1, A

    mov     DPL, #0x80
    acall   _lcd_delay

    mov     A, R7
    swap    A

    anl     A, #0xF0
    orl     A, #0x0C
    mov     P1, A

    mov     DPL, #0x80
    acall   _lcd_delay

    anl     A, #0xF4
    mov     P1, A

    mov     DPL, #0x80
    acall   _lcd_delay
        
    ret

_lcd_delay:
    mov     R0, DPL
_lcd_delay_l0:
    mov     R1, DPL
_lcd_delay_l1:
    djnz    R1, _lcd_delay_l1
    djnz    R0, _lcd_delay_l0
    ret

_lcd_init:
    mov     DPTR, #0xFFFF
    acall   _lcd_delay    
    mov     DPL, #0x33
    acall   _lcd_command
    mov     DPL, #0x32
    acall   _lcd_command
    mov     DPL, #0x28
    acall   _lcd_command
    mov     DPL, #0x0C
    acall   _lcd_command
    mov     DPL, #0x06
    acall   _lcd_command
    mov     DPL, #0x01
    acall   _lcd_command
    mov     DPL, #0x80
    acall   _lcd_command

    mov     DPTR, #0xFF00
    acall   _lcd_delay

    mov     DPL, #'J'
    acall   _lcd_write_byte
    mov     DPL, #'E'
    acall   _lcd_write_byte
    mov     DPL, #'B'
    acall   _lcd_write_byte

    ret

_lcd_clear:
    mov     DPL, #0x01
    acall   _lcd_command
    mov     DPL, #0x80
    acall   _lcd_command
    
    ret
