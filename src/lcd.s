.module     lcd

.area       DSEG(DATA)

.area       CSEG(CODE)

.globl _lcd_dly
.globl _lcd_config
.globl _lcd_clr
.globl _lcd_wchr
.globl _lcd_wcmd
.globl _lcd_wstr

_lcd_dly:       push    a
                mov     a, #0x40

lcd_dly_loop:   dec     a
                jnz     lcd_dly_loop

                pop     a
                ret

_lcd_config:    push    a
                
                mov     A, #0x2A
                acall   _lcd_wcmd
                mov     A, #0x06
                acall   _lcd_wcmd
                mov     A, #0x0F
                acall   _lcd_wcmd

                pop     acc
                ret

_lcd_clr:       push    acc
                mov     acc, #0x01
                acall   _lcd_wcmd
                mov     acc, #0x80
                acall   _lcd_wcmd
                pop     acc
                ret

_lcd_wchr:      push    acc
                mov     a,    0x00
                anl     a,    #0xF0
                orl     a,    #0x0C
                mov     p1,     a
                acall   _lcd_dly
                anl     a,      #0xF0
                mov     p1,     a
                acall   _lcd_dly

                mov     0x00,    a
                swap    a

                anl     a,      #0xF0
                orl     a,      #0x0C
                mov     p1,     a
                acall   _lcd_dly

                anl     a,      #0xF4
                mov     p1,     a
                acall   _lcd_dly

                pop     acc    
                ret

_lcd_wcmd:      push    acc

                mov     a,      0x00
                anl     a,      #0xF0
                orl     a,      #0x04
                mov     p1,     a
                acall   _lcd_dly
                anl     a,      #0xF0
                mov     p1,     a
                acall   _lcd_dly

                mov     0x00,    a
                swap    a

                anl     a,      #0xF0
                orl     a,      #0x04
                mov     p1,     a
                acall   _lcd_dly

                anl     a,      #0xF0
                mov     p1,     a
                acall   _lcd_dly

                pop     acc
                ret

_lcd_wstr:      push    acc
                pop     acc
                ret
