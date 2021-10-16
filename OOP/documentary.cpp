#include "documentary.h"

// Read documentary from file.
void documentary::Read(FILE *file) {
    film::Read(file);
    fscanf(file, "%d", &duration);
}

// Write documentary to file.
void documentary::Write(FILE *file) {
    film::Write(file);
    fprintf(file, "%s%d%s", "documentary ", duration, " ");
}
