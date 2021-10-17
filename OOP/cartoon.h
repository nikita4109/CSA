#ifndef cartoon_h
#define cartoon_h

#include <cstdio>
#include "film.h"

enum typeOfAnimation { ANIMATION, STOPMOTION, CLAYMATION };

class cartoon : public film {
public:
    char *animation;

    cartoon() = default;

    ~cartoon() override;

    // Read cartoon from file.
    void Read(FILE *file) override;

    // Write cartoon to file.
    void Write(FILE *file) override;

    void Random() override;
};

#endif
