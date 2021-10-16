#include <cstring>
#include "film.h"

char *ReadString(FILE *file);
char *RandomString();
int RandomInt(int max);

film::film() {

}
film::film(int year, char *title) {
    this->year = year;
    this->title = title;
}

film::~film() {
    delete title;
    title = nullptr;
}

// Special function.
int film::Calculate() {
    int length = (int) strlen(title);

    return year / length;
}

// Read film from file.
void film::Read(FILE *file) {
    fscanf(file, "%d", &year);
    title = ReadString(file);
}

// Write film to file.
void film::Write(FILE *file) {
    fprintf(file, "%d", year);
    fprintf(file, "%s%s%s", " ", title, " ");
}

// Create random film.
void film::Random() {
    year = RandomInt(150) + 1900;
    title = RandomString();
}
