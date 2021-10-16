#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include "cartoon.h"
#include "film.h"

char* ReadString(FILE* file);

// Ctr for cartoon.
void CtrCartoon(struct film *film, enum typeOfAnimation animation) {
    film->cartoon.animation = animation;
    film->type = CARTOON;
}

// Dtr for cartoon.
void DtrCartoon(struct cartoon *cartoon) {
    // Nothing to destruct.
}

// Read cartoon from file.
void ReadCartoon(FILE *file, struct film *film) {
    film->type = CARTOON;

    char *animation = ReadString(file);

    if (strcmp(animation, "animation") == 0) {
        film->cartoon.animation = ANIMATION;
    } else if (strcmp(animation, "stopmotion") == 0) {
        film->cartoon.animation = STOPMOTION;
    } else if (strcmp(animation, "claymotion") == 0) {
        film->cartoon.animation = CLAYMATION;
    }

    free(animation);
}

// Write cartoon to file.
void WriteCartoon(FILE *file, struct cartoon *cartoon) {
    fprintf(file, "%s", "cartoon ");
	if (cartoon->animation == ANIMATION) {
	    fprintf(file, "%s", "animation");
	} else if (cartoon->animation == STOPMOTION) {
	    fprintf(file, "%s", "stopmotion");
	} else if (cartoon->animation == CLAYMATION) {
	    fprintf(file, "%s", "claymation");
   	}

    fprintf(file, "%s", " ");
}
