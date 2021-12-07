#ifndef THREADS__ACCOUNTANT_H_
#define THREADS__ACCOUNTANT_H_

#include "Container.h"
#include <thread>

class Accountant {
public:
    explicit Accountant(Container *truck);

    // Присоединение потока к основному и возвращение баланса.
    int64_t getBalance() const;

private:
    // Общая память.
    Container *truck_;

    // Баланс.
    int64_t balance_ = 0;

    // Новый запускаемый поток.
    std::unique_ptr<std::thread> thread_;

    // Метод, в котором происходит обработка.
    void work();
};

#endif //THREADS__ACCOUNTANT_H_
