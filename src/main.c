#include <8051.h>

void delay(unsigned int n) 
{
    while (n)
    {
        unsigned char i = 0xFF;
        while (i--);
        --n;
    }
}

void main(void)
{
    while (1)
    {
        P1_0 = !P1_0;
        delay(1000);
    }
}
