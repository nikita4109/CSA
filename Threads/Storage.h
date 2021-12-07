#ifndef THREADS__STORAGE_H_
#define THREADS__STORAGE_H_

#include <random>
#include "Container.h"
#include <iostream>

class Storage : public Container {
public:
    // Случайно заполняем контейнер.
    explicit Storage(int size);

private:
    const int kMaxCost = 10000;
};

#endif //THREADS__STORAGE_H_
