#include "drama.h"
#include "film.h"
#include "stdlib.h"

char *ReadString(FILE *file);

// Ctr for drama.
void CtrDrama(struct film *film, char *director) {
    film->drama.director = director;
    film->type = DRAMA;
}

// Dtr for drama.
void DtrDrama(struct drama *drama) {
    free(drama->director);
    drama->director = NULL;
}

// Read drama from file.
void ReadDrama(FILE *file, struct film *film) {
    film->drama.director = ReadString(file);
    film->type = DRAMA;
}

// Write drama to file.
void WriteDrama(FILE *file, struct drama *drama) {
    fprintf(file, "%s%s%s", "drama ", drama->director, " ");
}
