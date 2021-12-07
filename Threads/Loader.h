#ifndef THREADS__LOADER_H_
#define THREADS__LOADER_H_

#include "Container.h"
#include <thread>

class Loader {
public:
    Loader(Container *place_near_truck, Container *truck);

    // Присоединение потока к основному.
    void join();

private:
    // Общая память.
    Container *place_near_truck_;
    Container *truck_;

    // Новый запускаемый поток.
    std::unique_ptr<std::thread> thread_;

    // Метод, в котором происходит обработка.
    void work();
};

#endif //THREADS__LOADER_H_
