#ifndef container_h
#define container_h

#include "film.h"
#include <stdlib.h>

struct container {
    int length;
    struct film* (*films);
};

// Ctr for container.
struct container *CtrContainer(int length);

// Dtr for container.
void DtrContainer(struct container *container);


// Read container from file.
struct container *ReadContainer(FILE *file);

// Write contianer to file.
void WriteContainer(FILE *file, struct container *container);

// Create random container with [size] films
struct container *RandomContainer(int size);

// Sort container.
void ShellSort(struct container *container);

#endif
