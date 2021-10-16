#ifndef documentary_h
#define documentary_h

#include <cstdio>
#include "film.h"

class documentary : public film {
public:
    int duration;

    documentary() = default;

    ~documentary() override = default;

    // Read documentary from file.
    void Read(FILE *file) override;

    // Write documentary to file.
    void Write(FILE *file) override;
};

#endif
