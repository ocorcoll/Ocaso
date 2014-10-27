int get_screen_offset(int row, int col) {
    return (row*MAX_COLS + col)*2;
}

int get_cursor_position() {
    int offset;

    // Select cursor position (HIGH)
    port_byte_out(REG_SCREEN_CTRL, REG_CURSOR_HIGH);
    offset = port_byte_in(REG_SCREEN_DATA) << 8;
    // Select cursor position (LOW)
    port_byte_out(REG_SCREEN_CTRL, REG_CURSOR_LOW);
    offset += port_byte_in(REG_SCREEN_DATA);
    return offset*2;
}

void set_cursor(int offset) {
    offset /= 2;
    port_byte_out(REG_SCREEN_CTRL, REG_CURSOR_HIGH);
    port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset >> 8));
    port_byte_out(REG_SCREEN_CTRL, REG_CURSOR_LOW);
    port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset));
}

int handle_scrolling(int offset) {
    int i;
    char *last_line = (char *)get_screen_offset(MAX_ROWS-1, 0) + VIDEO_ADDRESS;

    if(offset < MAX_ROWS*MAX_COLS*2)
        return offset;

    for(i=0; i<MAX_ROWS; i++) {
        memory_copy((char *)(get_screen_offset(i,0) + VIDEO_ADDRESS)
                , (char*)(get_screen_offset(i-1,0) + VIDEO_ADDRESS)
                , MAX_COLS*2);
    }

    for(i=0; i<MAX_COLS*2; i++) {
        last_line[i] = 0;
    }

    offset -= 2*MAX_COLS;
    return offset;
}

void print_char(char character, int row, int col, char attribute_byte) {
    unsigned char *video_memory = (unsigned char *) VIDEO_ADDRESS;
    char is_in_range = (row >= 0 && col >= 0);
    int offset = (is_in_range) ? get_screen_offset(row, col) : get_cursor_position();
    int rows;

    // Default value
    if(!attribute_byte)
        attribute_byte = WHITE_ON_BLACK;

    if(character == '\n') {
        rows = offset / (2*MAX_COLS);
        offset = get_screen_offset(rows, 79);
    } else {
        video_memory[offset] = character;
        video_memory[offset+1] = attribute_byte;
    }

    offset += 2;
    offset = handle_scrolling(offset);
    set_cursor(offset);
}

void print_str(char *str, int row, int col) {
    int i=0;

    // TODO: Check this :S
    if(row >= 0 && col >= 0)
        set_cursor(get_screen_offset(row, col));

    while(str[i] != 0)
        print_char(str[i++], row, col, 0);
}

void print(char *str) {
    print_str(str, -1, -1);
}

void clear_screen() {
    int row, col;

    for(row=0; row<MAX_ROWS; row++) {
        for(col=0; col<MAX_COLS; col++) {
            print_char(' ', row, col, 0);
        }
    }

    set_cursor(get_screen_offset(0,0));
}
