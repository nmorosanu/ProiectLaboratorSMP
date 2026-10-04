#include <8051.h>

extern void lcd_dly(void) __sdcccall(0);

void main(void)
{
    while (1)
    {
        P1_0 = !P1_0;
        lcd_dly();
    }
}
