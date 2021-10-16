#include "container.h"
#include "film.h"

// Ctr for container.
struct container *CtrContainer(int length) {
    struct container *container = malloc(sizeof *container);
    container->length = length;
    container->films = calloc(length, sizeof(struct film*));

    return container;
}

// Dtr for container.
void DtrContainer(struct container *container) {
    for (int i = 0; i < container->length; ++i) {
        DtrFilm(container->films[i]);
    }

    free(container->films);
    container->films = NULL;

    free(container);
    container = NULL;
}

// Read container from file.
struct container *ReadContainer(FILE *file) {
    int length;
    fscanf(file, "%d", &length);

    struct container *container = CtrContainer(length);
    for (int i = 0; i < container->length; ++i) {
        container->films[i] = ReadFilm(file);
    }

    return container;
}

// Write container to file.
void WriteContainer(FILE *file, struct container *container) {
	fprintf(file, "%d%s", container->length, "\n");
    for (int i = 0; i < container->length; ++i) {
        WriteFilm(file, container->films[i]);
        fprintf(file, "%s", "\n");
    }
}

// Sort container.
void ShellSort(struct container *container) {
    for (int s = container->length / 2; s > 0; s /= 2) {
        for (int i = 0; i < container->length; i++) {
            for (int j = i + s; j < container->length; j += s) {
                if (Calculate(container->films[i]) > Calculate(container->films[j])) {
                    struct film* temp = container->films[i];
                    container->films[i] = container->films[j];
                    container->films[j] = temp;
                }
            }
        }
    }
}

// Create random container with [size] films.
struct container *RandomContainer(int size) {
    struct container* container = CtrContainer(size);
    for (int i = 0; i < size; ++i) {
        container->films[i] = RandomFilm();
    }

    return container;
}
