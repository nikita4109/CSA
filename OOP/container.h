#ifndef container_h
#define container_h

#include "film.h"
#include <stdlib.h>

struct container {
public:
    int length;
    film *(*films);

    explicit container(int length);

    container() = default;

    ~container();

    // Read container from file.
    void Read(FILE *file);

    // Write container to file.
    void Write(FILE *file);

    // Create random container with [size] films
    void Random(int size);

    // Sort container.
    void ShellSort();
};

#endif
