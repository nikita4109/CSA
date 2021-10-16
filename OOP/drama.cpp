#include "drama.h"
#include <cstdlib>

char *ReadString(FILE *file);

drama::~drama() {
    delete[] director;
}

// Read drama from file.
void drama::Read(FILE *file) {
    film::Read(file);
    director = ReadString(file);
}

// Write drama to file.
void drama::Write(FILE *file) {
    film::Write(file);
    fprintf(file, "%s%s%s", "drama ", director, " ");
}
