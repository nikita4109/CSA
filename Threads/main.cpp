#include <iostream>
#include "Thief.h"
#include "Loader.h"
#include "Accountant.h"
#include <memory>

int main() {
    // Количество предметов в складе.
    int size;

    while (true) {
        try {
            std::cin >> size;
            if (size < 1) {
                std::cout << "Incorrect input." << '\n';
                continue;
            }

            break;
        } catch (...) {
            std::cout << "Incorrect input." << '\n';
        }
    }

    // Общая память.
    auto storage = std::make_unique<Storage>(size);
    auto place_near_truck = std::make_unique<Container>();
    auto truck = std::make_unique<Container>();

    // Объекты внутри запускающие новые потоки.
    Thief thief(storage.get(), place_near_truck.get());
    Loader loader(place_near_truck.get(), truck.get());
    Accountant accountant(truck.get());

    // Получаем результат работы.
    std::cout << accountant.getBalance() << '\n';
    thief.join();
    loader.join();

    return 0;
}
