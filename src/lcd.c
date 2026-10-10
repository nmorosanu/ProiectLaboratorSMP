#include <8051.h>

#include "inc/lcd.h"

void lcd_delay(volatile char a, volatile char b)
{
    char bcpy;
    while (a != 0)
    {
        bcpy = b;
        while (bcpy != 0)
        {
            --bcpy;
        }
        --a;
    }
}

inline void lcd_init(void)
{
    lcd_delay(0xFF, 0xFF);

    lcd_command(0x33);
    lcd_command(0x32);
    lcd_command(0x28);
    lcd_command(0x0C);
    lcd_command(0x06);
    lcd_command(0x01);
    lcd_command(0x80);

    lcd_delay(0xFF, 0);

    lcd_write_byte('J');
    lcd_write_byte('E');
    lcd_write_byte('B');
}

inline void lcd_clear(void)
{
    lcd_command(0x01);
    lcd_command(0x80);
}

void lcd_write_byte(char byte)
{
    P1      = ((byte & 0xF0) | 0x0C);
    lcd_delay(0xFF, 0);
    P1      = byte & 0xF4;
    lcd_delay(0xFF, 0);

    byte    = byte << 4;
    P1      = ((byte & 0xF0) | 0x0C);
    lcd_delay(0xFF, 0);
    P1      = byte & 0xF4;
    lcd_delay(0xFF, 0);
}

void lcd_command(char byte)
{
    P1      = ((byte & 0xF0) | 0x08);
    lcd_delay(0xFF, 0);
    P1      = byte & 0xF0;
    lcd_delay(0xFF, 0);

    // lower byte
    byte    = byte << 4;
    P1      = ((byte & 0xF0) | 0x08);
    lcd_delay(0xFF, 0);
    P1      = byte & 0xF0;
    lcd_delay(0xFF, 0);
}

void lcd_write_string()
{

}
