#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include "morse.h"

/* =========================
   ENCODE TABLE (O(1) lookup)
   MORSE: dot = '+', dash = '==='
   ========================= */

static const char *morse_letters[26] =
{
"+===",        // A  .-
"===+++",      // B  -...
"===+===+",    // C  -.-.
"===++",       // D  -..
"+",           // E  .
"++===+",      // F  ..-.
"======+",     // G  --.
"++++",        // H  ....
"++",          // I  ..
"+=========",  // J  .---
"===+===",     // K  -.-
"+===++",      // L  .-..
"======",      // M  --
"===+",        // N  -.
"=========",   // O  ---
"+======+",    // P  .--.
"======+===",  // Q  --.-
"+===+",       // R  .-.
"+++",         // S  ...
"===",         // T  -
"++===",       // U  ..-
"+++===",      // V  ...-
"+======",     // W  .--
"===++===",    // X  -..-
"===+======",  // Y  -.--
"======++"     // Z  --..
};

static const char *morse_digits[10] =
{
"===========", // 0  -----
"+========",   // 1  .----
"++=======",   // 2  ..---
"+++======",   // 3  ...--
"++++=====",   // 4  ....-
"+++++",       // 5  .....
"=====++++",   // 6  -....
"======+++",   // 7  --...
"=======++",   // 8  ---..
"========+"    // 9  ----.
};

/*
    find_char()

    Purpose:
    Convert a Morse string into the corresponding character.

    Parameters:
    m : Morse string (ex: "+===")

    Return:
    Corresponding character (A-Z or 0-9)
    If no match is found, return '?' Error

    Method:
    Compare input Morse string with:
    - morse_letters table
    - morse_digits table
*/

static char find_char(const char *m)
{
    /* search in letter table (A-Z) */
    for(int i=0;i<26;i++)
        if(strcmp(m,morse_letters[i])==0)
            return 'A'+i;

    /* search in digit table (0-9) */
    for(int i=0;i<10;i++)
        if(strcmp(m,morse_digits[i])==0)
            return '0'+i;

    /* Error morse pattern */
    return '?';
}

/*
    encode_file()

    Purpose:
    Read a text file and convert its content to Morse code.

    Input:
    filename : input text file

    Output:
    - Morse code written to file "encode_output.txt"
    - First 20 characters printed to terminal

    Notes:
    - Letters are converted using direct lookup table (O(1))
    - Dot = '+'
    - Dash = '==='
*/

void encode_file(const char *filename)
{
    FILE *f = fopen(filename,"r");
    FILE *out = fopen("result.txt","w");

    if(!f || !out)
    {
        printf("Cannot open file\n");
        return;
    }

    int ch;                 // character read from input file
    int printed = 0;        // count characters printed to terminal (limit = 20)

    /* read file character by character */
    while((ch=fgetc(f))!=EOF)
    {
        if(ch==' ')
        {
            fprintf(out," ");

            if(printed < 20)
            {
                printf(" ");
                printed++;
            }

            continue;
        }

        const char *m = NULL;

        /* handle alphabet characters */
        if(isalpha(ch))
        {
            ch = toupper(ch);
            m = morse_letters[ch-'A'];
        }
        /* handle digits */
        else if(isdigit(ch))
        {
            m = morse_digits[ch-'0'];
        }

        if(m)
        {
            fprintf(out,"%s ",m);

            for(int i=0; m[i]; i++)
            {
                if(printed < 20)
                {
                    printf("%c",m[i]);
                    printed++;
                }
            }

            if(printed < 20)
            {
                printf(" ");
                printed++;
            }
        }
    }

    fprintf(out, "\n");
    printf("\n");

    fclose(f);
    fclose(out);
}

/*
    decode_file()

    Purpose:
    Convert Morse code back into plain text.

    Input:
    filename : Morse code file

    Morse format:
    '+' = dot
    '=' = part of dash (===)

    Rules:
    - Morse symbols separated by space
    - Two consecutive spaces = word space

    Output:
    - Full decoded text written to "decode_output.txt"
    - Only first 20 characters printed to terminal
*/
void decode_file(const char *filename)
{
    FILE *f = fopen(filename,"r");
    FILE *out = fopen("result.txt","w");

    if(!f || !out)
    {
        printf("Cannot open file\n");
        return;
    }

    char buffer[20];     // store one morse symbol temporarily
    int idx=0;           // current index inside buffer
    int printed = 0;     // number of characters printed to terminal

    int ch;

    /* read file character by character */
    while((ch=fgetc(f))!=EOF)
    {
        if(ch=='+' || ch=='=')
        {
            buffer[idx++] = ch;
            if (idx == 19)
            {
                write_error(out);

                /* log error */
                printf("\nInvalid Morse\n");
                fclose(f); 
                return; 
            }
        }
        /* space means end of one morse symbol */
        else if(ch==' ')
        {
            if(idx>0)
            {
                buffer[idx]='\0';
                char c = find_char(buffer);

                /* invalid morse */
                if (c == '?') 
                {
                    write_error(out);

                    /* log error */
                    printf("\nInvalid Morse\n");
                    fclose(f); 
                    return; 
                }

                fprintf(out,"%c",c);

                if(printed < 20)
                {
                    printf("%c",c);
                    printed++;
                }

                idx=0;
            }
            /* spaces */
            else
            {
                fprintf(out," ");

                if(printed < 20)
                {
                    printf(" ");
                    printed++;
                }
            }
        }
        else if(ch!='\n')
        {
            write_error(out);

            /* log error */
            printf("\nInvalid Morse\n");
            fclose(f); 
            return; 
        }
    }

    /* handle last morse symbol if file doesn't end with space */
    if(idx>0)
    {
        buffer[idx]='\0';
        char c = find_char(buffer);

        /* invalid morse */
        if (c == '?') 
        {
            write_error(out);

            /* log error */
            printf("\nInvalid Morse\n");
            fclose(f); 
            return; 
        }

        fprintf(out,"%c",c);

        if(printed < 20)
            printf("%c",c);
    }

    fprintf(out, "\n");
    printf("\n");

    fclose(f);
    fclose(out);
}

void write_error(FILE *file)
{
    /* close file */
    fclose(file); 

    /* re-open file to reset content in file */
    file = fopen("result.txt", "w"); 

    if (file != NULL) 
    {
        /* log error */
        fprintf(file, "Invalid Morse");
        fclose(file);
    }
}