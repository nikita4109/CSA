#ifndef cartoon_h
#define cartoon_h

#include <stdio.h>

struct film;

enum typeOfAnimation { ANIMATION, STOPMOTION, CLAYMATION };

struct cartoon {
    enum typeOfAnimation animation;
};

// Ctr for cartoon
void CtrCartoon(struct film *film, enum typeOfAnimation animation);

// Dtr for cartoon.
void DtrCartoon(struct cartoon *cartoon);


// Read cartoon from file.
void ReadCartoon(FILE *file, struct film *film);

// Write cartoon to file.
void WriteCartoon(FILE *file, struct cartoon *cartoon);

#endif
