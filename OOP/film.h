#ifndef film_h
#define film_h

#include <cstdio>

class film {
public:
    int year{};
    char *title{};

    film();

    film(int year, char *title);

    virtual ~film();

    // Calculate special value.
    int Calculate();

    // Read film from file.
    virtual void Read(FILE *file);

    // Write film to file.
    virtual void Write(FILE *file);

    // Create random film.
    virtual void Random();
};

#endif
