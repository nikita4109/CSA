#include "Storage.h"

Storage::Storage(int size) {
    std::random_device dev;
    std::mt19937 rnd(dev());

    for (int i = 0; i < size; ++i) {
        items_.push_back(std::abs((int) rnd()) % kMaxCost);
    }
}
