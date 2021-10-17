#include "container.h"
#include "film.h"
#include <cstring>
#include "drama.h"
#include "documentary.h"
#include "cartoon.h"

char* ReadString(FILE*);

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
		char* type = ReadString(file);

		if (strcmp(type, "drama") == 0) {
			films[i] = new drama();
		} else if (strcmp(type, "cartoon") == 0) {
			films[i] = new cartoon();
		} else if (strcmp(type, "documentary") == 0) {
			films[i] = new documentary();
		} else {
			exit(1);
		}

    	films[i]->Read(file);
        free(type);
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
        int type = rand() % 3;
        if (type == 0) {
            films[i] = new drama();
        } else if (type == 1) {
            films[i] = new documentary();
        } else if (type == 2) {
            films[i] = new cartoon();
        }

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
