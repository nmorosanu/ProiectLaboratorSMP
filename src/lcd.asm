lcd_dly:        push    acc
                mov     acc, #040h

lcd_dly_loop:   dec     acc
                jnz     lcd_dly_loop

                pop     acc
                ret

lcd_config:     push    acc
                
                mov     a,  #2Ah
                call    lcd_wcmd
                mov     a,  #06h
                call    lcd_wcmd
                mov     a,  #0Fh
                call    lcd_wcmd

                pop     acc
                ret

lcd_clr:        push    acc
                mov     acc, #01h
                call    lcd_wcmd
                mov     acc, #80h
                call    lcd_wcmd
                pop     acc
                ret

lcd_wchr:       push    acc
                mov     a,    00h
                anl     a,    #0F0h
                orl     a,    #00Ch
                mov     p1,     a
                call    lcd_dly
                anl     a,      #0F0h
                mov     p1,     a
                call    lcd_dly

                mov     00h,    a
                swap    a

                anl     a,      #0F0h
                orl     a,      #00Ch
                mov     p1,     a
                call    lcd_dly

                anl     a,      #0F4h
                mov     p1,     a
                call    lcd_dly

                pop     acc    
                ret

lcd_wcmd:       push    acc

                mov     a,      00h
                anl     a,      #0F0h
                orl     a,      #004h
                mov     p1,     a
                call    lcd_dly
                anl     a,      #0F0h
                mov     p1,     a
                call    lcd_dly

                mov     00h,    a
                swap    a

                anl     a,      #0F0h
                orl     a,      #004h
                mov     p1,     a
                call    lcd_dly

                anl     a,      #0F0h
                mov     p1,     a
                call    lcd_dly

                pop     acc
                ret

lcd_wstr:       push    acc
                pop     acc
                ret
