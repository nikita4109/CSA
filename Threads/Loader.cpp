#include "Loader.h"

Loader::Loader(Container *place_near_truck, Container *truck) {
    place_near_truck_ = place_near_truck;
    truck_ = truck;

    thread_ = std::make_unique<std::thread>([this]() { work(); });
}

void Loader::work() {
    // Забираем предмет и кладем в грузовик.
    while (!place_near_truck_->finished() || !place_near_truck_->empty()) {
        auto item = place_near_truck_->take();
        if (item.has_value()) {
            truck_->put(item.value());
        }
    }

    // Помечаем, что все предметы загружены.
    truck_->finish();
}

void Loader::join() {
    thread_->join();
}
