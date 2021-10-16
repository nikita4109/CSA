#include "cartoon.h"

char *ReadString(FILE *file);

// Read cartoon from file.
void cartoon::Read(FILE *file) {
    film::Read(file);
    animation = ReadString(file);
}

// Write cartoon to file.
void cartoon::Write(FILE *file) {
    film::Write(file);
    fprintf(file, "%s%s", animation, " ");
}

cartoon::~cartoon() {
    delete[] animation;
}
