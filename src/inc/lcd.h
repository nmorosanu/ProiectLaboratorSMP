#pragma once

void lcd_delay(char, char);
void lcd_init(void);
void lcd_clear(void);
void lcd_write_byte(char);
void lcd_command(char cmd);
void lcd_write_string(void);
