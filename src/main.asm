$debug
$sb

org     0000h
ljmp    main
org     0003h
ljmp    E0
org     0013h
ljmp    E1
org     000Bh
ljmp    T0_OVF
org     001Bh
ljmp    T1_OVF
org     0023h
ljmp    SRL
org     0026h

$include (t0_ovf.asm)
$include (t1_ovf.asm)
$include (ei0.asm)
$include (ei1.asm)
$include (srl.asm)

$include (delay.asm)
$include (uart.asm)
$include (lcd.asm)

main:   call    uart_config
        call    lcd_config

        mov     a, #'A'
        call    lcd_wchr
        mov     a, #'B'
        call    lcd_wchr
        mov     a, #'C'
        call    lcd_wchr
LOOP:
        inc     a
        call    delay

        sjmp    LOOP


end
