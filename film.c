#include <string.h>
#include "film.h"
#include "stdlib.h"

char *ReadString(FILE *file);
char *RandomString();
int RandomInt(int max);

struct film *CtrFilm(int year, char *title) {
    struct film *film = malloc(sizeof(struct film));
    film->year = year;
    film->title = title;

    return film;
}

void DtrFilm(struct film *film) {
    if (film->type == DRAMA) {
        DtrDrama(&film->drama);
    } else if (film->type == CARTOON) {
        DtrCartoon(&film->cartoon);
    } else if (film->type == DOCUMENTARY) {
        DtrDocumentary(&film->documentary);
    }

    free(film->title);
    film->title = NULL;

    free(film);
    film = NULL;
}

int Calculate(struct film *film) {
    int length = (int) strlen(film->title);

    return film->year / length;
}

struct film *ReadFilm(FILE *file) {
    int year;
    fscanf(file, "%d", &year);

    char *title = ReadString(file);
    struct film *film = CtrFilm(year, title);

    char *type;
    type = ReadString(file);

    if (strcmp(type, "drama") == 0) {
        ReadDrama(file, film);
    } else if (strcmp(type, "cartoon") == 0) {
        ReadCartoon(file, film);
    } else if (strcmp(type, "documentary") == 0) {
        ReadDocumentary(file, film);
    }

    return film;
}

void WriteFilm(FILE *file, struct film *film) {
    fprintf(file, "%d", film->year);
    fprintf(file, "%s%s%s", " ", film->title, " ");

    if (film->type == DRAMA) {
        WriteDrama(file, &film->drama);
    } else if (film->type == CARTOON) {
        WriteCartoon(file, &film->cartoon);
    } else if (film->type == DOCUMENTARY) {
        WriteDocumentary(file, &film->documentary);
    }
}

struct film* RandomFilm() {
    struct film* film = CtrFilm(RandomInt(150) + 1900, RandomString());

    int type = RandomInt(3);
    if (type == 0) {
        CtrDrama(film, RandomString());
    } else if (type == 1) {
        CtrCartoon(film, RandomInt(3));
    } else if (type == 2) {
        CtrDocumentary(film, RandomInt(290) + 10);
    }

    return film;
}
