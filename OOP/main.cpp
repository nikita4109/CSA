#include <cstdio>
#include <cstring>
#include <ctime>
#include "utilities.h"
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

FILE *OpenFile(char *file_name, const char *mode) {
    FILE *file = fopen(file_name, mode);
    if (file == nullptr) {
        printf("Error opening file!\n");
        exit(1);
    }

    return file;
}

int main(int argc, char *argv[]) {
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

    container container;

// First part
    if (isFile) {
        FILE *file = OpenFile(argv[2], "r");
        container.Read(file);
        fclose(file);
    } else {
        container.Random(size);
    }

    FILE *file = OpenFile(argv[3], "w");
    container.Write(file);
    fclose(file);
//


// Second part
    file = OpenFile(argv[4], "w");
    container.ShellSort();
    container.Write(file);
    fclose(file);
//

    clock_t time_end = clock() - time_start;
    printf("%f%s", (double) time_end / CLOCKS_PER_SEC, "\n");

    return 0;
}
