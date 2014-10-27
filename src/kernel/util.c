
void memory_copy(char* src, char* dst, int num_bytes) {
    int i;

    //TODO: First copy [src..src+num_bytes] 
    //to a safe place in memory

    for(i=0; i<num_bytes; i++)
        dst[i] = src[i];
}
