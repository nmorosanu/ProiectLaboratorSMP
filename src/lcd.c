#include <8051.h>

#include "inc/lcd.h"

#if 0
void lcd_write_byte(char byte)
{
    P1      = ((byte & 0xF0) | 0x0C);
    lcd_delay(0x80);
    P1      = byte & 0xF4;
    lcd_delay(0x80);

    byte    = byte << 4;
    P1      = ((byte & 0xF0) | 0x0C);
    lcd_delay(0x80);
    P1      = byte & 0xF4;
    lcd_delay(0x80);
}
#endif
