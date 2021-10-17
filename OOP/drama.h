#ifndef drama_h
#define drama_h

#include <cstdio>
#include "film.h"

class drama : public film {
public:
    char *director;

    drama() = default;

    ~drama() override;

    // Read drama from file.
    void Read(FILE *file) override;

    // Write drama to file.
    void Write(FILE *file) override;

    void Random() override;
};

#endif
