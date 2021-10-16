#ifndef film_h
#define film_h

#include <stdio.h>
#include "drama.h"
#include "cartoon.h"
#include "documentary.h"

enum typeOfFilm { DEFAULT, DRAMA, CARTOON, DOCUMENTARY };

struct film {
    union {
        struct drama drama;
        struct cartoon cartoon;
        struct documentary documentary;
    };

    enum typeOfFilm type;
    int year;
    char *title;
};

// Ctr for film.
struct film *CtrFilm(int year, char *title);

// Dtr for film.
void DtrFilm(struct film *film);


// Calculate special value.
int Calculate(struct film *film);


// Read film from file.
struct film *ReadFilm(FILE *file);

// Write film to file.
void WriteFilm(FILE *file, struct film *film);

// Create random film.
struct film* RandomFilm();

#endif
