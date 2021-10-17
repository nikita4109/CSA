#include "documentary.h"
#include <cstdlib>

// Read documentary from file.
void documentary::Read(FILE *file) {
    film::Read(file);
    fscanf(file, "%d", &duration);
}

// Write documentary to file.
void documentary::Write(FILE *file) {
    fprintf(file, "%s", "documentary ");
    film::Write(file);
    fprintf(file, "%d%s", duration, " ");
}

void documentary::Random() {
	film::Random();
	duration = rand() % 400;
}
