#ifndef THREADS__CONTAINER_H_
#define THREADS__CONTAINER_H_

#include <vector>
#include <mutex>
#include <atomic>
#include <condition_variable>
#include <optional>

class Container {
public:
    Container() = default;

    // Пытаемся взять элемент из контейнера, если он пуст ждем.
    std::optional<int64_t> take();

    // Кладем элемент в контейнер.
    void put(int64_t item);

    // Проверка на пустоту.
    bool empty();

    void finish();
    bool finished();

protected:
    std::vector<int64_t> items_;
    std::mutex mutex_;
    std::condition_variable condition_;

    // Индикатор того, что производитель закончил работу с данным контейнером.
    bool finished_ = false;
};

#endif //THREADS__CONTAINER_H_
