#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
// Text configuration
#define WHITE_ON_BLACK 0x0f
// IO Ports
#define REG_SCREEN_CTRL 0x3d4
#define REG_SCREEN_DATA 0x3d5
#define REG_CURSOR_HIGH 14
#define REG_CURSOR_LOW 15

#include "../kernel/io.c"
#include "../kernel/util.c"
#include "screen.c"
