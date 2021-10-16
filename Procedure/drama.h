#ifndef drama_h
#define drama_h

#include <stdio.h>

struct film;

struct drama {
    char *director;
};

// Ctr for drama.
void CtrDrama(struct film *film, char *director);

// Dtr for drama.
void DtrDrama(struct drama *drama);

// Read drama from file.
void ReadDrama(FILE *file, struct film *film);

// Write drama to file.
void WriteDrama(FILE *file, struct drama *drama);

#endif
