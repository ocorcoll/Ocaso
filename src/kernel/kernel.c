#include "../drivers/screen.h"

void main() {
    char* video_memory = (char*)0xb8000;
    *video_memory = 'X';

    clear_screen();
    print("Hola que tal");
}
