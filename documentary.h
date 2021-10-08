#ifndef documentary_h
#define documentary_h

#include <stdio.h>

struct film;

struct documentary {
    int duration;
};

// Ctr for documenatary.
void CtrDocumentary(struct film *film, int duration);

// Dtr for documentary.
void DtrDocumentary(struct documentary *documentary);


// Read documentary from file.
void ReadDocumentary(FILE *file, struct film *film);

// Write documentary to file.
void WriteDocumentary(FILE *file, struct documentary *documentary);

#endif
