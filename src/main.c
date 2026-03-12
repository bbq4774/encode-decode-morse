#include <stdio.h>
#include <string.h>
#include "morse.h"

int main(int argc, char *argv[])
{
    if(argc != 3)
    {
        printf("Usage:\n");
        printf("./my_morse.o -e <file>\n");
        printf("./my_morse.o -d <file>\n");
        return 1;
    }

    if(strcmp(argv[1], "-e") == 0)
    {
        encode_file(argv[2]);
    }
    else if(strcmp(argv[1], "-d") == 0)
    {
        decode_file(argv[2]);
    }
    else
    {
        printf("Invalid option\n");
    }

    return 0;
}