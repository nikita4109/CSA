#include "drama.h"
#include <cstdlib>

char *ReadString(FILE *file);
char *RandomString();

drama::~drama() {
    free(director);
}

// Read drama from file.
void drama::Read(FILE *file) {
    film::Read(file);
    director = ReadString(file);
}

// Write drama to file.
void drama::Write(FILE *file) {
    fprintf(file, "%s", "drama ");
    film::Write(file);
    fprintf(file, "%s%s", director, " ");
}

void drama::Random() {
	film::Random();
	director = RandomString();
}
