#include "documentary.h"
#include "film.h"

// Ctr for documentary.
void CtrDocumentary(struct film *film, int duration) {
    film->documentary.duration = duration;
    film->type = DOCUMENTARY;
}

// Dtr for documentary.
void DtrDocumentary(struct documentary *documentary) {
    // Nothing to destruct.
}

// Read documentary from file.
void ReadDocumentary(FILE *file, struct film *film) {
    fscanf(file, "%d", &film->documentary.duration);
    film->type = DOCUMENTARY;
}

// Write documentary to file.
void WriteDocumentary(FILE *file, struct documentary *documentary) {
    fprintf(file, "%s%d%s", "documentary ", documentary->duration, " ");
}
