#include "Container.h"

std::optional<int64_t> Container::take() {
    std::unique_lock lock(mutex_);

    // Ждем пока не разбудит и контейнер не будет пуст.
    condition_.wait(lock, [this]() { return finished_ || !items_.empty(); });

    std::optional<int> item;

    if (!items_.empty()) {
        item = items_.back();
        items_.pop_back();
    }

    return item;
}

void Container::put(int64_t item) {
    std::lock_guard lock(mutex_);
    items_.push_back(item);
    condition_.notify_all();
}

bool Container::empty() {
    std::lock_guard lock(mutex_);
    return items_.empty();
}

void Container::finish() {
    std::lock_guard lock(mutex_);
    finished_ = true;
}

bool Container::finished() {
    std::lock_guard lock(mutex_);
    return finished_;
}
