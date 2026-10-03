
.module lcd
.globl lcd_dly
lcd_dly:        push    a
                mov     a, #0x40

lcd_dly_loop:   dec     a
                jnz     lcd_dly_loop

                pop     a
                ret

lcd_config:     push    a
                
                mov     A, #0x2A
                acall   lcd_wcmd
                mov     A, #0x06
                acall   lcd_wcmd
                mov     A, #0x0F
                acall   lcd_wcmd

                pop     acc
                ret

.globl lcd_clr
lcd_clr:        push    acc
                mov     acc, #0x01
                acall   lcd_wcmd
                mov     acc, #0x80
                acall   lcd_wcmd
                pop     acc
                ret

.globl lcd_wchr
lcd_wchr:       push    acc
                mov     a,    0x00
                anl     a,    #0xF0
                orl     a,    #0x0C
                mov     p1,     a
                acall   lcd_dly
                anl     a,      #0xF0
                mov     p1,     a
                acall   lcd_dly

                mov     0x00,    a
                swap    a

                anl     a,      #0xF0
                orl     a,      #0x0C
                mov     p1,     a
                acall   lcd_dly

                anl     a,      #0xF4
                mov     p1,     a
                acall   lcd_dly

                pop     acc    
                ret

.globl lcd_wcmd
lcd_wcmd:       push    acc

                mov     a,      0x00
                anl     a,      #0xF0
                orl     a,      #0x04
                mov     p1,     a
                acall   lcd_dly
                anl     a,      #0xF0
                mov     p1,     a
                acall   lcd_dly

                mov     0x00,    a
                swap    a

                anl     a,      #0xF0
                orl     a,      #0x04
                mov     p1,     a
                acall   lcd_dly

                anl     a,      #0xF0
                mov     p1,     a
                acall   lcd_dly

                pop     acc
                ret

.globl lcd_wstr
lcd_wstr:       push    acc
                pop     acc
                ret
