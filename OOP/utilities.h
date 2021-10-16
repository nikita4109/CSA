#ifndef utilities_h
#define utilities_h

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <random>

std::random_device rd;
std::mt19937 rnd(rd());

// Read string until whitespace.
char *ReadString(FILE *file) {
    int size = 1, len = 0, c;
    char *str;

    str = new char[size];

    int skipSpaces = 1;
    while ((c = fgetc(file)) != EOF) {
        if (c == ' ') {
            if (skipSpaces) {
                continue;
            } else {
                break;
            }
        } else {
            skipSpaces = 0;
        }

        str[len++] = (char) c;
        if (len == size) {
            size += 16;
            str = (char *) realloc(str, sizeof(char) * (size));
        }
    }

    str[len++] = '\0';

    return (char *) realloc(str, sizeof(char) * len);
}

// Create random int less than max.
int RandomInt(int max) {
    return ((int)rnd()) % max;
}

// Create random string.
char *RandomString() {
    int size = RandomInt(10) + 1;
    char *string = new char[size + 1];
    string[size] = '\0';

    for (int i = 0; i < size; ++i) {
        string[i] = (char)('a' + RandomInt(26));
    }

    return string;
}

#endif
