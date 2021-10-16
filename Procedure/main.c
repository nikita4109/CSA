#include <stdio.h>
#include <string.h>
#include <time.h>
#include "utilities.h"
#include "film.h"
#include "container.h"

void errMessage1() {
    printf("%s", "incorrect command line!\n"
                 "  Waited:\n"
                 "     command -f infile outfile01 outfile02\n"
                 "  Or:\n"
                 "     command -n number outfile01 outfile02\n");
}

void errMessage2() {
    printf("%s", "incorrect qualifier value!\n"
                 "  Waited:\n"
                 "     command -f infile outfile01 outfile02\n"
                 "  Or:\n"
                 "     command -n number outfile01 outfile02\n");
}

int main(int argc, char *argv[]) {
    srand(time(NULL));

    if (argc != 5) {
        errMessage1();
        return 1;
    }

    int isFile = 0;
    int size = 0;

    if (!strcmp(argv[1], "-f")) {
        isFile = 1;
    } else if (!strcmp(argv[1], "-n")) {
        size = atoi(argv[2]);
        if ((size < 1) || (size > 10000)) {
            printf("%s", "Incorrect number of figures, Set 0 < number <= 10000");
            return 3;
        }
    } else {
        errMessage2();
        return 2;
    }

	clock_t time_start = clock();

    struct container *container = NULL;

// First part
    if (isFile) {
        FILE *file = fopen(argv[2], "r");
        container = ReadContainer(file);
        fclose(file);
    } else {
        container = RandomContainer(size);
    }

    FILE *file = fopen(argv[3], "w");
    if (file == NULL) {
    	printf("Error opening file!\n");
    	exit(1);
	}

    WriteContainer(file, container);
    fclose(file);
//


// Second part

    file = fopen(argv[4], "w");
    if (file == NULL) {
        printf("Error opening file!\n");
        exit(1);
    }

    ShellSort(container);
    WriteContainer(file, container);
    fclose(file);
//


	if (container != NULL) {
		DtrContainer(container);
		container = NULL;
	}

	clock_t time_end = clock() - time_start;
	printf("%f%s", (double)time_end / CLOCKS_PER_SEC, "\n");

    return 0;
}
