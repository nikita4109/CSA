#include "Thief.h"

Thief::Thief(Storage *storage, Container *place_near_truck) {
    storage_ = storage;
    place_near_truck_ = place_near_truck;

    // Запускаем новый поток.
    thread_ = std::make_unique<std::thread>([this]() { work(); });
}

void Thief::work() {
    // Забираем из склада предмет и кладем рядом с грузовиком.s
    while (!storage_->empty()) {
        auto item = storage_->take();
        if (item.has_value()) {
            place_near_truck_->put(item.value());
        }
    }

    // Помечаем, что все предметы из склада забрали.
    place_near_truck_->finish();
}

void Thief::join() {
    thread_->join();
}
