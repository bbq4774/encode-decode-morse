CC=gcc
CFLAGS=-Wall -O2 -Iinc

SRC=src/main.c src/morse.c

all: my_morse

my_morse:
	$(CC) $(CFLAGS) $(SRC) -o my_morse.o

clean:
	rm -f my_morse.o