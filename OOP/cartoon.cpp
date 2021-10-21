#include "cartoon.h"
#include <cstring>
#include <cstdlib>

char *ReadString(FILE *file);

// Read cartoon from file.
void cartoon::Read(FILE *file) {
    film::Read(file);
    animation = ReadString(file);
}

// Write cartoon to file.
void cartoon::Write(FILE *file) {
    fprintf(file, "%s", "cartoon ");
    film::Write(file);
    fprintf(file, "%s%s", animation, " ");
}

void Set(char *&animation, const char *str) {
    int len = strlen(str);
    animation = (char *)malloc(sizeof(char) * (len + 1));
    for (int i = 0; i < len; ++i) {
        animation[i] = str[i];
    }

    animation[len] = '\0';
}

void cartoon::Random() {
    film::Random();

    int type = rand() % 3;
    if (type == 0) {
        Set(animation, "stopmotion");
    } else if (type == 1) {
        Set(animation, "claymotion");
    } else {
        Set(animation, "animation");
    }
}

cartoon::~cartoon() {
	free(animation);
}

