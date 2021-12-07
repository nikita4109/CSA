#include "Accountant.h"

Accountant::Accountant(Container *truck) {
    truck_ = truck;

    // Запускаем новый поток.
    thread_ = std::make_unique<std::thread>([this]() { work(); });
}

void Accountant::work() {
    // Подсчитываем сумму предметов в грузовике.
    while (!truck_->finished() || !truck_->empty()) {
        auto item = truck_->take();
        if (item.has_value()) {
            balance_ += item.value();
        }
    }
}

int64_t Accountant::getBalance() const {
    thread_->join();
    return balance_;
}
