#include "container.h"
#include "film.h"

container::container(int length) {
    this->length = length;
    films = new film *[length];
}

container::~container() {
    for (int i = 0; i < length; ++i) {
        delete films[i];
    }

    delete[] films;
}

// Read container from file.
void container::Read(FILE *file) {
    fscanf(file, "%d", &length);

    films = new film *[length];
    for (int i = 0; i < length; ++i) {
        films[i]->Read(file);
    }
}

// Write container to file.
void container::Write(FILE *file) {
    fprintf(file, "%d%s", length, "\n");
    for (int i = 0; i < length; ++i) {
        films[i]->Write(file);
        fprintf(file, "%s", "\n");
    }
}

// Create random container with [size] films.
void container::Random(int size) {
    length = size;
    films = new film *[length];

    for (int i = 0; i < size; ++i) {
        films[i]->Random();
    }

}

// Sort container.
void container::ShellSort() {
    for (int s = length / 2; s > 0; s /= 2) {
        for (int i = 0; i < length; i++) {
            for (int j = i + s; j < length; j += s) {
                if (films[i]->Calculate() > films[j]->Calculate()) {
                    film *temp = films[i];
                    films[i] = films[j];
                    films[j] = temp;
                }
            }
        }
    }
}
