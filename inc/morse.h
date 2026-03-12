#ifndef MORSE_H
#define MORSE_H

void encode_file(const char *filename);
void decode_file(const char *filename);
void write_error(FILE *file);

#endif