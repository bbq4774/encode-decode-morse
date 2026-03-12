# Morse Encoder / Decoder

Simple C program to **encode text to Morse** and **decode Morse to text**.

Dot is represented by "+", dash by "===" and space by " ".

Example: 
        A -\> +===      (.-)
        B -\> ===+++    (-...)
        E -\> +         (.)

------------------------------------------------------------------------

## Build

    make

This creates the executable:

    my_morse.o

Clean build:

    make clean

------------------------------------------------------------------------

## Usage

### Encode

    ./my_morse.o -e encode.txt

-   Reads text from "encode.txt"
-   Prints **first 20 output characters** to terminal
-   Saves full result to: encode_output.txt

### Decode

    ./my_morse.o -d decode.txt

-   Reads Morse code from "decode.txt"
-   Prints **first 20 output characters** to terminal
-   Saves full result to: decode_output.txt

------------------------------------------------------------------------

## Supported Characters

    A–Z
    0–9
    space

------------------------------------------------------------------------

## Morse Format

    dot  (.) = +
    dash (-) = ===

Example:

    HELLO
    ++++ + +===++ +===++ =========

------------------------------------------------------------------------

## Notes

-   Encoding optimized for large files (up to 10,000,000 characters)
-   Only first **20 characters** of output are printed to terminal
-   Full output is always written to file