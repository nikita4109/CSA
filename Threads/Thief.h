#ifndef THREADS__THIEF_H_
#define THREADS__THIEF_H_

#include "Storage.h"

#include <thread>
#include <utility>

class Thief {
public:
    Thief(Storage *storage, Container *place_near_truck);

    // Присоединение потока к основному.
    void join();

private:
    // Общая память.
    Storage *storage_;
    Container *place_near_truck_;

    // Новый запускаемый поток.
    std::unique_ptr<std::thread> thread_;

    // Метод, в котором происходит обработка.
    void work();
};

#endif //THREADS__THIEF_H_
